library(jsonlite)
library(dplyr)

# functions
get_classifications <- function(class = "kunta_1_20200101", lang = "fi"){

  path <- paste0("https://data.stat.fi/api/classifications/v2/classifications/",class,"/classificationItems?content=data&format=json&lang=",lang,"&meta=max")
  res <- fromJSON(path) %>%
    as_tibble()
  if (nrow(res) == 0) return()
  dlist <- list()
  for (iv in 1:nrow(res)){
    dlist[[iv]] <- tibble(
      code = res$code[[iv]],
      name = res$classificationItemNames[[iv]]$name
    ) %>%
      mutate(code = as.character(code))
      # mutate(code = ifelse(grepl("[A-Za-z]", code), code, as.integer(code)))
  }
  do.call(bind_rows, dlist) -> dd
  return(dd)
}

#' Document an internal data
#'
#' @param dat data.frame
#' @param neim string name of the data
#' @param description Description of the data
#'
#' @export
document_data <- function(dat, neim, description = "Data is data"){

  rivit <- vector()
  rivit <- c(rivit,
             neim,"",
             description,"",
             paste0("@format A data frame with ",nrow(dat)," rows and ",ncol(dat)," variables:"),
             "\\describe{")
  nms <- names(dat)
  nms_rivit <- vector()
  for (i in seq_along(nms)) nms_rivit <- c(nms_rivit,paste0("\\item{",nms[i],"}{",nms[i],"}"))
  rivit <- c(rivit,nms_rivit,"}")
  rivit <- paste0("#' ", rivit)
  rivit <- c(rivit,paste0('"',neim,'"'))
  cat(rivit, sep = "\n")
}

# Municipalities
langs <- c("fi","sv","en")

# Lets loop over the years 2013-2022
yearlist <- list()
yrs <- 2013:2024
for (iii in seq_along(yrs)){

  print(yrs[iii])
  Sys.sleep(20)

  kuntaclass <- paste0("kunta_1_",yrs[iii],"0101")

lst <- list()
for (i in seq_along(langs)){
  tmp <- get_classifications(class = kuntaclass, lang = langs[i])
  names(tmp) <- c("kunta", paste0("name_",langs[i]))
  lst[[i]] <- tmp
}
d_muni <- left_join(lst[[1]],lst[[2]]) %>%
  left_join(lst[[3]]) %>%
  mutate(kunta = as.character(as.integer(kunta)))


# Get the available correspondenceTables
corrtbls <- fromJSON("https://data.stat.fi/api/classifications/v2/correspondenceTables?format=json") %>%
  as_tibble()
# filter ones with kunta_1_20200101 as input key
corrtbls_kunta <- corrtbls[grepl(paste0("/",kuntaclass,"#"), corrtbls$value),]

# lets list the output keys
outkeys <- sub("\\?format=json", "",
    sub(".+#", "", corrtbls_kunta$value)
    )

outdatlist <- list()
for (ii in seq_along(outkeys)){
res <- fromJSON(paste0("https://data.stat.fi/api/classifications/v2/correspondenceTables/",kuntaclass,"%23",outkeys[ii],"/maps?format=json")) %>%
  as_tibble()
vals <- sub("\\?format=json", "", sub("^.+maps/", "", res$value))

keyname <- paste0(sub("_.+$", "", outkeys[ii]))

keydat <- read.table(text = vals, sep="/") %>%
  setNames(c("kunta", paste0(keyname,"_code"))) %>%
  as_tibble() %>%
  mutate_all(as.character)

lst <- list()
for (i in seq_along(langs)){
  tmp <- get_classifications(class = outkeys[ii], lang = langs[i])
  if (is.null(tmp)) next()
  names(tmp) <- c(paste0(keyname,"_code"), paste0(keyname,"_",langs[i]))
  lst[[i]] <- tmp
}
if (length(lst) > 0){
class_dat <- Reduce(function(...) merge(..., by=paste0(keyname,"_code"), all.x=TRUE), lst)
if (keyname == "nuts"){
  # nuts-names wide
  keydat$level <- nchar(keydat$nuts_code)-2
  keydat %>%
    filter(level == 1) %>%
    select(-level) %>%
    rename(nuts1_code = nuts_code) -> keydat1
  keydat %>%
    filter(level == 2) %>%
    select(-level) %>%
    rename(nuts2_code = nuts_code) -> keydat2
  keydat %>%
    filter(level == 3) %>%
    select(-level) %>%
    rename(nuts3_code = nuts_code) -> keydat3

  class_dat %>%
  mutate(level = nchar(nuts_code)-2) -> tmp
  tmp %>%
    filter(level == 1) %>%
    select(-level) %>%
    setNames(sub("_","1_", names(.))) %>%
    left_join(keydat1) -> outdatlist[[ii + 11]]
  tmp %>%
    filter(level == 2) %>%
    select(-level) %>%
    setNames(sub("_","2_", names(.))) %>%
    left_join(keydat2) -> outdatlist[[ii + 12]]
  tmp %>%
    filter(level == 3) %>%
    select(-level) %>%
    setNames(sub("_","3_", names(.))) %>%
    left_join(keydat3) -> outdatlist[[ii + 13]]
} else {
  class_dat[[paste0(keyname,"_code")]] <- as.character(as.integer(class_dat[[paste0(keyname,"_code")]]))
  outdatlist[[ii]] <- left_join(keydat, class_dat)
}
}
}
outdatlist2 <- outdatlist[!sapply(outdatlist,is.null)]
datout <- Reduce(function(...) merge(..., by='kunta', all.x=TRUE), outdatlist2)
yearlist[[iii]] <- left_join(d_muni,datout) %>%
  mutate(year = yrs[iii])
}
ddd <- do.call(bind_rows, yearlist)


