# This file is a part of the sorvi program (http://louhos.github.com/sorvi/)

# Copyright (C) 2010-2013 Louhos <louhos.github.com>. All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


#' Get map data in GADM format
#'
#' Args:
#'   @param map Map identifier. When the full GADM-URL has the form 
#'     "http://gadm.org/data/rda/FIN_adm2.RData", this variable contains 
#'     the part "FIN_adm". For further map identifiers, see http://gadm.org
#'   @param resolution Integer or String. Specifies map resolution. 
#'      This variable contains the part "4" from the full GADM-URL.
#'	Alternatively, the user can provide a string corresponding
#' 	to the desired FIN_adm GADM map resolution with the following options: 
#'      "Maa"        (0 / Country); 
#'	"Laani"      (1 / Province); 
#'	"Maakunta"   (2 / Region); 
#'	"Seutukunta" (3 / Sub-Region);
#'	"Kunta"      (4 / Municipality)
#'
#'   @param url URL of the GADM R data source
#' 
#' Returns:
#'   @return GADM object
#'
#' @export
#' @note Suomen osalta kuntatiedot (FIN_adm4) nayttaa olevan paivittamatta uusimpaan. Suositellaan MML:n karttoja, ks. help(MML). 
#'
#' @references
#' See citation("sorvi") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # Suomen kunnat: gadm <- get.gadm(map = "FIN_adm", resolution = 4)
#' @keywords utilities

GetGADM <- function (map = "FIN_adm", 
	   	     resolution = 4, 
		     url = "http://gadm.org/data/rda/") {

  # See also:
  # see http://ryouready.wordpress.com/2009/11/16/infomaps-using-r-visualizing-german-unemployment-rates-by-color-on-a-map/   
  # http://r-spatial.sourceforge.net/gallery/ 
  # url <- "http://gadm.org/data/rda/FIN_adm"

  # Convert string input to corresponding integer
  resolution <- sorvi::ConvertGADMResolution(resolution, "integer") 

  # Load map of Finland with the given resolution
  con <- url(paste(url, map, resolution, ".RData", sep=""))
  print(load(con))
  close(con)

  type.field <- paste("TYPE_", resolution, sep = "")
  name.field <- paste("NAME_", resolution, sep = "")

  # Preprocess names
  if (any(duplicated(gadm[[name.field]]))) {
    warning("Removing duplicates")
    gadm <- gadm[!duplicated(gadm[[name.field]]), ]
  }

  # Convert string fields to UTF-8
  name.fields <- c("ISO")
  name.fields <- c(name.fields, names(gadm)[grep("^NAME_", names(gadm))])
  name.fields <- c(name.fields, names(gadm)[grep("^VARNAME_", names(gadm))])
  name.fields <- c(name.fields, names(gadm)[grep("^TYPE_", names(gadm))])
  name.fields <- c(name.fields, names(gadm)[grep("^REMARKS_", names(gadm))])
  for (nf in name.fields) {
    gadm[[nf]] <- iconv(as.character(gadm[[nf]]), "latin1", "UTF-8")  
  }

  resolution.type <- unlist(strsplit(as.character(unique(gadm[[type.field]])), "\\|"))[[1]]

  gadm[[resolution.type]] <- iconv(as.character(gadm[[name.field]]), "latin1", "UTF-8")

  gadm

}  


#' Convert GADM map resolution identifiers between strings and integers
#' 
#'      "Maa"        (0 / Country); 
#'	"Laani"      (1 / Province); 
#'	"Maakunta"   (2 / Region); 
#'	"Seutukunta" (3 / Sub-Region);
#'	"Kunta"      (4 / Municipality)
#'
#' Arguments:
#'   @param resolution string or integer specifying the resolution 
#'      for region borders
#'   @param output.type "integer" or "string" specifying 
#'      whether the resolution is converted into integer or string 
#'      (if not already in that format)
#'
#' Returns:
#'   @return integer or string
#'
#' @export
#' @references
#' See citation("sorvi") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @keywords utilities

ConvertGADMResolution <- function (resolution, output.type = "integer") {

  fi.resolution <- c(Maa = 0, # Maa / Country
  		     Laani = 1, # Laani / Province
		     Maakunta = 2, # Maakunta / Region
		     Seutukunta = 3, # Seutukunta / Sub-Region
		     Kunta = 4 # Kunta / Municipality
  		   )

  if (is.character(resolution) && output.type == "integer") {
    resolution.conv <- fi.resolution[resolution]
  } else if (is.double(resolution) && output.type == "string") { 
    resolution.conv <- names(fi.resolution)[fi.resolution == resolution]
  } else {
    resolution.conv <- resolution
  }

  resolution.conv

}

#' Find municipality (kunta), subregion (seutukunta), 
#' region (maakunta), or province (laani)
#' for given GADM map coordinates,
#'
#' Arguments:
#' @param coordinates matrix with columns named 'x' and 'y'. The
#'   columns specify x and y coordinates on the GADM map. These will be
#'   mapped to region names, with the resolution specified by the
#'   resolution parameter. For instance: 
#'   coordinates <- cbind( x = c(24.9375, 24.0722), 
#'                         y = c(60.1783, 61.4639))
#' @param map Map identifier. When the full GADM-URL has the form 
#'   "http://gadm.org/data/rda/FIN_adm2.RData", this variable contains 
#'   the part "FIN_adm". For further map identifiers, see http://gadm.org
#' @param resolution Integer or String. Specifies map resolution. 
#'    This variable contains the part "4" from the full GADM-URL.
#     Alternatively, the user can provide a string corresponding
#'    to the desired FIN_adm GADM map resolution with the following options: 
#'    "Maa"        (0 / Country); 
#     "Laani"      (1 / Province); 
#'    "Maakunta"   (2 / Region); 
#'    "Seutukunta" (3 / Sub-Region);
#'    "Kunta"      (4 / Municipality)
#'
#' Returns:
#'   @return A data frame with coordinates, region, province, and municipality information
#'
#' @export
#'
#' @references
#' See citation("sorvi") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @keywords utilities

ConvertGADMPosition2Region <- function (coordinates, 
					map = "FIN_adm",
					resolution = "Kunta") {

  # Modified from http://www.r-ohjelmointi.org/?p=894
 
  # Form data.frame with the coordinates

  #.InstallMarginal("sp") # Key dependency
  
  x <- coordinates[, "x"]
  y <- coordinates[, "y"]

  dat <- data.frame(id = c("a", "b"), x = x, y = y)
  coordinates(dat) = ~x + y

  # Load Finland map, divided into provinces (laanit)
  gadm <- sorvi::GetGADM(map, resolution)
  info <- overlay(gadm, dat)

  resolution.int <- sorvi::ConvertGADMResolution(resolution, "integer")
  resolution.str <- sorvi::ConvertGADMResolution(resolution, "string")
  name.field <- paste("NAME_", resolution.int, sep = "")

  # Merge the location information for the coordinate into a single data.frame
  df <- data.frame(dat)
  df[[resolution.str]] <- info[[name.field]]

  df

}

