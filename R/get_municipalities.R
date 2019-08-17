#' @title Get geospatial data at kunta, maakunta, etc leves from MML
#' @description preprocessed geospatial data sf-objects
#' @param year A numeric for year of the administerative borders. Available are 2013, 2014, 2015, 2016, 2017, 2018 and 2019.
#' @param scale A scale or resolution of the shape. Two options: \code{1000} equals 1:1 000 000 and \code{4500} equals 1:4 500 000.
#' @author Markus Kainu <markus.kainu@kela.fi>
#' @return sf-object
#' @examples
#'  \dontrun{
#'  f <- get_municipalities(year=2016, scale = 4500)
#'  plot(f)
#'  }
#'
#' @rdname get_municipalities
#' @export

get_municipalities <- function(year=2017, scale = 4500){

  layer <- paste0("tilastointialueet:kunta",scale,"k_",year)

  shape <- get_wfs_layer(url = "http://geo.stat.fi/geoserver/wfs",
                         layer = layer, serviceVersion = "1.0.0")

  return(shape)
}
