#' @title Get geospatial data at kunta, maakunta, etc leves from MML
#' @description preprocessed geospatial data sf-objects
#' @param year A numeric for year of the administerative borders. Available are 2006, 2010, 2011, 2012, 2014, 2015, 2016, 2017.
#' @author Markus Kainu <markus.kainu@kela.fi>
#' @return sf-object
#' @export
#' @examples
#'  \dontrun{
#'  f <- get_zipcodes(year=2016,level="kunta")
#'  plot(f)
#'  }
#'
#' @rdname get_zipcodes
#' @export

get_zipcodes <- function(year=2017){
  
  layer <- paste0("postialue:pno_",year)
  
  shape <- wfs(url = "http://geo.stat.fi/geoserver/wfs", layer = layer, serviceVersion = "1.0.0")
  
  return(shape)
}
