library(sf)
library(dplyr)
# download.file("https://tiedostopalvelu.maanmittauslaitos.fi/tp/tilaus/rgg3h0a0bulgd50k7ij4d9lh9l?lang=fi",
#               "~/Downloads/mtkmaasto.zip")
# unzip(zipfile = "~/Downloads/mtkmaasto.zip", exdir = "~/Downloads")
# filepath <- "~/Downloads/mtkmaasto.gpkg"
# layers <- st_layers(filepath)
# grep("kunnan", layers$name, value = T)
# # [1] "valtakunnanrajapyykki" "kunnanhallintoraja"    "kunnanhallintokeskus"
# mtkmaasto_kunnanhallintokeskus <- st_read(filepath, layer = "kunnanhallintokeskus")
# municipality_central_localities <- sf::st_zm(x = mtkmaasto_kunnanhallintokeskus)
# sf::st_crs(municipality_central_localities) <- 3067
# municipality_central_localities <- sf::st_transform(x = municipality_central_localities, crs = 3067)
# save(municipality_central_localities, file = "./data/municipality_central_localities.rda",
#      compress = "bzip2")

# 2023 lets use OGC api features service
# See https://markuskainu.fi/posts/2023-01-25-ogc-api-perusteet/#maanmittauslaitoksen-avoimet-ogc-api-features--rajapinnat for more details

# municipality_central_localities  can be accessed at
# "https://avoin-paikkatieto.maanmittauslaitos.fi/maastotiedot/features/v1/collections/kunnanhallintokeskus/items"
# using follo
mml_api_key <- Sys.getenv("MML_API_KEY")
url <- paste0("https://avoin-paikkatieto.maanmittauslaitos.fi/maastotiedot/features/v1/collections/kunnanhallintokeskus/items?f=json&limit=500&api-key=", mml_api_key)
kunnanhallintokeskus <- sf::st_read(url)
kunnanhallintokeskus$sijainti_piste <- NULL
municipality_central_localities_df <- bind_cols(st_drop_geometry(kunnanhallintokeskus),
                                                st_coordinates(kunnanhallintokeskus))
save(municipality_central_localities_df, file = "./data/municipality_central_localities_df.rda",
     compress = "bzip2")
usethis::use_data(municipality_central_localities_df, overwrite = TRUE)

municipality_central_localities <- sf::st_transform(kunnanhallintokeskus, 3067) |>
  left_join(municipality_key_2022 |> select(kunta,municipality_code,municipality_name_fi,municipality_name_sv,municipality_name_en),
            by = c("kuntatunnus" = "kunta"))
save(municipality_central_localities, file = "./data/municipality_central_localities.rda",
     compress = "bzip2")


