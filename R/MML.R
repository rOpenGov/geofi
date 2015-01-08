# This file is a part of the helsinki package (http://github.com/rOpenGov/helsinki)
# in association with the rOpenGov project (ropengov.github.io)

# Copyright (C) 2010-2014 Leo Lahti and Juuso Parkkinen / Louhos <louhos.github.com>. 
# All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


#' Get Louhos storage path.
#' 
#' Get url for Louhos storage. It is used to store some large data files.
#'
#' @return URL for Louhos data
#'
#' @export
#' @author Leo Lahti and Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @references See citation("gisfin") 
#' @examples url <- get_louhos_storage_path()
#' @keywords utilities

get_louhos_storage_path <- function () {
  # Louhos data is stored in Github avoindata repo: 
  # https://github.com/avoindata/ which is 
  # mirrored on Datavaalit server
  # and generated with scripts maintained at 
  # https://github.com/avoindata/mml
  "http://www.datavaalit.fi/storage/avoindata/"
}


#' List Land Survey Finland (MML) data sets readily available in RData format.
#'
#' Retrieves the list of currently available MML data sets in http://www.datavaalit.fi/storage/avoindata/mml/rdata/
#'
#' @param verbose logical. Should R report extra information on progress? 
#'
#' @return List of data sets
#'
#' @importFrom XML readHTMLTable
#' @export
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @references See citation("gisfin") 
#' @examples datasets = list_mml_datasets()
#' @keywords utilities

list_mml_datasets <- function (verbose=TRUE) {

  url <- paste(get_louhos_storage_path(), "mml/rdata/", sep = "")

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


#' MML (Land Survey Finland) data
#' 
#' Retrieve data from Land Survey Finland (Maanmittauslaitos, MML). The data are processed into .RData files due to their big size. See the preprocessing details in https://github.com/avoindata/mml.
#'
#' @param map.id data ID. See details.
#' @param data.id data ID. See details.
#' @param verbose logical. Should R report extra information on progress? 
#' 
#' @return url connection
#'
#' @details To browse for available RData, run list_mml_datasets() or see https://github.com/avoindata/mml/tree/master/rdata. 
#'
#' @export
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @references See citation("gisfin") 
#' @examples datasets <- list_mml_datasets(); 
#'           map.id = names(datasets)[[1]]; 
#'           data.id <- datasets[[map.id]][[1]]; 
#'           sp <- get_mml(map.id, data.id)

get_mml <- function(map.id, data.id, verbose = TRUE) {

  # DO NOT SET sp <- NULL HERE; this will return NULL for the function
  # IN CONTRAST TO INTENDED OUTPUT!!!
  sp <- NULL	

  url <- paste(get_louhos_storage_path(), "mml/rdata/", sep = "")
  filepath <- paste(url, map.id, "/", data.id, ".RData", sep = "")
  if (verbose)
    message("Loading ", filepath, ". (C) MML 2013. Converted to RData shape object by Louhos. For more information, see https://github.com/avoindata/mml/")

  # Direct downloads from Github:
  # library(RCurl)
  # dat <- read.csv(text=getURL("link.to.github.raw.csv"))

  #load(url(filepath), envir = .GlobalEnv) # Returns a shape file sp
  load(url(filepath)) # Returns a shape file sp
  
  if (verbose)
    message("\nData loaded successfully!")
  return(sp)
}