# lets rename variables
nms <- names(ddd)
nms <- sub("_fi", "_name_fi", nms)
nms <- sub("_en", "_name_en", nms)
nms <- sub("_sv", "_name_sv", nms)

ddd2 <- ddd
names(ddd2) <- nms


# lets create few new variables
ddd3 <- ddd2 %>%
  mutate(municipality_code = kunta) %>%
  rename(municipality_name_fi = name_name_fi,
         municipality_name_sv = name_name_sv,
         municipality_name_en = name_name_en) %>%
  mutate(kunta_name = municipality_name_fi,
         name_fi = municipality_name_fi,
         name_sv = municipality_name_sv)

# erva-regions can be found from sairaanhoitp <-> erva table
# lets use the 2021 version as there has been no changes
## https://www2.stat.fi/fi/luokitukset/luokitustiedotteet/
res <- fromJSON(paste0("https://data.stat.fi/api/classifications/v2/correspondenceTables/sairaanhoitop_1_20220101%23erva_3_20220101/maps?format=json")) %>%
  as_tibble()
vals <- sub("\\?format=json", "", sub("^.+maps/", "", res$value))
keydat <- read.table(text = vals, sep="/") %>%
  setNames(c("sairaanhoitop_code", "erva_code")) %>%
  as_tibble() %>%
  mutate_all(as.character)

lst <- list()
for (i in seq_along(langs)){
  tmp <- get_classifications(class = "erva_3_20220101", lang = langs[i])
  if (is.null(tmp)) next()
  names(tmp) <- c("erva_code", paste0("erva_name_",langs[i]))
  lst[[i]] <- tmp
}

class_dat <- Reduce(function(...) merge(..., by="erva_code", all.x=TRUE), lst)
ddx <- left_join(keydat,class_dat) #%>%


ddd4 <- ddd3 %>%
  left_join(ddx) %>%
  mutate_at(.vars = vars(kunta,ends_with("_code")),
            .funs = function(x) ifelse(grepl("[A-Za-z]", x), x, as.integer(x))) %>%
  # erva only applies to years 2018 onwards
  mutate_at(.vars = vars(contains("erva")), .funs = function(x) ifelse(.$year < 2018, NA, x))


