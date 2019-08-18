#' Get Finnish municipality (multi)polygons for different years and/or scales.
#' 
#' Thin wrapper around Finnish zip code areas provided by 
#' [Statistic Finland](https://www.stat.fi/org/avoindata/paikkatietoaineistot/kuntapohjaiset_tilastointialueet_en.html).  
#' 
#' @param year A numeric for year of the administerative borders. Available are 
#'             2013, 2014, 2015, 2016, 2017, 2018 and 2019.
#' @param scale A scale or resolution of the shape. Two options: \code{1000} 
#'              equals 1:1 000 000 and \code{4500} equals 1:4 500 000.
#' @param ... Additional arguments passed to \code{\link{get_wfs_layer}}.
#' 
#' @return sf object
#' 
#' @author Markus Kainu <markus.kainu@@kela.fi>, Joona Lehtomäki <joona.lehtomaki@@iki.fi>
#' 
#' @examples
#'  \dontrun{
#'  f <- get_municipalities(year=2016, scale = 4500)
#'  plot(f)
#'  }
#'
#' @rdname get_municipalities
#' @export

get_municipalities <- function(year = 2017, scale = 4500, ...){

  layer <- paste0("tilastointialueet:kunta", scale, "k_", year)

  shape <- get_wfs_layer(url = "http://geo.stat.fi/geoserver/wfs",
                         layer = layer, serviceVersion = "1.0.0", ...)

  return(shape)
}
