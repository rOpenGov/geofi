library(sf)
library(dplyr)
download.file("https://tiedostopalvelu.maanmittauslaitos.fi/tp/tilaus/rgg3h0a0bulgd50k7ij4d9lh9l?lang=fi",
              "~/Downloads/mtkmaasto.zip")
unzip(zipfile = "~/Downloads/mtkmaasto.zip", exdir = "~/Downloads")
filepath <- "~/Downloads/mtkmaasto.gpkg"
layers <- st_layers(filepath)
grep("kunnan", layers$name, value = T)
# [1] "valtakunnanrajapyykki" "kunnanhallintoraja"    "kunnanhallintokeskus"
mtkmaasto_kunnanhallintokeskus <- st_read(filepath, layer = "kunnanhallintokeskus")
municipality_central_localities <- sf::st_zm(x = mtkmaasto_kunnanhallintokeskus)
sf::st_crs(municipality_central_localities) <- 3067
municipality_central_localities <- sf::st_transform(x = municipality_central_localities, crs = 3067)
save(municipality_central_localities, file = "./data/municipality_central_localities.rda",
     compress = "bzip2")
