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
  library(sf)
  tmpfile <- tempfile()
  tmpdir <- tempdir()
  download.file("https://www.avoindata.fi/data/dataset/cf9208dc-63a9-44a2-9312-bbd2c3952596/resource/ae13f168-e835-4412-8661-355ea6c4c468/download/suomi_osoitteet_2019-08-15.zip",
                destfile = tmpfile)
  unzip(zipfile = tmpfile,
        exdir = tmpdir)
  
  opt <- read.csv(glue::glue("{tmpdir}/suomi_osoitteet_2019-08-15.OPT"), fileEncoding = "latin1",
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

  sp.data <- SpatialPointsDataFrame(opt[, c("CoordX", "CoordY")], 
                                    opt, 
                                    proj4string = CRS("+init=epsg:3067"))
  
  # Project the spatial data to lat/lon
  # sp.data <- spTransform(sp.data, CRS("+proj=longlat +datum=WGS84"))
  
  shape <- st_as_sf(sp.data)
  
  # st_coordinates(shape)
  
  # shape %>% select(rakennustu) %>% plot()
  
  return(shape)
}
