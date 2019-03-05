#' @title List Land Survey Finland (MML) data sets readily available in RData format.
#' @description Retrieves the list of currently available MML data sets in http://www.datavaalit.fi/storage/avoindata/mml/rdata/
#' @param verbose logical. Should R report extra information on progress? 
#' @return List of data sets
#' @importFrom XML readHTMLTable
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @references See citation("gisfin") 
#' @examples datasets = list_mml_datasets()
#' @keywords utilities
list_mml_datasets <- function (verbose=TRUE) {

  #url <- paste(ropengov_storage_path(), "mml/rdata/", sep = "")
  url <- "https://github.com/avoindata/mml/tree/master/rdata"

  if (verbose)
    message(paste("Retrieving data set listing from ", url))

  readHTMLTable <- NULL
  temp <- XML::readHTMLTable(url)
  entries <- as.vector(temp[[1]]$Name)
  map.ids <- gsub("/", "", entries[grep("/", as.vector(temp[[1]]$Name))])

  data.ids <- list()
  for (id in map.ids) {

    url2 <- paste(url, id, sep = "")
    temp2 <- XML::readHTMLTable(url2)
    entries2 <- as.vector(temp2[[1]]$Name)
    data.ids[[id]] <- gsub(".RData", "", entries2[grep(".RData$", as.vector(temp2[[1]]$Name))])
 
  }
  if (verbose)
    message("\nData loaded successfully!")
  return(data.ids)
}