# Case Maarianhamina
ddd4$kunta_name[ddd4$kunta_name == "Maarianhamina - Mariehamn"] <- "Maarianhamina"
ddd4$municipality_name_fi[ddd4$municipality_name_fi == "Maarianhamina - Mariehamn"] <- "Maarianhamina"


# adding Kela vakuutuspiirit
## Last checked 20230416
## HUOM! KELAN VERKKOSIVUT UUDISTUNEET EIKÄ NIITÄ VOI ENÄÄ SKREIPATA ENTISEEN TAPAAN!!
## SKREIPPAUSKOODIT KOMMENTOITU POIS, LISTAT TÄYTYY KÄSIN PÄIVITTÄÄ
# library(httr)
# library(stringr)
# res <- httr::GET("https://www.kela.fi/vakuutuspiirit")
# cont <- content(x = res, "text")

# Eteläinen
# gsub("^.*Eteläinen", "", cont) %>%
#   gsub("</p>.*$", "", .) %>%
#   gsub("^.*<p>", "", .) %>%
#   gsub(" ja", ",", .) %>%
#   gsub("\\.", "", .) %>%
#   gsub(", ", ",", .) %>%
#   gsub(" ", ",", .) %>%
#   str_split(string = ., pattern = ",") %>%
#   unlist() -> etelainen
#
# dput(etelainen)
etelainen <- c("Asikkala", "Askola", "Espoo", "Hamina", "Hanko", "Hartola",
  "Heinola", "Helsinki", "Hollola", "Hyvinkää", "Hämeenkoski",
  "Iitti", "Imatra", "Inkoo", "Järvenpää", "Karkkila", "Kauniainen",
  "Kerava", "Kirkkonummi", "Kotka", "Kouvola", "Kärkölä", "Lahti",
  "Lapinjärvi", "Lappeenranta", "Lemi", "Lohja", "Loviisa", "Luumäki",
  "Miehikkälä", "Myrskylä", "Mäntsälä", "Nastola", "Nurmijärvi",
  "Orimattila", "Padasjoki", "Parikkala", "Pornainen", "Porvoo",
  "Pukkila", "Pyhtää", "Raasepori", "Rautjärvi", "Ruokolahti",
  "Savitaipale", "Sipoo", "Siuntio", "Sysmä", "Taipalsaari", "Tuusula",
  "Vantaa", "Vihti", "Virolahti")

# Itäinen
# gsub("^.*Itäinen", "", cont) %>%
#   gsub("</p>.*$", "", .) %>%
#   gsub("^.*<p>", "", .) %>%
#   gsub(" ja", ",", .) %>%
#   gsub("\\.", "", .) %>%
#   gsub(", ", ",", .) %>%
#   gsub(" ", ",", .) %>%
#   str_split(string = ., pattern = ",") %>%
#   unlist() -> itainen
#
# dput(itainen)
itainen <- c("Enonkoski", "Hankasalmi", "Heinävesi", "Hirvensalmi", "Iisalmi",
             "Ilomantsi", "Joensuu", "Joroinen", "Joutsa", "Juankoski", "Juuka",
             "Juva", "Jyväskylä", "Jämsä", "Kaavi", "Kangasniemi", "Kannonkoski",
             "Karstula", "Keitele", "Keuruu", "Kinnula", "Kitee", "Kiuruvesi",
             "Kivijärvi", "Konnevesi", "Kontiolahti", "Kuhmoinen", "Kuopio",
             "Kyyjärvi", "Lapinlahti", "Laukaa", "Leppävirta", "Lieksa",
             "Liperi", "Luhanka", "Mikkeli", "Multia", "Muurame", "Mäntyharju",
             "Nurmes", "Outokumpu", "Pihtipudas", "Pertunmaa", "Petäjävesi",
             "Pieksämäki", "Pielavesi", "Puumala", "Polvijärvi", "Rantasalmi",
             "Rautalampi", "Rautavaara", "Rääkkylä", "Saarijärvi", "Savonlinna",
             "Siilinjärvi", "Sonkajärvi", "Sulkava", "Suonenjoki", "Tervo",
             "Tohmajärvi", "Toivakka", "Tuusniemi", "Uurainen", "Varkaus",
             "Vesanto", "Vieremä", "Viitasaari", "Äänekoski")


