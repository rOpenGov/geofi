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

## Year 2020

# Municipalities
langs <- c("fi","sv","en")

# Lets loop over the years 2013-2020
yearlist <- list()
yrs <- 2013:2020
for (iii in seq_along(yrs)){
  
  kuntaclass <- paste0("kunta_1_",yrs[iii],"0101")

lst <- list()
for (i in seq_along(langs)){
  tmp <- get_classifications(class = kuntaclass, lang = langs[i])
  names(tmp) <- c("kunta", paste0("name_",langs[i]))
  lst[[i]] <- tmp
}
d_muni <- left_join(lst[[1]],lst[[2]]) %>% 
  left_join(lst[[3]])


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
  outdatlist[[ii]] <- left_join(keydat, class_dat)
}
}
}
outdatlist2 <- outdatlist[!sapply(outdatlist,is.null)]
datout <- Reduce(function(...) merge(..., by='kunta', all.x=TRUE), outdatlist2)
yearlist[[iii]] <- left_join(d_muni,datout) %>% 
  mutate(year = yrs[iii]) %>% 
  mutate_at(.vars = vars(ends_with("_code")), 
            .funs = function(x) ifelse(grepl("[A-Za-z]", x), x, as.integer(x)))
}
ddd <- do.call(bind_rows, yearlist)

# ddd %>% 
#   filter(name_fi == "Veteli") %>% 
#   View()


# 
# 
# # List available classifications
# res <- fromJSON("https://data.stat.fi/api/classifications/v2/classifications?format=json") %>% 
#   as_tibble()
# # Lets select all with 2020
# res[grepl("2020", res$value),]
# 
# 
# names(geofi::municipality_key_2020)
# 
# 
# 
# # fi
# res <- fromJSON("https://data.stat.fi/api/classifications/v2/classifications/sairaanhoitop_1_20130101/classificationItems?content=data&format=json&lang=fi&meta=max") %>% 
#   as_tibble()
# dlist <- list()
# for (i in 1:nrow(res)){
#   dlist[[i]] <- tibble(
#     code = res$code[[i]],
#     name = res$classificationItemNames[[i]]$name
#   )
# }
# do.call(bind_rows, dlist) %>% 
#   rename(name_fi = name) -> d1
# # sv
# res <- fromJSON("https://data.stat.fi/api/classifications/v2/classifications/sairaanhoitop_1_20200101/classificationItems?content=data&format=json&lang=sv&meta=max") %>% 
#   as_tibble()
# dlist <- list()
# for (i in 1:nrow(res)){
#   dlist[[i]] <- tibble(
#     code = res$code[[i]],
#     name = res$classificationItemNames[[i]]$name
#   )
# }
# do.call(bind_rows, dlist) %>% 
#   rename(name_sv = name) -> d2
# # en
# res <- fromJSON("https://data.stat.fi/api/classifications/v2/classifications/sairaanhoitop_1_20200101/classificationItems?content=data&format=json&lang=en&meta=max") %>% 
#   as_tibble()
# dlist <- list()
# for (i in 1:nrow(res)){
#   dlist[[i]] <- tibble(
#     code = res$code[[i]],
#     name = res$classificationItemNames[[i]]$name
#   )
# }
# do.call(bind_rows, dlist) %>% 
#   rename(name_en = name) -> d3
# dat <- left_join(d1,d2) %>% 
#   left_join(d3)
