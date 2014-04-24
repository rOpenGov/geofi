# This file is a part of the sorvi program (http://louhos.github.com/sorvi/)
# in association with the rOpenGov project (ropengov.github.io)

# Copyright (C) 2010-2013 Leo Lahti / Louhos <louhos.github.com>. 
# All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#' LouhosStoragePath
#'
#' Arguments:
#'   ... Arguments to pass
#'
#' Return:
#' @return URL for Louhos data
#'
#' @examples # url <- LouhosStoragePath()
#'
#' @export
#' @references
#' See citation("fingis") 
#' @author Leo Lahti and Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @keywords utilities
LouhosStoragePath <- function () {
  # Louhos data is stored in Github avoindata repo: 
  # https://github.com/avoindata/ which is 
  # mirrored on Datavaalit server
  "http://www.datavaalit.fi/storage/avoindata/"
}



#' List Land Survey Finland (MML) data sets readily available in RData format.
#'
#' Arguments:
#' @param ... Arguments to be passed
#'
#' Return:
#' @return List of data sets
#'
#' @details Retrieves the list of currently available MML data sets in http://www.datavaalit.fi/storage/avoindata/mml/rdata/
#' @importFrom XML readHTMLTable
#'
#' @export
#' @references
#' See citation("sorvi") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#'@examples # list_mml_datasets()

#' @keywords utilities


list_mml_datasets <- function (...) {

#  .InstallMarginal("XML")
  url <- paste(LouhosStoragePath(), "mml/rdata/", sep = "")

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

  data.ids

}


#' LoadMML
#'
#' Arguments:
#' @param map.id data ID. See details.
#' @param data.id data ID. See details.
#' @param verbose verbose
#'
#' Return:
#' @return url connection
#'
#' @details See help(MML). To browse for RData options, see https://github.com/avoindata/mml/tree/master/rdata or in R: list_mml_datasets()
#'
#' @examples # datasets <- list_mml_datasets(); map.id = names(datasets)[[1]]; data.id <- datasets[[map.id]][[1]]; sp <- get_MML(map.id, data.id) 
#'
#' @export
#' @references
#' See citation("sorvi") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @keywords utilities

get_MML <- function(map.id, data.id, verbose = TRUE) {

  # DO NOT SET sp <- NULL HERE; this will return NULL for the function
  # IN CONTRAST TO INTENDED OUTPUT!!!
  sp <- NULL	

  url <- paste(LouhosStoragePath(), "mml/rdata/", sep = "")
  filepath <- paste(url, map.id, "/", data.id, ".RData", sep = "")
  if (verbose) {message(paste("Loading ", filepath, ". (C) MML 2013. Converted to RData shape object by Louhos. For more information, see https://github.com/avoindata/mml/", sep = ""))}

  # Direct downloads from Github:
  # library(RCurl)
  # dat <- read.csv(text=getURL("link.to.github.raw.csv"))

  #load(url(filepath), envir = .GlobalEnv) # Returns a shape file sp
  load(url(filepath)) # Returns a shape file sp
  sp

}

#' MML data documentation 
#'
#' The MML data set contains GIS (geographic) data obtained from 
#' Maanmittauslaitos (MML; Land Survey Finland). 
#' Copyright (C) MML 2013. 
#' The open licenses allow modification and redistribution of the data. 
#' The data sets have been preprocessed to allow light-weight access through R.
#' For full details of the conversions, licenses, data documentation etc., 
#' see \url{https://github.com/louhos/takomo/tree/master/MML/Kapsi}
#'
#' @name MML
#' @docType data
#' @author Leo Lahti \email{louhos@@googlegroups.com} 
#'
#' @references \url{http://www.maanmittauslaitos.fi/aineistot-palvelut/latauspalvelut/avoimien-aineistojen-tiedostopalvelu}
#' @usage sp <- get_MML(data.id = "kunta4_p", resolution = "4_5_milj_shape_etrs-tm35fin") 
#' @format list
#' @keywords data
NULL


