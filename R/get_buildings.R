#' @title Get geospatial data with all buildings and electoral districts from Väestörekisterikeskus
#' @description preprocessed geospatial data sf-objects
#' @author Markus Kainu <markus.kainu@kela.fi>
#' @return sf-object
#' @export
#' @examples
#'  \dontrun{
#'  f <- get_buildings()
#'  plot(f)
#'  }
#'
#' @rdname get_buildings
#' @export

get_buildings <- function(){
  
  library(dplyr)
  library(sp)
  # library(sf)
  library(archive)
  tmpfile <- tempfile()
  tmpdir <- tempdir()
  download.file("https://www.avoindata.fi/data/dataset/cf9208dc-63a9-44a2-9312-bbd2c3952596/resource/ae13f168-e835-4412-8661-355ea6c4c468/download/suomi_osoitteet_2021-08-16.7z",
                destfile = tmpfile)
  archive::archive_extract(tmpfile,
                           dir = tmpdir)
  
  opt <- read.csv(glue::glue("{tmpdir}/Suomi_osoitteet_2021-08-16.OPT"), fileEncoding = "latin1",
                  sep = ";", 
                  # nrows = 50000,
                  stringsAsFactors = FALSE, 
                  header = FALSE)
  
  names(opt) <- c("rakennustu","sijaintiku",
                  "sijaintima","rakennusty",
                  "CoordY","CoordX",
                  "osoitenume", "katunimi_f",
                  "katunimi_s", "katunumero",
                  "postinumer", "vaalipiirikoodi",
                  "vaalipiirinimi","tyhja",
                  "idx", "date")
  
  opt_sf <- st_as_sf(opt, coords = c("CoordX", "CoordY"),
           ## laitetaan sama CRS kuin kiinteistöillä
           crs = "EPSG:3067"
  ) 
shape <- opt_sf %>% sf::st_transform(crs = "+proj=longlat +datum=WGS84")
#saveRDS(opt_sf, "./rakennukset_20210816_3067.RDS")
#saveRDS(shape, "./rakennukset_20210816_WGS84.RDS")
  
  return(shape)
}

