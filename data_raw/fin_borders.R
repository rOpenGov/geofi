if (FALSE){
  library(sf)
  library(dplyr)

  muni <- get_municipalities(scale = 4500)
  fin_4500_3067 <- st_union(muni) %>% st_as_sf() %>% dplyr::rename(geom = x) %>%
    mutate(name_fi = "Suomi", name_sv = "Finland", name_en = "Finland")
  fin_4500_4326 <- st_transform(fin_4500_3067, crs = 4326)
  usethis::use_data(fin_4500_3067, overwrite = TRUE)
  usethis::use_data(fin_4500_4326, overwrite = TRUE)

  # muni <- get_municipalities(scale = 1000)
  # fin_1000_3067 <- st_union(muni) %>% st_as_sf() %>% dplyr::rename(geom = x)
  # fin_1000_4326 <- st_transform(fin_1000_3067, crs = 4326)
  # usethis::use_data(fin_1000_3067, overwrite = TRUE)
  # usethis::use_data(fin_1000_4326, overwrite = TRUE)

}



