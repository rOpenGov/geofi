# Create datasets to be used in Vignettes

library(sotkanet)
library(dplyr)
sotkadata_population <- GetDataSotkanet(indicators = 127, years = 2000:2022) %>%
  filter(region.category == "KUNTA") %>%
  mutate(municipality_code = as.integer(region.code)) %>%
  select(municipality_code,primary.value,year)

save(sotkadata_population, file = "./data/sotkadata_population.rda",
     compress = "bzip2")

karttasovellus::document_data(dat = sotkadata_population,
              neim = "sotkadata_population",
              description = "This dataset contains population data at municipality level pulled from THL (Sotkanet) from 2000 to 2022")


# ******************
sotkadata_swedish_speaking_pop <- GetDataSotkanet(indicators = 2433, years = 2000:2022) %>%
  filter(region.category == "KUNTA") %>%
  mutate(municipality_code = as.integer(region.code)) %>%
  select(municipality_code,indicator.title.fi,primary.value)

save(sotkadata_swedish_speaking_pop, file = "./data/sotkadata_swedish_speaking_pop.rda",
     compress = "bzip2")

karttasovellus::document_data(dat = sotkadata_swedish_speaking_pop,
                              neim = "sotkadata_swedish_speaking_pop",
                              description = "This dataset contains Swedish speaking population figures at municipality level pulled from THL (Sotkanet) from 2000 to 2022")


# ******************
library(pxweb)
px_data <- read.csv("https://pxdata.stat.fi:443/PxWeb/sq/43d3d0aa-636e-4a4b-bbe1-decae45fc2b4",
                    header = TRUE, sep = ";", fileEncoding = "Latin1")
px_data$posti_alue <- sub(" .+$", "", px_data$Postinumeroalue)
statfi_zipcode_population <- px_data %>% select(posti_alue,X2022)

save(statfi_zipcode_population, file = "./data/statfi_zipcode_population.rda",
     compress = "bzip2")

karttasovellus::document_data(dat = statfi_zipcode_population,
                              neim = "statfi_zipcode_population",
                              description = "This dataset contains population for each zipcode in Finland. Data is doanloaded from Statistics Finland")