# Keskinen
# gsub("^.*Keskinen", "", cont) %>%
#   gsub("</p>.*$", "", .) %>%
#   gsub("^.*<p>", "", .) %>%
#   gsub(" ja", ",", .) %>%
#   gsub("\\.", "", .) %>%
#   gsub(", ", ",", .) %>%
#   gsub(" ", ",", .) %>%
#   str_split(string = ., pattern = ",") %>%
#   unlist() -> keskinen
#
# dput(keskinen)
keskinen <- c("Akaa", "Alajärvi", "Alavus", "Evijärvi", "Forssa", "Hattula",
              "Hausjärvi", "Humppila", "Hämeenkyrö", "Hämeenlinna", "Ikaalinen",
              "Ilmajoki", "Isojoki", "Isokyrö", "Janakkala", "Jokioinen",
              "Juupajoki", "Kangasala", "Karijoki", "Kauhajoki", "Kauhava",
              "Kihniö", "Kuortane", "Kurikka", "Lappajärvi", "Lapua", "Lempäälä",
              "Loppi", "Mänttä-Vilppula", "Nokia", "Orivesi", "Parkano",
              "Pirkkala", "Punkalaidun", "Pälkäne", "Riihimäki", "Ruovesi",
              "Sastamala", "Seinäjoki", "Soini", "Tammela", "Tampere", "Teuva",
              "Urjala", "Valkeakoski", "Vesilahti", "Vimpeli", "Virrat", "Ylöjärvi",
              "Ypäjä", "Ähtäri")

# Läntinen
# gsub("^.*Läntinen", "", cont) %>%
#   gsub("</p>.*$", "", .) %>%
#   gsub("^.*<p>", "", .) %>%
#   gsub(" ja", ",", .) %>%
#   gsub("\\.", "", .) %>%
#   gsub(", ", ",", .) %>%
#   gsub(" ", ",", .) %>%
#   str_split(string = ., pattern = ",") %>%
#   unlist() -> lantinen
#
# lantinen <- lantinen[lantinen != "TL"]
# lantinen[lantinen == "Koski"] <- "Koski Tl"
# lantinen[lantinen == "Pedersören"] <- "Pedersören kunta"

# dput(lantinen)
lantinen <- c("Aura", "Eura", "Eurajoki", "Harjavalta", "Honkajoki", "Huittinen",
              "Jämijärvi", "Kaarina", "Kankaanpää", "Karvia", "Kaskinen",
              "Kemiönsaari", "Kokemäki", "Korsnäs", "Koski Tl", "Kristiinankaupunki",
              "Kustavi", "Köyliö", "Laihia", "Laitila", "Lavia", "Lieto",
              "Loimaa", "Luoto", "Luvia", "Maalahti", "Maarianhamina", "Marttila",
              "Masku", "Merikarvia", "Mustasaari", "Mynämäki", "Naantali",
              "Nakkila", "Nousiainen", "Närpiö", "Oripää", "Paimio", "Parainen",
              "Pedersören kunta", "Pietarsaari", "Pomarkku", "Pori", "Pyhäranta",
              "Pöytyä", "Raisio", "Rauma", "Rusko", "Salo", "Sauvo", "Siikainen",
              "Somero", "Sund", "Säkylä", "Taivassalo", "Turku", "Ulvila",
              "Uusikaarlepyy", "Uusikaupunki", "Vaasa", "Vehmaa", "Vöyri")

