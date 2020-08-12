#' This script is no longer used!
#'
#'
#' #    ____   __    ____                     _
#' #   |  _ \ (())  / ___|_   _____ _ __  ___| | ____ _
#' #   | |_) / _ '| \___ \ \ / / _ \ '_ \/ __| |/ / _` |
#' #   |  __/ (_| |  ___) \ V /  __/ | | \__ \   < (_| |
#' #   |_|   \__,_| |____/ \_/ \___|_| |_|___/_|\_\__,_|
#' #
#'
#' # Tässä luodaan data, jossa eri alueluokitukset ruotsiksiksi
#' #
#' # Alempana luodaan ko. data, sitä ennen tehdään funktio posvenska jolla käännetään kukin avain
#' #
#' #
#' #
#' # key <- readRDS("./rds/kunta_luokitusavain_17.RDS") %>% as_tibble()
#'
#' # posvenska <- function(avain){
#' #   key <- readRDS(./"_local_data/svenska.RDS")
#' # }
#'
#' if (FALSE){
#'   library(dplyr)
#'
#'   svenska <- tibble()
#'
#'   # kunta_avi_teksti,
#'   dat <- data_frame()
#'   for (y in c("10","11","12","13","14","15","16","17","18")){
#'     tmp <- read.table(paste0("https://www.stat.fi/meta/luokitukset/avi/001-20",y,"/tekstitiedosto_sv.txt"),
#'                       header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#'     # names(tmp) <- c("kuntanro","kuntanimi","avi_koodi","avi_nimi")
#'     tmp$vuosi <- paste0("20",y)
#'     tmp$kod <- as.character(tmp$kod)
#'     dat <- bind_rows(dat,tmp)
#'   }
#'   svenska <- bind_rows(svenska,dat %>% mutate(type = "avi"))
#'
#'   # kunta_ely_teksti,
#'   dat <- data_frame()
#'   for (y in c("10","11","12","13","14","15","16","17","18")){
#'     tmp <- read.table(paste0("https://www.stat.fi/meta/luokitukset/ely/001-20",y,"/tekstitiedosto_sv.txt"),
#'                       header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#'     # names(tmp) <- c("kuntanro","kuntanimi","avi_koodi","avi_nimi")
#'     tmp$vuosi <- paste0("20",y)
#'     tmp$kod <- as.character(tmp$kod)
#'     dat <- bind_rows(dat,tmp)
#'   }
#'   svenska <- bind_rows(svenska,dat %>% mutate(type = "ely"))
#'
#'   # kunta_kunta_teksti,
#'   dat <- data_frame()
#'   for (y in c("08","09","10","11","12","13","14","16","17","18")){
#'     tmp <- read.table(paste0("https://www.stat.fi/meta/luokitukset/kunta/001-20",y,"/tekstitiedosto_sv.txt"),
#'                       header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#'     # names(tmp) <- c("kuntanro","kuntanimi","avi_koodi","avi_nimi")
#'     tmp$vuosi <- paste0("20",y)
#'     tmp$kod <- as.character(tmp$kod)
#'     dat <- bind_rows(dat,tmp)
#'   }
#'   svenska <- bind_rows(svenska,dat %>% mutate(type = "kunta"))
#'
#'   # kunta_kr_teksti,
#'   dat <- data_frame()
#'   for (y in c("09","10","11","13","14","15","16","17")){
#'     tmp <- read.table(paste0("https://www.stat.fi/meta/luokitukset/kuntaryhmitys/001-20",y,"/tekstitiedosto_sv.txt"),
#'                       header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#'     # names(tmp) <- c("kuntanro","kuntanimi","avi_koodi","avi_nimi")
#'     tmp$vuosi <- paste0("20",y)
#'     tmp$kod <- as.character(tmp$kod)
#'     dat <- bind_rows(dat,tmp)
#'   }
#'   svenska <- bind_rows(svenska,dat %>% mutate(type = "kr"))
#'
#'   # kunta_mk_teksti,
#'   dat <- data_frame()
#'   for (y in c("08","09","10","11","12","13","14","15","16","17","18")){
#'     tmp <- read.table(paste0("https://www.stat.fi/meta/luokitukset/maakunta/001-20",y,"/tekstitiedosto_sv.txt"),
#'                       header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#'     # names(tmp) <- c("kuntanro","kuntanimi","avi_koodi","avi_nimi")
#'     tmp$vuosi <- paste0("20",y)
#'     tmp$kod <- as.character(tmp$kod)
#'     dat <- bind_rows(dat,tmp)
#'   }
#'   svenska <- bind_rows(svenska,dat %>% mutate(type = "mk"))
#'
#'   # kunta_sa_teksti,
#'   dat <- data_frame()
#'   for (y in c("09","10","11","12","13","14","18")){
#'     tmp <- read.table(paste0("https://www.stat.fi/meta/luokitukset/suuralue/001-20",y,"/tekstitiedosto_sv.txt"),
#'                       header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#'     # names(tmp) <- c("kuntanro","kuntanimi","avi_koodi","avi_nimi")
#'     tmp$vuosi <- paste0("20",y)
#'     tmp$kod <- as.character(tmp$kod)
#'     dat <- bind_rows(dat,tmp)
#'   }
#'   svenska <- bind_rows(svenska,dat %>% mutate(type = "sa"))
#'
#'   # kunta_sk_teksti,
#'   dat <- data_frame()
#'   for (y in c("08","09","10","11","13","18")){
#'     tmp <- read.table(paste0("https://www.stat.fi/meta/luokitukset/seutukunta/001-20",y,"/tekstitiedosto_sv.txt"),
#'                       header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#'     # names(tmp) <- c("kuntanro","kuntanimi","avi_koodi","avi_nimi")
#'     tmp$vuosi <- paste0("20",y)
#'     tmp$kod <- as.character(tmp$kod)
#'     dat <- bind_rows(dat,tmp)
#'   }
#'   svenska <- bind_rows(svenska,dat %>% mutate(type = "sk"))
#'
#'   # kunta_sp_teksti,
#'   dat <- data_frame()
#'   for (y in c("10","11","12","13","14","15","16","17","18")){
#'     tmp <- read.table(paste0("https://www.stat.fi/meta/luokitukset/sairaanhoitop/001-20",y,"/tekstitiedosto_sv.txt"),
#'                       header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#'     # names(tmp) <- c("kuntanro","kuntanimi","avi_koodi","avi_nimi")
#'     tmp$vuosi <- paste0("20",y)
#'     tmp$kod <- as.character(tmp$kod)
#'     dat <- bind_rows(dat,tmp)
#'   }
#'   svenska <- bind_rows(svenska,dat %>% mutate(type = "sp"))
#'
#'   # kunta_nimi_teksti,
#'   dat <- data_frame()
#'   for (y in c("08","09","10","11","12","13","14","16","17","18")){
#'     tmp <- read.table(paste0("https://www.stat.fi/meta/luokitukset/kunta/001-20",y,"/tekstitiedosto_sv.txt"),
#'                       header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#'     # names(tmp) <- c("kuntanro","kuntanimi","avi_koodi","avi_nimi")
#'     tmp$vuosi <- paste0("20",y)
#'     tmp$kod <- as.character(tmp$kod)
#'     dat <- bind_rows(dat,tmp)
#'   }
#'   svenska <- bind_rows(svenska,dat %>% mutate(type = "kuntanimi_sv"))
#'
#'   # kunta_va_teksti,
#'   dat <- data_frame()
#'   for (y in c("11","12","13","15","18")){
#'     tmp <- read.table(paste0("https://www.stat.fi/meta/luokitukset/vaalipiiri/001-20",y,"/tekstitiedosto_sv.txt"),
#'                       header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#'     # names(tmp) <- c("kuntanro","kuntanimi","avi_koodi","avi_nimi")
#'     tmp$vuosi <- paste0("20",y)
#'     tmp$kod <- as.character(tmp$kod)
#'     dat <- bind_rows(dat,tmp)
#'   }
#'   svenska <- bind_rows(svenska,dat %>% mutate(type = "va"))
#'
#'
#'   # kunta_va_teksti,
#'   dat <- data_frame()
#'   for (y in c("11","12","13","15","18")){
#'     tmp <- read.table(paste0("https://www.stat.fi/meta/luokitukset/vaalipiiri/001-20",y,"/tekstitiedosto_sv.txt"),
#'                       header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#'     # names(tmp) <- c("kuntanro","kuntanimi","avi_koodi","avi_nimi")
#'     tmp$vuosi <- paste0("20",y)
#'     tmp$kod <- as.character(tmp$kod)
#'     dat <- bind_rows(dat,tmp)
#'   }
#'   svenska <- bind_rows(svenska,dat %>% mutate(type = "va"))
#'
#'
#'
#'   # kunta_kela_teksti
#'   piiridata <- data_frame(kod = as.character(1:5),
#'                           benämning = c("södra","västra","mellersta","östra","norra"))
#'   dat <- data_frame()
#'   for (y in 2016:2018){
#'     piiridata$vuosi <- as.character(y)
#'     dat <- bind_rows(dat,piiridata)
#'   }
#'   svenska <- bind_rows(svenska,dat %>% mutate(type = "vakuutuspiiri"))
#'
#'   saveRDS(svenska, "./inst/extras/svenska.rds")
#' }
#' svenska <- readRDS("./inst/extras/svenska.rds")
#'
#' library(dplyr)
#' library(tidyr)
#'
#' #    ____   ___ ____   ___
#' #   |___ \ / _ \___ \ / _ \
#' #     __) | | | |__) | | | |
#' #    / __/| |_| / __/| |_| |
#' #   |_____|\___/_____|\___/
#' #
#'
#' # Valtimo yhdistyi Nurmerkseen joten
#' load("./data/municipality_key_2019.rda")
#' municipality_key_2020 <- municipality_key_2019[municipality_key_2019$kunta_name != "Valtimo", ]
#' save(municipality_key_2020, file = "./data/municipality_key_2020.rda",
#'      compress = "bzip2")
#' rm(list = ls())
#'
#'
#'
#'
#' #    ____   ___  _  ___
#' #   |___ \ / _ \/ |/ _ \
#' #     __) | | | | | (_) |
#' #    / __/| |_| | |\__, |
#' #   |_____|\___/|_|  /_/
#' #
#'
#'
#'
#' #' ## Kuntien luokitusavaimet 2019 http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/luokitusavaimet.html
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/kunta_avi_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","avi_code","avi_name")
#' kunta_avi_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/kunta_ely_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","ely_code","ely_name")
#' kunta_ely_teksti <- d
#'
#' # EI oo html:ää eikä txt:tä
#'
#' # http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/kunta_hp.html # 404
#' # http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/kunta_hp_teksti.txt # 404
#'
#' # d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/kunta_hp_teksti.txt",
#' #                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' # names(d) <- c("kunta","kunta_name","hp_code","hp_name")
#' # kunta_hp_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/kunta_mk_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","mk_code","mk_name")
#' kunta_mk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/kunta_sp_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sp_code","sp_name")
#' kunta_sp_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/kunta_sk_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sk_code","sk_name")
#' kunta_sk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/kunta_sa_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sa_code","sa_name")
#' kunta_sa_teksti <- d
#'
#' library(rvest)
#' URL <- "http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/kunta_kr.html"
#' pg <- read_html(URL)
#' d <- html_table(pg, fill=TRUE, header = TRUE)[[1]]
#' names(d) <- c("kunta","kunta_name","kr_code","kr_name")
#' kunta_kr_teksti <- d
#'
#' ## tka ei toimi
#'
#' # http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/kunta_tka.html # 404
#' # http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/kunta_tka_teksti.txt # 404
#'
#' # library(rvest)
#' # URL <- "http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/kunta_tka.html"
#' # pg <- read_html(URL)
#' # d <- html_table(pg, fill=TRUE, header = TRUE)[[1]]
#' # names(d) <- c("kunta","kunta_name","kr_code","kr_name")
#' # kunta_tka_teksti <- d
#'
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2019/kunta_va_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","va_code","va_name")
#' kunta_va_teksti <- d
#'
#'
#' library(httr)
#' library(stringr)
#'
#' res <- httr::GET("https://www.kela.fi/vakuutuspiirit")
#' cont <- content(x = res, "text")
#'
#' # Eteläinen
#' gsub("^.*Eteläinen", "", cont) %>%
#'   gsub("</p>.*$", "", .) %>%
#'   gsub("^.*<p>", "", .) %>%
#'   gsub(" ja", ",", .) %>%
#'   gsub("\\.", "", .) %>%
#'   gsub(", ", ",", .) %>%
#'   gsub(" ", ",", .) %>%
#'   str_split(string = ., pattern = ",") %>%
#'   unlist() -> etelainen1
#' etelainen <- etelainen1
#'
#' # Itäinen
#' gsub("^.*Itäinen", "", cont) %>%
#'   gsub("</p>.*$", "", .) %>%
#'   gsub("^.*<p>", "", .) %>%
#'   gsub(" ja", ",", .) %>%
#'   gsub("\\.", "", .) %>%
#'   gsub(", ", ",", .) %>%
#'   gsub(" ", ",", .) %>%
#'   str_split(string = ., pattern = ",") %>%
#'   unlist() -> itainen1
#' itainen <- itainen1
#'
#' # Keskinen
#' gsub("^.*Keskinen", "", cont) %>%
#'   gsub("</p>.*$", "", .) %>%
#'   gsub("^.*<p>", "", .) %>%
#'   gsub(" ja", ",", .) %>%
#'   gsub("\\.", "", .) %>%
#'   gsub(", ", ",", .) %>%
#'   gsub(" ", ",", .) %>%
#'   str_split(string = ., pattern = ",") %>%
#'   unlist() -> keskinen1
#' keskinen <- keskinen1
#'
#' # Läntinen
#' gsub("^.*Läntinen", "", cont) %>%
#'   gsub("</p>.*$", "", .) %>%
#'   gsub("^.*<p>", "", .) %>%
#'   gsub(" ja", ",", .) %>%
#'   gsub("\\.", "", .) %>%
#'   gsub(", ", ",", .) %>%
#'   gsub(" ", ",", .) %>%
#'   str_split(string = ., pattern = ",") %>%
#'   unlist() -> lantinen1
#' lantinen <- lantinen1
#'
#' lantinen <- lantinen[lantinen != "TL"]
#' lantinen[lantinen == "Koski"] <- "Koski Tl"
#' lantinen[lantinen == "Pedersören"] <- "Pedersören kunta"
#'
#'
#' # Pohjoinen
#' gsub("^.*Pohjoinen", "", cont) %>%
#'   gsub("</p>.*$", "", .) %>%
#'   gsub("^.*<p>", "", .) %>%
#'   gsub(" ja", ",", .) %>%
#'   gsub("\\.", "", .) %>%
#'   gsub(", ", ",", .) %>%
#'   gsub(" ", ",", .) %>%
#'   str_split(string = ., pattern = ",") %>%
#'   unlist() -> pohjoinen1
#' pohjoinen <- pohjoinen1
#'
#' # Kelan kela_vakuutuspiirit
#' key <- kunta_va_teksti %>% select(kunta, kunta_name)
#'
#' kuntaluokitusavain <- key %>%
#'   mutate(
#'     kela_vakuutuspiiri_name = case_when(
#'       kunta_name %in% etelainen ~ "eteläinen",
#'       kunta_name %in% itainen ~ "itäinen",
#'       kunta_name %in% keskinen ~ "keskinen",
#'       kunta_name %in% lantinen ~ "läntinen",
#'       kunta_name %in% pohjoinen ~ "pohjoinen",
#'       TRUE ~ ""
#'     )) %>%
#'   mutate(
#'     kela_vakuutuspiiri_code = case_when(
#'       kunta_name %in% etelainen ~ 1,
#'       kunta_name %in% itainen ~ 4,
#'       kunta_name %in% keskinen ~ 3,
#'       kunta_name %in% lantinen ~ 2,
#'       kunta_name %in% pohjoinen ~ 5,
#'       TRUE ~ 0
#'     ),
#'     kela_vakuutuspiiri_code = ifelse(kela_vakuutuspiiri_code == 0, NA, kela_vakuutuspiiri_code),
#'     kela_vakuutuspiiri_name = ifelse(kela_vakuutuspiiri_name == "", NA, kela_vakuutuspiiri_name)) %>%
#'   as_tibble() %>%
#'   # Puuttuvat ovat Ahvenanmaalta ja kuuluvat läntiseen vakuutuspiiriin
#'   mutate(kela_vakuutuspiiri_name = ifelse(is.na(kela_vakuutuspiiri_name), "läntinen", kela_vakuutuspiiri_name),
#'          kela_vakuutuspiiri_code = ifelse(is.na(kela_vakuutuspiiri_code), 2, kela_vakuutuspiiri_code))
#'
#'
#'
#' kuntaluokitusavain$kela_asumistukialue_name <- NA
#' kuntaluokitusavain$kela_asumistukialue_name <- ifelse(kuntaluokitusavain$kunta_name %in%c("Helsinki"),
#'                                                       "I kuntaryhmä",
#'                                                       kuntaluokitusavain$kela_asumistukialue_name)
#' kuntaluokitusavain$kela_asumistukialue_name <- ifelse(kuntaluokitusavain$kunta_name %in%c("Espoo", "Kauniainen", "Vantaa"),
#'                                                       "II kuntaryhmä",
#'                                                       kuntaluokitusavain$kela_asumistukialue_name)
#' kuntaluokitusavain$kela_asumistukialue_name <- ifelse(kuntaluokitusavain$kunta_name %in%c("Hyvinkää", "Hämeenlinna", "Joensuu",
#'                                                                                      "Jyväskylä", "Järvenpää", "Kajaani",
#'                                                                                      "Kerava", "Kirkkonummi", "Kouvola",
#'                                                                                      "Kuopio", "Lahti", "Lappeenranta",
#'                                                                                      "Lohja", "Mikkeli", "Nokia", "Nurmijärvi",
#'                                                                                      "Oulu", "Pori", "Porvoo", "Raisio",
#'                                                                                      "Riihimäki", "Rovaniemi", "Seinäjoki",
#'                                                                                      "Sipoo", "Siuntio", "Tampere", "Turku",
#'                                                                                      "Tuusula", "Vaasa", "Vihti"),
#'                                                       "III kuntaryhmä",
#'                                                       kuntaluokitusavain$kela_asumistukialue_name)
#' kuntaluokitusavain$kela_asumistukialue_name <- ifelse(is.na(kuntaluokitusavain$kela_asumistukialue_name),
#'                                                       "IV kuntaryhmä",
#'                                                       kuntaluokitusavain$kela_asumistukialue_name)
#'
#' kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name == "I kuntaryhmä"] <- 1
#' kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name == "II kuntaryhmä"] <- 2
#' kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name == "III kuntaryhmä"] <- 3
#' kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name == "IV kuntaryhmä"] <- 4
#'
#' kunta_kela_teksti <- kuntaluokitusavain
#'
#' # Erityisvastuualueet eli erva
#' ## Lähde: http://www.finlex.fi/fi/laki/alkup/2012/20120812
#'
#' ### HYKS Erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Helsingin ja Uudenmaan|Kymenlaakson|Etelä-Karjalan", kunta_sp_teksti$sp_name),
#'                                     "HYKS erva",
#'                                     NA)
#' ### TYKS erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Varsinais-Suomen|Satakunnan|Vaasan", kunta_sp_teksti$sp_name),
#'                                     "TYKS erva",
#'                                     kunta_sp_teksti$erva_name)
#' ### TAYS erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Pirkanmaan|Kanta-Hämeen|Päijät-Hämeen|Etelä-Pohjanmaan", kunta_sp_teksti$sp_name),
#'                                     "TAYS erva",
#'                                     kunta_sp_teksti$erva_name)
#'
#' ### KYS erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Pohjois-Savon|Keski-Suomen|Etelä-Savon|Itä-Savon|Pohjois-Karjalan", kunta_sp_teksti$sp_name),
#'                                     "KYS erva",
#'                                     kunta_sp_teksti$erva_name)
#' ### OYS erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Pohjois-Pohjanmaan|Keski-Pohjanmaan|Kainuun|Länsi-Pohjan|Lapin", kunta_sp_teksti$sp_name),
#'                                     "OYS erva",
#'                                     kunta_sp_teksti$erva_name)
#'
#'
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "HYKS erva"] <- 1
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "TYKS erva"] <- 2
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "TAYS erva"] <- 3
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "KYS erva"]  <- 4
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "OYS erva"]  <- 5
#'
#' list(
#'   kunta_avi_teksti,
#'   kunta_ely_teksti,
#'   # kunta_hp_teksti,
#'   kunta_kr_teksti,
#'   kunta_mk_teksti,
#'   kunta_sa_teksti,
#'   kunta_sk_teksti,
#'   kunta_sp_teksti,
#'   # kunta_tk_teksti,
#'   # kunta_tka_teksti,
#'   kunta_va_teksti,
#'   kunta_kela_teksti) %>%
#'   Reduce(function(dtf1,dtf2) full_join(dtf1,dtf2), .)  -> tbl
#'
#'
#' # Maarianhamina pitää uudelleennimetä
#' tbl$kr_code[tbl$kunta_name == "Maarianhamina - Mariehamn"] <- 1
#' tbl$kr_name[tbl$kunta_name == "Maarianhamina - Mariehamn"] <- "Kaupunkimaiset kunnat"
#' tbl <- tbl[tbl$kunta_name != "Maarianhamina",]
#' tbl$kunta_name[tbl$kunta_name == "Maarianhamina - Mariehamn"] <- "Maarianhamina"
#'
#' tbl2 <- tbl
#'
#' # *************************************************
#' # käännä ruotsiksi
#' svkey <- readRDS("./inst/extras/svenska.rds")
#'
#' # avi
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "avi",]
#' tbl2$avi_name_sv <- svkey_tmp$benämning[match(tbl2$avi_code,svkey_tmp$kod)]
#' # ely
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "ely",]
#' tbl2$ely_name_sv <- svkey_tmp$benämning[match(tbl2$ely_code,svkey_tmp$kod)]
#' # mk
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "mk",]
#' tbl2$mk_name_sv <- svkey_tmp$benämning[match(tbl2$mk_code,svkey_tmp$kod)]
#' # sa
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "sa",]
#' tbl2$sa_name_sv <- svkey_tmp$benämning[match(tbl2$sa_code,svkey_tmp$kod)]
#' # sk
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "sk",]
#' tbl2$sk_name_sv <- svkey_tmp$benämning[match(tbl2$sk_code,svkey_tmp$kod)]
#' # sp
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "sp",]
#' tbl2$sp_name_sv <- svkey_tmp$benämning[match(tbl2$sp_code,svkey_tmp$kod)]
#' # va
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "va",]
#' tbl2$va_name_sv <- svkey_tmp$benämning[match(tbl2$va_code,svkey_tmp$kod)]
#' # kela_vakuutuspiiri
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "vakuutuspiiri",]
#' tbl2$kela_vakuutuspiiri_name_sv <- svkey_tmp$benämning[match(tbl2$kela_vakuutuspiiri_code,svkey_tmp$kod)]
#' # name
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "kuntanimi_sv",]
#' tbl2$name_sv <- svkey_tmp$benämning[match(tbl2$kunta,svkey_tmp$kod)]
#' tbl2$name_fi <- tbl2$kunta_name
#'
#' # charcols <- !sapply(tbl, is.numeric)
#' # tbl[charcols] <- lapply(tbl[charcols], iconv, from = "windows-1252", to = "UTF-8")
#' municipality_key_2019 <- tbl2
#' save(municipality_key_2019, file = "./data/municipality_key_2019.rda",
#'      compress = "bzip2")
#' rm(list = ls())
#'
#'
#' #    ____   ___  _  ___
#' #   |___ \ / _ \/ |( _ )
#' #     __) | | | | |/ _ \
#' #    / __/| |_| | | (_) |
#' #   |_____|\___/|_|\___/
#' #
#'
#'
#'
#' #' ## Kuntien luokitusavaimet 2018 http://tilastokeskus.fi/meta/luokitukset/kunta/001-2017/luokitusavaimet.html
#'
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2018/kunta_avi_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","avi_code","avi_name")
#' kunta_avi_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2018/kunta_ely_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","ely_code","ely_name")
#' kunta_ely_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2018/kunta_hp_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","hp_code","hp_name")
#' kunta_hp_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2018/kunta_mk_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","mk_code","mk_name")
#' kunta_mk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2018/kunta_sp_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sp_code","sp_name")
#' kunta_sp_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2018/kunta_sk_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sk_code","sk_name")
#' kunta_sk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2018/kunta_sa_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sa_code","sa_name")
#' kunta_sa_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2018/kunta_va_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","va_code","va_name")
#' kunta_va_teksti <- d
#'
#'
#' library(httr)
#' library(stringr)
#'
#' res <- httr::GET("https://www.kela.fi/vakuutuspiirit")
#' cont <- content(x = res, "text")
#'
#' # Eteläinen
#' gsub("^.*Eteläinen", "", cont) %>%
#'   gsub("</p>.*$", "", .) %>%
#'   gsub("^.*<p>", "", .) %>%
#'   gsub(" ja", ",", .) %>%
#'   gsub("\\.", "", .) %>%
#'   gsub(", ", ",", .) %>%
#'   gsub(" ", ",", .) %>%
#'   str_split(string = ., pattern = ",") %>%
#'   unlist() -> etelainen1
#' etelainen <- etelainen1
#'
#' # Itäinen
#' gsub("^.*Itäinen", "", cont) %>%
#'   gsub("</p>.*$", "", .) %>%
#'   gsub("^.*<p>", "", .) %>%
#'   gsub(" ja", ",", .) %>%
#'   gsub("\\.", "", .) %>%
#'   gsub(", ", ",", .) %>%
#'   gsub(" ", ",", .) %>%
#'   str_split(string = ., pattern = ",") %>%
#'   unlist() -> itainen1
#' itainen <- itainen1
#'
#' # Keskinen
#' gsub("^.*Keskinen", "", cont) %>%
#'   gsub("</p>.*$", "", .) %>%
#'   gsub("^.*<p>", "", .) %>%
#'   gsub(" ja", ",", .) %>%
#'   gsub("\\.", "", .) %>%
#'   gsub(", ", ",", .) %>%
#'   gsub(" ", ",", .) %>%
#'   str_split(string = ., pattern = ",") %>%
#'   unlist() -> keskinen1
#' keskinen <- keskinen1
#'
#' # Läntinen
#' gsub("^.*Läntinen", "", cont) %>%
#'   gsub("</p>.*$", "", .) %>%
#'   gsub("^.*<p>", "", .) %>%
#'   gsub(" ja", ",", .) %>%
#'   gsub("\\.", "", .) %>%
#'   gsub(", ", ",", .) %>%
#'   gsub(" ", ",", .) %>%
#'   str_split(string = ., pattern = ",") %>%
#'   unlist() -> lantinen1
#' lantinen <- lantinen1
#'
#' lantinen <- lantinen[lantinen != "TL"]
#' lantinen[lantinen == "Koski"] <- "Koski Tl"
#' lantinen[lantinen == "Pedersören"] <- "Pedersören kunta"
#'
#'
#' # Pohjoinen
#' gsub("^.*Pohjoinen", "", cont) %>%
#'   gsub("</p>.*$", "", .) %>%
#'   gsub("^.*<p>", "", .) %>%
#'   gsub(" ja", ",", .) %>%
#'   gsub("\\.", "", .) %>%
#'   gsub(", ", ",", .) %>%
#'   gsub(" ", ",", .) %>%
#'   str_split(string = ., pattern = ",") %>%
#'   unlist() -> pohjoinen1
#' pohjoinen <- pohjoinen1
#'
#' # Kelan kela_vakuutuspiirit
#' key <- kunta_va_teksti %>% select(kunta, kunta_name)
#'
#' kuntaluokitusavain <- key %>%
#'   mutate(
#'     kela_vakuutuspiiri_name = case_when(
#'       kunta_name %in% etelainen ~ "eteläinen",
#'       kunta_name %in% itainen ~ "itäinen",
#'       kunta_name %in% keskinen ~ "keskinen",
#'       kunta_name %in% lantinen ~ "läntinen",
#'       kunta_name %in% pohjoinen ~ "pohjoinen",
#'       TRUE ~ ""
#'     )) %>%
#'   mutate(
#'     kela_vakuutuspiiri_code = case_when(
#'       kunta_name %in% etelainen ~ 1,
#'       kunta_name %in% itainen ~ 4,
#'       kunta_name %in% keskinen ~ 3,
#'       kunta_name %in% lantinen ~ 2,
#'       kunta_name %in% pohjoinen ~ 5,
#'       TRUE ~ 0
#'     ),
#'     kela_vakuutuspiiri_code = ifelse(kela_vakuutuspiiri_code == 0, NA, kela_vakuutuspiiri_code),
#'     kela_vakuutuspiiri_name = ifelse(kela_vakuutuspiiri_name == "", NA, kela_vakuutuspiiri_name)) %>%
#'   as_tibble() %>%
#'   # Puuttuvat ovat Ahvenanmaalta ja kuuluvat läntiseen vakuutuspiiriin
#'   mutate(kela_vakuutuspiiri_name = ifelse(is.na(kela_vakuutuspiiri_name), "läntinen", kela_vakuutuspiiri_name),
#'          kela_vakuutuspiiri_code = ifelse(is.na(kela_vakuutuspiiri_code), 2, kela_vakuutuspiiri_code))
#'
#'
#'
#' kuntaluokitusavain$kela_asumistukialue_name <- NA
#' kuntaluokitusavain$kela_asumistukialue_name <- ifelse(kuntaluokitusavain$kunta_name %in%c("Helsinki"),
#'                                                       "I kuntaryhmä",
#'                                                       kuntaluokitusavain$kela_asumistukialue_name)
#' kuntaluokitusavain$kela_asumistukialue_name <- ifelse(kuntaluokitusavain$kunta_name %in%c("Espoo", "Kauniainen", "Vantaa"),
#'                                                       "II kuntaryhmä",
#'                                                       kuntaluokitusavain$kela_asumistukialue_name)
#' kuntaluokitusavain$kela_asumistukialue_name <- ifelse(kuntaluokitusavain$kunta_name %in%c("Hyvinkää", "Hämeenlinna", "Joensuu",
#'                                                                                           "Jyväskylä", "Järvenpää", "Kajaani",
#'                                                                                           "Kerava", "Kirkkonummi", "Kouvola",
#'                                                                                           "Kuopio", "Lahti", "Lappeenranta",
#'                                                                                           "Lohja", "Mikkeli", "Nokia", "Nurmijärvi",
#'                                                                                           "Oulu", "Pori", "Porvoo", "Raisio",
#'                                                                                           "Riihimäki", "Rovaniemi", "Seinäjoki",
#'                                                                                           "Sipoo", "Siuntio", "Tampere", "Turku",
#'                                                                                           "Tuusula", "Vaasa", "Vihti"),
#'                                                       "III kuntaryhmä",
#'                                                       kuntaluokitusavain$kela_asumistukialue_name)
#' kuntaluokitusavain$kela_asumistukialue_name <- ifelse(is.na(kuntaluokitusavain$kela_asumistukialue_name),
#'                                                       "IV kuntaryhmä",
#'                                                       kuntaluokitusavain$kela_asumistukialue_name)
#'
#' kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name == "I kuntaryhmä"] <- 1
#' kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name == "II kuntaryhmä"] <- 2
#' kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name == "III kuntaryhmä"] <- 3
#' kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name == "IV kuntaryhmä"] <- 4
#'
#' kunta_kela_teksti <- kuntaluokitusavain
#'
#' # Erityisvastuualueet eli erva
#' ## Lähde: http://www.finlex.fi/fi/laki/alkup/2012/20120812
#'
#' ### HYKS Erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Helsingin ja Uudenmaan|Kymenlaakson|Etelä-Karjalan", kunta_sp_teksti$sp_name),
#'                                     "HYKS erva",
#'                                     NA)
#' ### TYKS erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Varsinais-Suomen|Satakunnan|Vaasan", kunta_sp_teksti$sp_name),
#'                                     "TYKS erva",
#'                                     kunta_sp_teksti$erva_name)
#' ### TAYS erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Pirkanmaan|Kanta-Hämeen|Päijät-Hämeen|Etelä-Pohjanmaan", kunta_sp_teksti$sp_name),
#'                                     "TAYS erva",
#'                                     kunta_sp_teksti$erva_name)
#'
#' ### KYS erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Pohjois-Savon|Keski-Suomen|Etelä-Savon|Itä-Savon|Pohjois-Karjalan", kunta_sp_teksti$sp_name),
#'                                     "KYS erva",
#'                                     kunta_sp_teksti$erva_name)
#' ### OYS erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Pohjois-Pohjanmaan|Keski-Pohjanmaan|Kainuun|Länsi-Pohjan|Lapin", kunta_sp_teksti$sp_name),
#'                                     "OYS erva",
#'                                     kunta_sp_teksti$erva_name)
#'
#'
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "HYKS erva"] <- 1
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "TYKS erva"] <- 2
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "TAYS erva"] <- 3
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "KYS erva"]  <- 4
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "OYS erva"]  <- 5
#'
#' list(
#'   kunta_avi_teksti,
#'   kunta_ely_teksti,
#'   kunta_hp_teksti,
#'   # kunta_kr_teksti,
#'   kunta_mk_teksti,
#'   kunta_sa_teksti,
#'   kunta_sk_teksti,
#'   kunta_sp_teksti,
#'   # kunta_tk_teksti,
#'   kunta_va_teksti,
#'   kunta_kela_teksti) %>%
#'   Reduce(function(dtf1,dtf2) full_join(dtf1,dtf2), .)  -> tbl
#'
#'
#' # Maarianhamina pitää uudelleennimetä
#' tbl <- tbl[tbl$kunta_name != "Maarianhamina",]
#' tbl$kunta_name[tbl$kunta_name == "Maarianhamina - Mariehamn"] <- "Maarianhamina"
#'
#' # tbl2 <- left_join(tbl,tk_data3)
#' tbl2 <- tbl
#'
#' # *************************************************
#' # käännä ruotsiksi
#' svkey <- readRDS("./inst/extras/svenska.rds")
#'
#' # avi
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "avi",]
#' tbl2$avi_name_sv <- svkey_tmp$benämning[match(tbl2$avi_code,svkey_tmp$kod)]
#' # ely
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "ely",]
#' tbl2$ely_name_sv <- svkey_tmp$benämning[match(tbl2$ely_code,svkey_tmp$kod)]
#' # mk
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "mk",]
#' tbl2$mk_name_sv <- svkey_tmp$benämning[match(tbl2$mk_code,svkey_tmp$kod)]
#' # sa
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "sa",]
#' tbl2$sa_name_sv <- svkey_tmp$benämning[match(tbl2$sa_code,svkey_tmp$kod)]
#' # sk
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "sk",]
#' tbl2$sk_name_sv <- svkey_tmp$benämning[match(tbl2$sk_code,svkey_tmp$kod)]
#' # sp
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "sp",]
#' tbl2$sp_name_sv <- svkey_tmp$benämning[match(tbl2$sp_code,svkey_tmp$kod)]
#' # va
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "va",]
#' tbl2$va_name_sv <- svkey_tmp$benämning[match(tbl2$va_code,svkey_tmp$kod)]
#' # kela_vakuutuspiiri
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "vakuutuspiiri",]
#' tbl2$kela_vakuutuspiiri_name_sv <- svkey_tmp$benämning[match(tbl2$kela_vakuutuspiiri_code,svkey_tmp$kod)]
#' # name
#' svkey_tmp <- svkey[svkey$vuosi == 2018 & svkey$type == "kuntanimi_sv",]
#' tbl2$name_sv <- svkey_tmp$benämning[match(tbl2$kunta,svkey_tmp$kod)]
#' tbl2$name_fi <- tbl2$kunta_name
#'
#' municipality_key_2018 <- tbl2
#' save(municipality_key_2018, file = "./data/municipality_key_2018.rda",
#'      compress = "bzip2")
#' rm(list = ls())
#'
#'
#' #    ____   ___  _ _____
#' #   |___ \ / _ \/ |___  |
#' #     __) | | | | |  / /
#' #    / __/| |_| | | / /
#' #   |_____|\___/|_|/_/
#' #
#'
#'
#'
#' #' ## Kuntien luokitusavaimet 2017 http://tilastokeskus.fi/meta/luokitukset/kunta/001-2017/luokitusavaimet.html
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2017/kunta_avi_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","avi_code","avi_name")
#' kunta_avi_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2017/kunta_ely_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","ely_code","ely_name")
#' kunta_ely_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2017/kunta_hp_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","hp_code","hp_name")
#' kunta_hp_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2017/kunta_kr_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","kr_code","kr_name")
#' kunta_kr_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2017/kunta_mk_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","mk_code","mk_name")
#' kunta_mk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2017/kunta_sp_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sp_code","sp_name")
#' kunta_sp_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2017/kunta_sk_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sk_code","sk_name")
#' kunta_sk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2017/kunta_sa_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sa_code","sa_name")
#' kunta_sa_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2017/kunta_tk_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","tk_code","tk_name")
#' kunta_tk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2017/kunta_va_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","va_code","va_name")
#' kunta_va_teksti <- d
#'
#'
#' # Kelan kela_vakuutuspiirit
#' key <- kunta_va_teksti %>% select(kunta, kunta_name)
#'
#' etelainen <- c("Asikkala","Askola","Espoo","Hamina","Hanko","Hartola","Heinola","Helsinki","Hollola","Hyvinkää",
#'                "Hämeenkoski","Iitti","Imatra","Inkoo","Järvenpää","Karkkila","Kauniainen","Kerava","Kirkkonummi",
#'                "Kotka","Kouvola","Kärkölä","Lahti","Lapinjärvi","Lappeenranta","Lemi","Lohja","Loviisa","Luumäki",
#'                "Miehikkälä","Myrskylä","Mäntsälä","Nastola","Nurmijärvi","Orimattila","Padasjoki","Parikkala",
#'                "Pornainen","Porvoo","Pukkila","Pyhtää","Raasepori",
#'                "Rautjärvi","Ruokolahti",
#'                "Savitaipale","Sipoo",
#'                "Siuntio","Sysmä","Taipalsaari","Tuusula","Vantaa","Vihti","Virolahti")
#'
#' itainen <- c("Enonkoski", "Hankasalmi", "Heinävesi", "Hirvensalmi", "Iisalmi", "Ilomantsi","Joensuu", "Joroinen",
#'              "Joutsa", "Juankoski", "Juuka", "Juva", "Jyväskylä", "Jämsä",
#'              "Kaavi", # puuttuu kela.fi
#'              "Kangasniemi", "Kannonkoski", "Karstula",
#'              "Keitele", "Keuruu", "Kinnula", "Kitee", "Kiuruvesi", "Kivijärvi", "Konnevesi", "Kontiolahti", "Kuhmoinen",
#'              "Kuopio",
#'              "Kyyjärvi",
#'              "Lapinlahti", "Laukaa", "Leppävirta", "Lieksa", "Liperi", "Luhanka", "Maaninka", "Mikkeli",
#'              "Multia", "Muurame", "Mäntyharju", "Nurmes", "Outokumpu", "Pihtipudas","Pertunmaa", "Petäjävesi",
#'              "Pieksämäki", "Pielavesi", "Puumala", "Polvijärvi",
#'              "Rantasalmi", # puuttui
#'              "Rautalampi", "Rautavaara",
#'              "Rääkkylä", # puuttui
#'              "Saarijärvi",
#'              "Savonlinna", "Siilinjärvi", "Sonkajärvi", "Sulkava", "Suolahti", "Suonenjoki", "Tervo", "Tohmajärvi",
#'              "Toivakka","Tuusniemi", "Uurainen","Valtimo", "Varkaus", "Vesanto", "Vieremä", "Viitasaari", "Äänekoski")
#'
#' keskinen <- c("Akaa", "Alajärvi", "Alavus", "Evijärvi", "Forssa", "Hattula", "Hausjärvi", "Humppila", "Hämeenlinna",
#'               "Hämeenkyrö", "Ikaalinen", "Ilmajoki", "Isojoki", "Isokyrö", "Jalasjärvi", "Janakkala", "Jokioinen",
#'               "Juupajoki", "Kangasala", "Karijoki", "Kauhajoki", "Kauhava", "Kihniö", "Kurikka", "Kuortane",
#'               "Lappajärvi", "Lapua", "Lempäälä", "Loppi", "Mänttä-Vilppula", "Nokia", "Orivesi", "Parkano",
#'               "Pirkkala", "Punkalaidun", "Pälkäne", "Riihimäki", "Ruovesi", "Sastamala", "Seinäjoki", "Soini",
#'               "Tammela", "Teuva", "Tampere", "Urjala", "Valkeakoski", "Vesilahti", "Vimpeli", "Virrat",
#'               "Ylöjärvi", "Ypäjä", "Ähtäri")
#'
#' lantinen <- c("Aura", "Brändö", "Eckerö", "Eura", "Eurajoki", "Finström", "Föglö", "Geta", "Hammarland",
#'               "Harjavalta", "Honkajoki", "Huittinen", "Jomala", "Jämijärvi", "Kaarina", "Kankaanpää", "Karvia",
#'               "Kaskinen", "Kemiönsaari","Kokemäki", "Korsnäs", "Koski Tl", "Kristiinankaupunki", "Kumlinge",
#'               "Kustavi", "Kökar", "Köyliö", "Laihia", "Laitila", "Lavia", "Lemland", "Lieto", "Loimaa",
#'               "Lumparland", "Luoto", "Luvia", "Maalahti", "Maarianhamina","Maarianhamina - Mariehamn","Marttila", "Masku", "Merikarvia",
#'               "Mustasaari", "Mynämäki","Naantali", "Nakkila", "Nousiainen", "Närpiö", "Oripää", "Paimio",
#'               "Parainen", "Pedersören kunta", "Pietarsaari", "Pomarkku", "Pori", "Pyhäranta", "Pöytyä", "Raisio",
#'               "Rauma", "Rusko", "Salo","Saltvik", "Sauvo", "Siikainen", "Somero", "Sottunga", "Sund", "Säkylä",
#'               "Taivassalo", "Turku", "Ulvila", "Uusikaarlepyy", "Uusikaupunki", "Vaasa", "Vehmaa",
#'               "Vöyri", "Vårdö")
#'
#' pohjoinen <- c("Alavieska", "Enontekiö", "Hailuoto", "Haapajärvi", "Halsua", "Haapavesi", "Hyrynsalmi",
#'                "Ii", "Inari", "Kajaani", "Kalajoki", "Kannus", "Kaustinen", "Kemi", "Kempele", "Kemijärvi",
#'                "Keminmaa", "Kittilä", "Kokkola", "Kolari", "Kruunupyy", "Kuhmo", "Kuusamo", "Kärsämäki",
#'                "Lestijärvi", "Liminka", "Lumijoki", "Merijärvi", "Muonio", "Muhos", "Nivala", "Oulu", "Oulainen",
#'                "Paltamo", "Pelkosenniemi", "Pello", "Perho", "Posio", "Pudasjärvi", "Puolanka", "Pyhäjoki",
#'                "Pyhäjärvi", "Pyhäntä", "Raahe", "Ranua", "Reisjärvi", "Ristijärvi", "Rovaniemi", "Salla",
#'                "Savukoski", "Sievi", "Siikajoki", "Siikalatva", "Simo", "Sodankylä", "Sotkamo", "Suomussalmi",
#'                "Taivalkoski", "Tervola","Toholampi", "Tornio","Tyrnävä", "Utajärvi", "Utsjoki", "Vaala", "Veteli",
#'                "Ylivieska", "Ylitornio")
#'
#' key$kela_vakuutuspiiri <- NA
#' key$kela_vakuutuspiiri <- ifelse(key$kunta_name %in%etelainen, "eteläinen", key$kunta_name)
#' key$kela_vakuutuspiiri <- ifelse(key$kunta_name %in%itainen, "itäinen", key$kela_vakuutuspiiri)
#' key$kela_vakuutuspiiri <- ifelse(key$kunta_name %in%keskinen, "keskinen", key$kela_vakuutuspiiri)
#' key$kela_vakuutuspiiri <- ifelse(key$kunta_name %in%lantinen, "läntinen", key$kela_vakuutuspiiri)
#' key$kela_vakuutuspiiri <- ifelse(key$kunta_name %in%pohjoinen, "pohjoinen", key$kela_vakuutuspiiri)
#'
#' kuntaluokitusavain <- key
#' names(kuntaluokitusavain)[names(kuntaluokitusavain) == "kela_vakuutuspiiri"] <- "kela_vakuutuspiiri_name"
#' kuntaluokitusavain$kela_vakuutuspiiri_code[kuntaluokitusavain$kela_vakuutuspiiri_name == "eteläinen"] <- 1
#' kuntaluokitusavain$kela_vakuutuspiiri_code[kuntaluokitusavain$kela_vakuutuspiiri_name == "läntinen"] <- 2
#' kuntaluokitusavain$kela_vakuutuspiiri_code[kuntaluokitusavain$kela_vakuutuspiiri_name == "keskinen"] <- 3
#' kuntaluokitusavain$kela_vakuutuspiiri_code[kuntaluokitusavain$kela_vakuutuspiiri_name == "itäinen"] <- 4
#' kuntaluokitusavain$kela_vakuutuspiiri_code[kuntaluokitusavain$kela_vakuutuspiiri_name == "pohjoinen"] <- 5
#'
#'
#' kuntaluokitusavain$kela_asumistukialue_name <- NA
#' kuntaluokitusavain$kela_asumistukialue_name <- ifelse(kuntaluokitusavain$kunta_name %in%c("Helsinki"),
#'                                                       "I kuntaryhmä",
#'                                                       kuntaluokitusavain$kela_asumistukialue_name)
#' kuntaluokitusavain$kela_asumistukialue_name <- ifelse(kuntaluokitusavain$kunta_name %in%c("Espoo", "Kauniainen", "Vantaa"),
#'                                                       "II kuntaryhmä",
#'                                                       kuntaluokitusavain$kela_asumistukialue_name)
#' kuntaluokitusavain$kela_asumistukialue_name <- ifelse(kuntaluokitusavain$kunta_name %in%c("Hyvinkää", "Hämeenlinna", "Joensuu",
#'                                                                                      "Jyväskylä", "Järvenpää", "Kajaani",
#'                                                                                      "Kerava", "Kirkkonummi", "Kouvola",
#'                                                                                      "Kuopio", "Lahti", "Lappeenranta",
#'                                                                                      "Lohja", "Mikkeli", "Nokia", "Nurmijärvi",
#'                                                                                      "Oulu", "Pori", "Porvoo", "Raisio",
#'                                                                                      "Riihimäki", "Rovaniemi", "Seinäjoki",
#'                                                                                      "Sipoo", "Siuntio", "Tampere", "Turku",
#'                                                                                      "Tuusula", "Vaasa", "Vihti"),
#'                                                       "III kuntaryhmä",
#'                                                       kuntaluokitusavain$kela_asumistukialue_name)
#' kuntaluokitusavain$kela_asumistukialue_name <- ifelse(is.na(kuntaluokitusavain$kela_asumistukialue_name),
#'                                                       "IV kuntaryhmä",
#'                                                       kuntaluokitusavain$kela_asumistukialue_name)
#'
#' kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name == "I kuntaryhmä"] <- 1
#' kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name == "II kuntaryhmä"] <- 2
#' kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name == "III kuntaryhmä"] <- 3
#' kuntaluokitusavain$kela_asumistukialue_code[kuntaluokitusavain$kela_asumistukialue_name == "IV kuntaryhmä"] <- 4
#'
#'
#' kunta_kela_teksti <- kuntaluokitusavain
#'
#' # Erityisvastuualueet eli erva
#' ## Lähde: http://www.finlex.fi/fi/laki/alkup/2012/20120812
#'
#' ### HYKS Erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Helsingin ja Uudenmaan|Kymenlaakson|Etelä-Karjalan", kunta_sp_teksti$sp_name),
#'                                     "HYKS erva",
#'                                     NA)
#' ### TYKS erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Varsinais-Suomen|Satakunnan|Vaasan", kunta_sp_teksti$sp_name),
#'                                     "TYKS erva",
#'                                     kunta_sp_teksti$erva_name)
#' ### TAYS erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Pirkanmaan|Kanta-Hämeen|Päijät-Hämeen|Etelä-Pohjanmaan", kunta_sp_teksti$sp_name),
#'                                     "TAYS erva",
#'                                     kunta_sp_teksti$erva_name)
#'
#' ### KYS erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Pohjois-Savon|Keski-Suomen|Etelä-Savon|Itä-Savon|Pohjois-Karjalan", kunta_sp_teksti$sp_name),
#'                                     "KYS erva",
#'                                     kunta_sp_teksti$erva_name)
#' ### OYS erva
#' kunta_sp_teksti$erva_name <- ifelse(grepl("Pohjois-Pohjanmaan|Keski-Pohjanmaan|Kainuun|Länsi-Pohjan|Lapin", kunta_sp_teksti$sp_name),
#'                                     "OYS erva",
#'                                     kunta_sp_teksti$erva_name)
#'
#'
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "HYKS erva"] <- 1
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "TYKS erva"] <- 2
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "TAYS erva"] <- 3
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "KYS erva"]  <- 4
#' kunta_sp_teksti$erva_code[kunta_sp_teksti$erva_name == "OYS erva"]  <- 5
#'
#'
#' list(
#'   kunta_avi_teksti,
#'   kunta_ely_teksti,
#'   kunta_hp_teksti,
#'   kunta_kr_teksti,
#'   kunta_mk_teksti,
#'   kunta_sa_teksti,
#'   kunta_sk_teksti,
#'   kunta_sp_teksti,
#'   kunta_tk_teksti,
#'   kunta_va_teksti,
#'   kunta_kela_teksti) %>%
#'   Reduce(function(dtf1,dtf2) full_join(dtf1,dtf2), .)  -> tbl
#'
#'
#' # Maarianhamina pitää uudelleennimetä
#' tbl <- tbl[tbl$kunta_name != "Maarianhamina - Mariehamn",]
#'
#' # tbl2 <- left_join(tbl,tk_data3)
#' tbl2 <- tbl
#'
#' # *************************************************
#' # käännä ruotsiksi
#' svkey <- readRDS("./inst/extras/svenska.rds")
#'
#' # avi
#' svkey_tmp <- svkey[svkey$vuosi == 2017 & svkey$type == "avi",]
#' tbl2$avi_name_sv <- svkey_tmp$benämning[match(tbl2$avi_code,svkey_tmp$kod)]
#' # ely
#' svkey_tmp <- svkey[svkey$vuosi == 2017 & svkey$type == "ely",]
#' tbl2$ely_name_sv <- svkey_tmp$benämning[match(tbl2$ely_code,svkey_tmp$kod)]
#' # kr
#' svkey_tmp <- svkey[svkey$vuosi == 2017 & svkey$type == "kr",]
#' tbl2$kr_name_sv <- svkey_tmp$benämning[match(tbl2$kr_code,svkey_tmp$kod)]
#' # mk
#' svkey_tmp <- svkey[svkey$vuosi == 2017 & svkey$type == "mk",]
#' tbl2$mk_name_sv <- svkey_tmp$benämning[match(tbl2$mk_code,svkey_tmp$kod)]
#' # sp
#' svkey_tmp <- svkey[svkey$vuosi == 2017 & svkey$type == "sp",]
#' tbl2$sp_name_sv <- svkey_tmp$benämning[match(tbl2$sp_code,svkey_tmp$kod)]
#' # kela_vakuutuspiiri
#' svkey_tmp <- svkey[svkey$vuosi == 2017 & svkey$type == "vakuutuspiiri",]
#' tbl2$kela_vakuutuspiiri_name_sv <- svkey_tmp$benämning[match(tbl2$kela_vakuutuspiiri_code,svkey_tmp$kod)]
#' # name
#' svkey_tmp <- svkey[svkey$vuosi == 2017 & svkey$type == "kuntanimi_sv",]
#' tbl2$name_sv <- svkey_tmp$benämning[match(tbl2$kunta,svkey_tmp$kod)]
#' tbl2$name_fi <- tbl2$kunta_name
#'
#' # charcols <- !sapply(tbl, is.numeric)
#' # tbl[charcols] <- lapply(tbl[charcols], iconv, from = "windows-1252", to = "UTF-8")
#' municipality_key_2017 <- tbl2
#' save(municipality_key_2017, file = "./data/municipality_key_2017.rda",
#'      compress = "bzip2")
#' rm(list = ls())
#'
#'
#' #    ____   ___  _  __
#' #   |___ \ / _ \/ |/ /_
#' #     __) | | | | | '_ \
#' #    / __/| |_| | | (_) |
#' #   |_____|\___/|_|\___/
#' #
#'
#'
#'
#' #' ## Kuntien luokitusavaimet 2016 http://tilastokeskus.fi/meta/luokitukset/kunta/001-2016/luokitusavaimet.html
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2016/kunta_avi_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","avi_code","avi_name")
#' kunta_avi_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2016/kunta_ely_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","ely_code","ely_name")
#' kunta_ely_teksti <- d
#'
#' # d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2016/kunta_hp_teksti.txt",
#' #                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' # names(d) <- c("kunta","kunta_name","hp_code","hp_name")
#' # kunta_hp_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2016/kunta_kr_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","kr_code","kr_name")
#' kunta_kr_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2016/kunta_mk_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","mk_code","mk_name")
#' kunta_mk_teksti <- d
#'
#' # d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2016/kunta_sp_teksti.txt",
#' #                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' # names(d) <- c("kunta","kunta_name","sp_code","sp_name")
#' # kunta_sp_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2016/kunta_sk_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sk_code","sk_name")
#' kunta_sk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2016/kunta_sa_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sa_code","sa_name")
#' kunta_sa_teksti <- d
#'
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2016/kunta_tk_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE, fill = TRUE)
#' d$kunta <- as.integer(row.names(d))
#' d$nimike.2 <-  NULL
#' d <- d[c(4,1,2,3)]
#' names(d) <- c("kunta","kunta_name","tk_code","tk_name")
#' kunta_tk_teksti <- d
#'
#' # d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2016/kunta_va_teksti.txt",
#' #                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' # names(d) <- c("kunta","kunta_name","va_code","va_name")
#' # kunta_va_teksti <- d
#'
#' list(
#'   kunta_avi_teksti,
#'   kunta_ely_teksti,
#'   # kunta_hp_teksti,
#'   kunta_kr_teksti,
#'   kunta_mk_teksti,
#'   kunta_sa_teksti,
#'   kunta_sk_teksti,
#'   # kunta_sp_teksti,
#'   kunta_tk_teksti
#'   # kunta_va_teksti
#' ) %>%
#'   Reduce(function(dtf1,dtf2) full_join(dtf1,dtf2), .)   -> tbl
#'
#' # Maarianhamina pitää uudelleennimetä
#' tbl <- tbl[tbl$kunta_name != "Maarianhamina",]
#' tbl$kunta_name[tbl$kunta_name == "Maarianhamina - Mariehamn"] <- "Maarianhamina"
#'
#' # tbl2 <- left_join(tbl,tk_data3)
#' tbl2 <- tbl
#'
#' # *************************************************
#' # käännä ruotsiksi
#' svkey <- readRDS("./inst/extras/svenska.rds")
#'
#' # avi
#' svkey_tmp <- svkey[svkey$vuosi == 2016 & svkey$type == "avi",]
#' tbl2$avi_name_sv <- svkey_tmp$benämning[match(tbl2$avi_code,svkey_tmp$kod)]
#' # ely
#' svkey_tmp <- svkey[svkey$vuosi == 2016 & svkey$type == "ely",]
#' tbl2$ely_name_sv <- svkey_tmp$benämning[match(tbl2$ely_code,svkey_tmp$kod)]
#' # kr
#' svkey_tmp <- svkey[svkey$vuosi == 2016 & svkey$type == "kr",]
#' tbl2$kr_name_sv <- svkey_tmp$benämning[match(tbl2$kr_code,svkey_tmp$kod)]
#' # mk
#' svkey_tmp <- svkey[svkey$vuosi == 2016 & svkey$type == "mk",]
#' tbl2$mk_name_sv <- svkey_tmp$benämning[match(tbl2$mk_code,svkey_tmp$kod)]
#' # # sp
#' # svkey_tmp <- svkey[svkey$vuosi == 2016 & svkey$type == "sp",]
#' # tbl2$sp_name_sv <- svkey_tmp$benämning[match(tbl2$sp_code,svkey_tmp$kod)]
#' # # kela_vakuutuspiiri
#' # svkey_tmp <- svkey[svkey$vuosi == 2016 & svkey$type == "kela_vakuutuspiiri",]
#' # tbl2$kela_vakuutuspiiri_name_sv <- svkey_tmp$benämning[match(tbl2$kela_vakuutuspiiri_code,svkey_tmp$kod)]
#' svkey_tmp <- svkey[svkey$vuosi == 2016 & svkey$type == "name_sv",]
#' tbl2$name_sv <- svkey_tmp$benämning[match(tbl2$kunta,svkey_tmp$kod)]
#' tbl2$name_fi <- tbl2$kunta_name
#'
#'
#' # charcols <- !sapply(tbl, is.numeric)
#' # tbl[charcols] <- lapply(tbl[charcols], iconv, from = "windows-1252", to = "UTF-8")
#' municipality_key_2016 <- tbl2
#' save(municipality_key_2016, file = "./data/municipality_key_2016.rda",
#'      compress = "bzip2")
#' rm(list = ls())
#'
#'
#' #    ____   ___  _ ____
#' #   |___ \ / _ \/ | ___|
#' #     __) | | | | |___ \
#' #    / __/| |_| | |___) |
#' #   |_____|\___/|_|____/
#' #
#'
#'
#' #' ## Kuntien luokitusavaimet 2015 http://tilastokeskus.fi/meta/luokitukset/kunta/001-2015/luokitusavaimet.html
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2015/avi_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","avi_code","avi_name")
#' kunta_avi_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2015/ely_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","ely_code","ely_name")
#' kunta_ely_teksti <- d
#'
#' # d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2015/hp_teksti.txt",
#' #                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' # names(d) <- c("kunta","kunta_name","hp_code","hp_name")
#' # kunta_hp_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2015/kr_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","kr_code","kr_name")
#' kunta_kr_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2015/mk_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","mk_code","mk_name")
#' kunta_mk_teksti <- d
#'
#' # d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2015/sp_teksti.txt",
#' #                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' # names(d) <- c("kunta","kunta_name","sp_code","sp_name")
#' # kunta_sp_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2015/sk_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sk_code","sk_name")
#' kunta_sk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2015/suuralue_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sa_code","sa_name")
#' kunta_sa_teksti <- d
#'
#'
#' # d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2015/kunta_tk_teksti.txt",
#' #                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' # d$kunta <- as.integer(row.names(d))
#' # d$nimike.2 <-  NULL
#' # d <- d[c(4,1,2,3)]
#' # names(d) <- c("kunta","kunta_name","tk_code","tk_name")
#' # kunta_tk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2015/vp_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","va_code","va_name")
#' kunta_va_teksti <- d
#'
#' list(
#'   kunta_avi_teksti,
#'   kunta_ely_teksti,
#'   # kunta_hp_teksti,
#'   kunta_kr_teksti,
#'   kunta_mk_teksti,
#'   kunta_sa_teksti,
#'   kunta_sk_teksti,
#'   # kunta_sp_teksti,
#'   # kunta_tk_teksti
#'   kunta_va_teksti
#' ) %>%
#'   Reduce(function(dtf1,dtf2) full_join(dtf1,dtf2), .)   -> tbl
#'
#' tbl2 <- tbl
#'
#' municipality_key_2015 <- tbl2
#' save(municipality_key_2015, file = "./data/municipality_key_2015.rda",
#'      compress = "bzip2")
#' rm(list = ls())
#'
#' #    ____   ___  _ _  _
#' #   |___ \ / _ \/ | || |
#' #     __) | | | | | || |_
#' #    / __/| |_| | |__   _|
#' #   |_____|\___/|_|  |_|
#' #
#'
#'
#'
#' #' ## Kuntien luokitusavaimet 2014 http://tilastokeskus.fi/meta/luokitukset/kunta/001-2014/luokitusavaimet.html
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2014/luokitusavain_avi_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","avi_code","avi_name")
#' kunta_avi_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2014/luokitusavain_ely_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","ely_code","ely_name")
#' kunta_ely_teksti <- d
#'
#' # d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2014/luokitusavain_hp_teksti.txt",
#' #                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' # names(d) <- c("kunta","kunta_name","hp_code","hp_name")
#' # kunta_hp_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2014/luokitusavain_kryhmitys_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","kr_code","kr_name")
#' kunta_kr_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2014/luokitusavain_maakunta_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","mk_code","mk_name")
#' kunta_mk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2014/luokitusavain_sh_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sp_code","sp_name")
#' kunta_sp_teksti <- d
#'
#' # d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2014/luokitusavain_sk_teksti.txt",
#' #                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' # names(d) <- c("kunta","kunta_name","sk_code","sk_name")
#' # kunta_sk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2014/luokitusavain_suuralue_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sa_code","sa_name")
#' kunta_sa_teksti <- d
#'
#'
#' # d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2014/luokitusavain_kunta_tk_teksti.txt",
#' #                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' # d$kunta <- as.integer(row.names(d))
#' # d$nimike.2 <-  NULL
#' # d <- d[c(4,1,2,3)]
#' # names(d) <- c("kunta","kunta_name","tk_code","tk_name")
#' # kunta_tk_teksti <- d
#'
#' # d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2014/luokitusavain_vp_teksti.txt",
#' #                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' # names(d) <- c("kunta","kunta_name","va_code","va_name")
#' # kunta_va_teksti <- d
#'
#' list(
#'   kunta_avi_teksti,
#'   kunta_ely_teksti,
#'   # kunta_hp_teksti,
#'   kunta_kr_teksti,
#'   kunta_mk_teksti,
#'   kunta_sa_teksti,
#'   # kunta_sk_teksti,
#'   kunta_sp_teksti
#'   # kunta_tk_teksti
#'   # kunta_va_teksti
#' ) %>%
#'   Reduce(function(dtf1,dtf2) full_join(dtf1,dtf2), .)   -> tbl
#'
#'
#' tbl2 <- tbl
#'
#' municipality_key_2014 <- tbl2
#' save(municipality_key_2014, file = "./data/municipality_key_2014.rda",
#'      compress = "bzip2")
#' rm(list = ls())
#'
#' #    ____   ___  _ _____
#' #   |___ \ / _ \/ |___ /
#' #     __) | | | | | |_ \
#' #    / __/| |_| | |___) |
#' #   |_____|\___/|_|____/
#' #
#'
#'
#' #' ## Kuntien luokitusavaimet 2013 http://tilastokeskus.fi/meta/luokitukset/kunta/001-2013/luokitusavaimet.html
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2013/luokitusavain_avi_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","avi_code","avi_name")
#' kunta_avi_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2013/luokitusavain_ely_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","ely_code","ely_name")
#' kunta_ely_teksti <- d
#'
#' # d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2013/luokitusavain_hp_teksti.txt",
#' #                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' # names(d) <- c("kunta","kunta_name","hp_code","hp_name")
#' # kunta_hp_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2013/luokitusavain_kuntaryhmitys_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","kr_code","kr_name")
#' kunta_kr_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2013/luokitusavain_maakunta_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","mk_code","mk_name")
#' kunta_mk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2013/luokitusavain_sh_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sp_code","sp_name")
#' kunta_sp_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2013/luokitusavain_skunta_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sk_code","sk_name")
#' kunta_sk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2013/luokitusavain_suuralue_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","sa_code","sa_name")
#' kunta_sa_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2013/luokitusavain_tka_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","tk_code","tk_name")
#' kunta_tk_teksti <- d
#'
#' d <- read.table("http://tilastokeskus.fi/meta/luokitukset/kunta/001-2013/luokitusavain_vaalipiiri_teksti.txt",
#'                 header = TRUE, sep = "\t", skip = 3, fileEncoding = "windows-1252", stringsAsFactors = FALSE)
#' names(d) <- c("kunta","kunta_name","va_code","va_name")
#' kunta_va_teksti <- d
#'
#' list(
#'   kunta_avi_teksti,
#'   kunta_ely_teksti,
#'   # kunta_hp_teksti,
#'   kunta_kr_teksti,
#'   kunta_mk_teksti,
#'   kunta_sa_teksti,
#'   kunta_sk_teksti,
#'   kunta_sp_teksti,
#'   kunta_tk_teksti,
#'   kunta_va_teksti
#' ) %>%
#'   Reduce(function(dtf1,dtf2) full_join(dtf1,dtf2), .)  -> tbl
#'
#'
#' tbl2 <- tbl
#'
#' municipality_key_2013 <- tbl2
#' save(municipality_key_2013, file = "./data/municipality_key_2013.rda",
#'      compress = "bzip2")
#' rm(list = ls())
#'
#'
#'
#'
#'
#'
