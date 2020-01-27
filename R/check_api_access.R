#' @title Check access to http://geo.stat.fi/geoserver/wfs
#' @description Check if R has access to resources at http://geo.stat.fi/geoserver/wfs
#' @export
#' @author Markus Kainu \email{markus.kainu@@kapsi.fi}
#' @return a logical.
#' 
#' @importFrom httr status_code
#' @importFrom curl curl_download
#' 
#' @examples
#'  \dontrun{
#'    check_api_access()
#'  }

check_api_access <- function(){ 
  
  temp <- tempfile()
  http_url <- "http://geo.stat.fi/geoserver/wfs?service=WFS&version=1.0.0&request=getCapabilities"
  
  suppressWarnings(
    try(
      curl::curl_download(http_url, temp, quiet = TRUE), 
      silent = TRUE)
  )
  if (is.na(file.info(temp)$size)) {
    FALSE
  }
  else{
    TRUE
  }
}