# Pohjoinen
# gsub("^.*Pohjoinen", "", cont) %>%
#   gsub("</p>.*$", "", .) %>%
#   gsub("^.*<p>", "", .) %>%
#   gsub(" ja", ",", .) %>%
#   gsub("\\.", "", .) %>%
#   gsub(", ", ",", .) %>%
#   gsub(" ", ",", .) %>%
#   str_split(string = ., pattern = ",") %>%
#   unlist() -> pohjoinen
#
# dput(pohjoinen)
pohjoinen <- c("Alavieska", "Enontekiö", "Hailuoto", "Haapajärvi", "Halsua",
               "Haapavesi", "Hyrynsalmi", "Ii", "Inari", "Kajaani", "Kalajoki",
               "Kannus", "Kaustinen", "Kemi", "Kempele", "Kemijärvi", "Keminmaa",
               "Kittilä", "Kokkola", "Kolari", "Kruunupyy", "Kuhmo", "Kuusamo",
               "Kärsämäki", "Lestijärvi", "Liminka", "Lumijoki", "Merijärvi",
               "Muonio", "Muhos", "Nivala", "Oulu", "Oulainen", "Paltamo", "Pelkosenniemi",
               "Pello", "Perho", "Posio", "Pudasjärvi", "Puolanka", "Pyhäjoki",
               "Pyhäjärvi", "Pyhäntä", "Raahe", "Ranua", "Reisjärvi", "Ristijärvi",
               "Rovaniemi", "Salla", "Savukoski", "Sievi", "Siikajoki", "Siikalatva",
               "Simo", "Sodankylä", "Sotkamo", "Suomussalmi", "Taivalkoski",
               "Tervola", "Toholampi", "Tornio", "Tyrnävä", "Utajärvi", "Utsjoki",
               "Vaala", "Veteli", "Ylivieska", "Ylitornio")

# Kelan kela_vakuutuspiirit
key <- ddd4 %>% distinct(kunta_name)


kuntaluokitusavain <- key %>%
  mutate(
    kela_vakuutuspiiri_name_fi = case_when(
      kunta_name %in% etelainen ~ "Eteläinen vakuutuspiiri",
      kunta_name %in% itainen ~ "Itäinen vakuutuspiiri",
      kunta_name %in% keskinen ~ "Keskinen vakuutuspiiri",
      kunta_name %in% lantinen ~ "Läntinen vakuutuspiiri",
      kunta_name %in% pohjoinen ~ "Pohjoinen vakuutuspiiri",
      TRUE ~ ""
    )) %>%
  mutate(
    kela_vakuutuspiiri_code = case_when(
      kunta_name %in% etelainen ~ 1,
      kunta_name %in% itainen ~ 4,
      kunta_name %in% keskinen ~ 3,
      kunta_name %in% lantinen ~ 2,
      kunta_name %in% pohjoinen ~ 5,
      TRUE ~ 0
    ),
    kela_vakuutuspiiri_code = ifelse(kela_vakuutuspiiri_code == 0, NA, kela_vakuutuspiiri_code),
    kela_vakuutuspiiri_name_fi = ifelse(kela_vakuutuspiiri_name_fi == "", NA, kela_vakuutuspiiri_name_fi)) %>%
  as_tibble() %>%
  # Puuttuvat ovat Ahvenanmaalta ja kuuluvat läntiseen vakuutuspiiriin
  mutate(kela_vakuutuspiiri_name_fi = ifelse(is.na(kela_vakuutuspiiri_name_fi),
                                             "Läntinen vakuutuspiiri",
                                             kela_vakuutuspiiri_name_fi),
         kela_vakuutuspiiri_code = ifelse(is.na(kela_vakuutuspiiri_code),
                                          2,
                                          kela_vakuutuspiiri_code)) %>%
  # på Svenska - manually copied from https://www.kela.fi/web/sv/forsakringsdistrikten
  mutate(kela_vakuutuspiiri_name_sv = case_when(
    kela_vakuutuspiiri_name_fi == "Eteläinen vakuutuspiiri" ~ "Södra försäkringsdistriktet",
    kela_vakuutuspiiri_name_fi == "Itäinen vakuutuspiiri" ~ "Östra försäkringsdistriktet",
    kela_vakuutuspiiri_name_fi == "Keskinen vakuutuspiiri" ~ "Mellersta försäkringsdistriktet",
    kela_vakuutuspiiri_name_fi == "Läntinen vakuutuspiiri" ~ "Västra försäkringsdistriktet",
    kela_vakuutuspiiri_name_fi == "Pohjoinen vakuutuspiiri" ~ "Norra försäkringsdistriktet"
  )) %>%
  # In English - manually copied from https://www.kela.fi/web/en/business-units-insurance-districts
  mutate(kela_vakuutuspiiri_name_en = case_when(
    kela_vakuutuspiiri_name_fi == "Eteläinen vakuutuspiiri" ~ "Southern Insurance District",
    kela_vakuutuspiiri_name_fi == "Itäinen vakuutuspiiri" ~ "Eastern Insurance District",
    kela_vakuutuspiiri_name_fi == "Keskinen vakuutuspiiri" ~ "Central Insurance District",
    kela_vakuutuspiiri_name_fi == "Läntinen vakuutuspiiri" ~ "Western Insurance District",
    kela_vakuutuspiiri_name_fi == "Pohjoinen vakuutuspiiri" ~ "Northern Insurance District"
  ))

