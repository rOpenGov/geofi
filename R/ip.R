#' @title Get IP location
#' @description Get geographic coordinates for a given IP-address from \url{http://www.datasciencetoolkit.org//ip2coordinates/}
#' @param ip IP address as character
#' @return Latitude and longitude as a numeric vector
#' @export 
#' @references See citation("gisfin") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @note Modified from original version by Kay Cichini
#' @examples \dontrun{ip_location("137.224.252.10")}
#' @keywords utilities
ip_location <- function(ip) {

   url <- "http://www.datasciencetoolkit.org/ip2coordinates/"
   URL_IP <- paste(url, ip, sep = "")

   message(paste("Retrieving the IP", ip, "from ", url))

   api_return <- readLines(URL_IP, warn = F)
   lon1 <- api_return[grep("longitude", api_return)]
   lon <- gsub("[^[:digit:].]", "", lon1)
   lat1 <- api_return[grep("latitude", api_return)]
   lat <- gsub("[^[:digit:].]", "", lat1)
   return(c(lat, lon))

}

