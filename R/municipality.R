#' @title Get municipality border maps
#' @description Get municipality border maps
#' @param data.source Specify the source of municipality map data: "MML" or "GADM"-
#' @return \link{SpatialPolygonsDataFrame}-object in longlat-format. 
#' @details Retrieve municipality maps from
#'    MML (Land Survey Finland; Maanmittauslaitos, MML) (see \url{https://github.com/avoindata/mml}) or
#'    GADM \url{http://gadm.org/country}. For further maps from MML, see \code{\link{get_mml}}. For further maps from GADM, see \url{http://gadm.org/country}. Note that the GADM map data is not up-to-date.
#' @export
#' @importFrom ggplot2 theme_set
#' @seealso \code{\link{get_mml}}
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @references See citation("gisfin") 
#' @examples sp <- get_municipality_map("MML")
get_municipality_map <- function (data.source = "MML") {

  if (data.source == "MML") {
  
    # Get the municipality map for visualization
    message(paste("Downloading Land Survey Finland (C) MML 2013 municipality borders with gisfin::get_mml(map.id='Yleiskartta-1000', data.id='HallintoAlue'). For details, see https://github.com/avoindata/mml"))
    sp <- get_mml(map.id="Yleiskartta-1000", data.id="HallintoAlue")

    # Name kuntakoodi separately for clarity
    sp@data$kuntakoodi <- sp@data$Kunta
    # TODO use here harmonized municipality names from sorvi harmonization functions
    sp@data$kuntanimi <- sp@data$Kunta_ni1

   } else if (data.source == "GADM") {

    # GADM maps.
    map.url <- "http://biogeo.ucdavis.edu/data/gadm2/R/FIN_adm4.RData"
    message(paste("Downloading GADM data:", map.url))

    # Load municipality borders from GADM:
    con <- url(map.url)
    load(con); close(con)

    # TODO use here harmonized municipality names from sorvi harmonization functions    
    gadm$kuntanimi <- gadm$NAME_4    
    # Convert NAME field into factor (necessary for plots)
    gadm$kuntanimi <- factor(gadm$kuntanimi)

    # Harmonize municipality names
    #map.gadm$kuntanimi <- convert_municipality_names(as.character(map.gadm$kuntanimi))
    # TODO: there are too many municipalities and some names are outdated.
    # Provide proper preprocessing. 
    # TODO: Add municipality code after the municipality names are up-to-date
    #map.gadm$kuntakoodi <- convert_municipality_codes(municipalities = map.gadm$kuntanimi) 
 
    sp <- gadm

  }

  # Ensure longlat format in WGS84 datum
  sp <- spTransform(sp, CRS("+proj=longlat +datum=WGS84"))

  sp

}