# manually extracted from https://www.kela.fi/asunto-ja-asumismenot
## Last checked 20220127
kuntaluokitusavain$kela_asumistukialue_name_fi <- NA
kuntaluokitusavain$kela_asumistukialue_name_fi <- ifelse(kuntaluokitusavain$kunta_name %in%c("Helsinki"),
                                                      "I kuntaryhmä",
                                                      kuntaluokitusavain$kela_asumistukialue_name_fi)
kuntaluokitusavain$kela_asumistukialue_name_fi <- ifelse(kuntaluokitusavain$kunta_name %in%c("Espoo", "Kauniainen", "Vantaa"),
                                                      "II kuntaryhmä",
                                                      kuntaluokitusavain$kela_asumistukialue_name_fi)
kuntaluokitusavain$kela_asumistukialue_name_fi <- ifelse(kuntaluokitusavain$kunta_name %in%c("Hyvinkää", "Hämeenlinna", "Joensuu",
                                                                                          "Jyväskylä", "Järvenpää", "Kajaani",
                                                                                          "Kerava", "Kirkkonummi", "Kouvola",
                                                                                          "Kuopio", "Lahti", "Lappeenranta",
                                                                                          "Lohja", "Mikkeli", "Nokia", "Nurmijärvi",
                                                                                          "Oulu", "Pori", "Porvoo", "Raisio",
                                                                                          "Riihimäki", "Rovaniemi", "Seinäjoki",
                                                                                          "Sipoo", "Siuntio", "Tampere", "Turku",
                                                                                          "Tuusula", "Vaasa", "Vihti"),
                                                      "III kuntaryhmä",
                                                      kuntaluokitusavain$kela_asumistukialue_name_fi)
kuntaluokitusavain$kela_asumistukialue_name_fi <- ifelse(is.na(kuntaluokitusavain$kela_asumistukialue_name_fi),
                                                      "IV kuntaryhmä",
                                                      kuntaluokitusavain$kela_asumistukialue_name_fi)

kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name_fi == "I kuntaryhmä"] <- 1
kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name_fi == "II kuntaryhmä"] <- 2
kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name_fi == "III kuntaryhmä"] <- 3
kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name_fi == "IV kuntaryhmä"] <- 4

kuntaluokitusavain_kela <- kuntaluokitusavain %>%
  # manually extracted from https://www.kela.fi/web/sv/bostad-och-boendeutgifter
mutate(kela_asumistukialue_name_sv = case_when(
  kela_asumistukialue_name_fi == "I kuntaryhmä" ~ "Kommungrupp I",
  kela_asumistukialue_name_fi == "II kuntaryhmä" ~ "Kommungrupp II",
  kela_asumistukialue_name_fi == "III kuntaryhmä" ~ "Kommungrupp III",
  kela_asumistukialue_name_fi == "IV kuntaryhmä" ~ "Kommungrupp IV"
)) %>%
  # manually extracted from https://www.kela.fi/web/en/housing-costs-and-types-of-homes
  mutate(kela_asumistukialue_name_en = case_when(
    kela_asumistukialue_name_fi == "I kuntaryhmä" ~ "Municipality in category I",
    kela_asumistukialue_name_fi == "II kuntaryhmä" ~ "Municipality in category II",
    kela_asumistukialue_name_fi == "III kuntaryhmä" ~ "Municipality in category III",
    kela_asumistukialue_name_fi == "IV kuntaryhmä" ~ "Municipality in category IV"
  )) %>%
  # Kela-spesific classifications only for latest year as there is no history available as open data
  mutate(year = 2024)


# Lets rename the Finnish version of Maarianhamina
municipality_key <- left_join(ddd4,kuntaluokitusavain_kela)



# per year municipality keys
yrs <- unique(municipality_key$year)
for (i in seq_along(yrs)){
  tmpx1 <- municipality_key[municipality_key$year == yrs[i],]
  tmpx2 <- tmpx1[,colSums(is.na(tmpx1))<nrow(tmpx1)]
  assign(x = paste0("municipality_key_", yrs[i]), value = tmpx2)

  do.call(save, list(paste0("municipality_key_", yrs[i]), file=paste0("./data/",paste0("municipality_key_", yrs[i]),".rda"), compress = "bzip2"))
}

# Finally lets add the whole lot as a new data
save(municipality_key, file = "./data/municipality_key.rda",
     compress = "bzip2")

# Lisätään hyvinvointialuetieto myös vuosille 2018-2020

hyvinvointi_columns <- municipality_key_2022 %>% select(municipality_code, contains("hyvinvointialue"))

# 2020
load("./data/municipality_key_2020.rda")
hyvinvointialue <- municipality_key_2020 %>%
  select(-contains("hyvinvointialue")) %>%
  left_join(hyvinvointi_columns)

municipality_key_2020 <- hyvinvointialue
save(municipality_key_2020, file = "./data/municipality_key_2020.rda",
     compress = "bzip2")

# 2019
load("./data/municipality_key_2019.rda")
hyvinvointialue <- municipality_key_2019 %>%
  select(-contains("hyvinvointialue")) %>%
  left_join(hyvinvointi_columns)

municipality_key_2019 <- hyvinvointialue
save(municipality_key_2019, file = "./data/municipality_key_2019.rda",
     compress = "bzip2")

# 2018
load("./data/municipality_key_2018.rda")
hyvinvointialue <- municipality_key_2018 %>%
  select(-contains("hyvinvointialue")) %>%
  left_join(hyvinvointi_columns)

municipality_key_2018 <- hyvinvointialue
save(municipality_key_2018, file = "./data/municipality_key_2018.rda",
     compress = "bzip2")

# the whole lot
load("./data/municipality_key.rda")

municipality_key_without_2018_2020 <- municipality_key %>% filter(!year %in% 2018:2020)

# In case hyvinvointialue_code is turned to chr ("03") instead of integer (3)
# This is necessary to prevent the following error:
# "Can't combine `..1$hyvinvointialue_code` <integer> and `..2$hyvinvointialue_code` <character>."
# municipality_key_without_2018_2021$hyvinvointialue_code <- as.character(municipality_key_without_2018_2021$hyvinvointialue_code)

municipality_key_new <- bind_rows(municipality_key_without_2018_2020,
                                  municipality_key_2018,
                                  municipality_key_2019,
                                  municipality_key_2020)
municipality_key <- municipality_key_new
save(municipality_key, file = "./data/municipality_key.rda",
     compress = "bzip2")


# lets create boilerplates for data documentation for data.R using document_data()
if (FALSE){
  document_data(dat = municipality_key_2021,
                neim = "municipality_key_2022",
                description = "Table for aggregating municipality level data to various regional groupings")

  document_data(dat = municipality_key_2022,
                neim = "municipality_key_2013",
                description = "Table for aggregating municipality level data to various regional groupings")
}


