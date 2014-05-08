# This file is a part of the helsinki package (http://github.com/rOpenGov/helsinki)
# in association with the rOpenGov project (ropengov.github.io)

# Copyright (C) 2010-2014 Juuso Parkkinen, Leo Lahti and Joona Lehtomäki / Louhos <louhos.github.com>. 
# All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


#' Retrieve District Boundaries in Helsinki
#'
#' Retrieves District Boundaries data (Aluejakorajat, Aanestysalueet)
#' from Helsinki Real Estate Department
#' (Helsingin kaupungin kiinteistovirasto, HKK)
#' through the HKK website
#' http://ptp.hel.fi/avoindata/index.html
#'
#' The data (C) 2011 Helsingin kaupunkimittausosasto.
#' 
#' @param map.specifier A string. Specify the name of the
#' Helsinki District Boundary data set to retrieve.
#' Run 'get_helsinki_aluejakokartat()' to see available options.
#' @param data.dir A string. Specify a temporary folder for storing downloaded data.
#' @param verbose logical. Should R report extra information on progress? 
#'
#' @return a spatial object (from SpatialPolygonsDataFrame class)
#' @export
#' @note This function replaces sorvi::GetHRIaluejakokartat; The data is now retrieved directly from HKK.
#'
#' @author Juuso Parkkinen, Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @references See citation("gisfin") 
#' @examples sp.suuralue <- get_helsinki_aluejakokartat(map.specifier="suuralue"); 
#'           spplot(sp.suuralue, zcol="Name");

get_helsinki_aluejakokartat <- function(map.specifier=NULL, data.dir = tempdir(), verbose=TRUE) {
  
  # If data not specified, return a list of available options
  if (is.null(map.specifier)) {
    message("Please specify 'map.specifier'!")
    return(c("kunta", "pienalue", "pienalue_piste", "suuralue", "suuralue_piste", "tilastoalue", "tilastoalue_piste", "aanestysalue"))
  }
  
  # Create data.dir if it does not exist
  if (!file.exists(data.dir))
    dir.create(data.dir)
  
  ## Download data -----------------------------------
  
  # Define data to download
  if (map.specifier %in% c("kunta", "pienalue", "pienalue_piste", "suuralue", "suuralue_piste", "tilastoalue", "tilastoalue_piste")) {
    zip.file <- "PKS_Kartta_Rajat_KML2011.zip"
    if (verbose) {
      message("Helsinki region district boundaries (Paakaupunkiseudun aluejakokartat) (C) HKK 2011")
      message("Licence: 'http://ptp.hel.fi/avoindata/aineistot/Kartta_avoindata_kayttoehdot_v02_3_2011.pdf'")
    }
  } else if (map.specifier == "aanestysalue") {
    zip.file <- "pk_seudun_aanestysalueet.zip"
    if (verbose) {
      message("Helsinki election district boundaries (Paakaupunkiseudun aanestysalueet) (C) HKK 2011")
      message("Licence: 'http://ptp.hel.fi/avoindata/aineistot/Avoin%20lisenssi%20aanestysalueet.pdf'")
    }
  }
  
  # Download data
  remote.zip <- paste0("http://ptp.hel.fi/avoindata/aineistot/", zip.file)
  local.zip <-  file.path(data.dir, zip.file)
  if (!file.exists(local.zip)) {
    if (verbose)
      message("Dowloading ", remote.zip, "\ninto ", local.zip, "\n")
    utils::download.file(remote.zip, destfile = local.zip, quiet=!verbose)
  } else {
    if (verbose)
      message("File ", local.zip, " already found, will not download!")
  }
  
  ## Process data ----------------------------------------
  
  # Unzip the downloaded zip file
  utils::unzip(local.zip, exdir = data.dir)
  
  # Specify spatial data file to read
  if (map.specifier != "aanestysalue") {
    filename <- file.path(data.dir, paste0("PKS_", map.specifier, ".kml"))
  } else {
    filename <- file.path(data.dir, "PKS_aanestysalueet_kkj2.TAB")
  }
  
  # Read spatial data
  if (verbose)
    message("Reading filename ", filename)
  
  # TODO: fix warning about Z-dimension discarded
  if (map.specifier != "aanestysalue") {
    # These are in ETRS89 lat/lon coordinates => EPSG:4258
    sp <- rgdal::readOGR(filename, layer = rgdal::ogrListLayers(filename), verbose = verbose, p4s="+init=epsg:4258", drop_unsupported_fields=T, dropNULLGeometries=T)
  } else {
    # These are in KKJ2 coordinates => EPSG:2392
    sp <- rgdal::readOGR(filename, layer = rgdal::ogrListLayers(filename), verbose = verbose, p4s="+init=epsg:2392", drop_unsupported_fields=T, dropNULLGeometries=T, encoding="ISO-8859-1", use_iconv=TRUE)
    # Transform to the same coordinates as the others
    sp <- spTransform(sp, CRS("+proj=longlat +datum=WGS84"))
  }
  
#   # Check that the coordinates match!
#   sp.suuralue = get_helsinki_aluejakokartat("suuralue", data="TEMPDIR")
#   sp.aanestysalue = get_helsinki_aluejakokartat("aanestysalue", "TEMPDIR")
#   df.suuralue = sp2df(sp.suuralue, "Name")
#   df.aanestysalue = sp2df(sp.aanestysalue, "Nimi")
#   ggplot(df.suuralue, aes(x=long, y=lat)) + geom_polygon(aes(group=Name), fill="transparent", colour="red", alpha=0.5, size=1) + geom_polygon(data=df.aanestysalue, aes(group=Nimi), fill="transparent", colour="blue", alpha=0.5, size=1)
#   # Seems good enough!
  
  if (verbose)
    message("\nData loaded successfully!")
  return(sp)
}


#' Retrieve spatial data from Helsinki Real Estate Department
#'
#' Retrieves spatial data for Helsinki region from
#' Helsinki Real Estate Department
#' (Helsingin kaupungin kiinteistovirasto, HKK)
#' through the HKK website
#' http://ptp.hel.fi/avoindata/.
#'
#' For licensing information and other details, see http://ptp.hel.fi/avoindata/.
#'
#' @param map.type  A string. Specify the type of HKK map data to retrieve:
#' 'seutukartta', 'piirijako', 'seudullinen osoiteluettelo',
#' 'helsingin osoiteluettelo', rakennusrekisteri'
#' @param map.specifier  A string. Specify the specific data to retrieve. 
#' Run 'get_helsinki_spatial()' to see available options.
#' @param data.dir A string. Specify a temporary folder for storing downloaded data.
#' @param verbose logical. Should R report extra information on progress? 
#'
#' @return a spatial object (from SpatialPolygonsDataFrame or SpatialPointsDataFrame class)
#' @export
#' 
#' @references See citation("gisfin") 
#' @author Juuso Parkkinen, Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @examples sp.piiri <- get_helsinki_spatial(map.type="piirijako", map.specifier="ALUEJAKO_PERUSPIIRI");
#'           spplot(sp.piiri, zcol="NIMI");

get_helsinki_spatial <- function(map.type=NULL, map.specifier=NULL, data.dir = tempdir(), verbose=TRUE) {
  
  # If data not specified, return a list of available options
  if (is.null(map.type)) {
    message("Please specify 'map.type' and 'map.specifier'!")
    return(list("seutukartta"=c("A_es_pie", "a_hy_suu", "a_ki_pie", "a_nu_til", "a_tu_til", "l_jrata", " m_jarvet", "N_MERI_R", "A_es_suu", "a_hy_til", "a_ki_suu", "a_pkspie", "a_va_kos", "l_kiitor", "m_joet", "N_MERI_S", "a_es_til", "a_ja_pie", "a_ki_til", "a_pkstil", "a_va_suu", "l_metras", "m_meri", "  N_PAIK_R", "a_hk_osa", "a_ja_til", "a_kunta", " a_pksuur", "a_vi_pie", "l_metror", "m_rantav", "N_PAIK_S", "a_hk_per", "a_ka_pie", "a_ma_pie", "a_po_til", "a_vi_suu", "l_tiest2", "m_teolal", "a_hk_pie", "a_ka_til", "a_ma_til", "a_si_pie", "a_vi_til", "l_tiesto", "m_vihral", "a_hk_suu", "a_ke_pie", "a_nu_pie", "a_tu_pie", "Copyrig", "Maankay2", "N_KOS_R", "a_hy_pie", "a_ke_til", "a_nu_suu", "a_tu_suu", "l_jasema", "m_asalue", "N_KOS_S"),
                "piirijako"=c("ALUEJAKO_KUNTA", "ALUEJAKO_OSAALUE_TUNNUS", "ALUEJAKO_OSAALUE", "ALUEJAKO_PERUSPIIRI_TUNNUS", "ALUEJAKO_PERUSPIIRI", "ALUEJAKO_PIENALUE_TUNNUS", "ALUEJAKO_PIENALUE", "ALUEJAKO_SUURPIIRI_TUNNUS", "ALUEJAKO_SUURPIIRI"),
                "seudullinen osoiteluettelo",
                "helsingin osoiteluettelo",
                "rakennusrekisteri"=c("20m2_hkikoord", "etrsgk25", "hkikoord", "wgs84")))
  }
  
  # Create data.dir if it does not exist
  if (!file.exists(data.dir))
    dir.create(data.dir)
  
  ## Download data -----------------------------------------------
  
  # Specify data to download
  if (map.type=="seutukartta") {
    zip.file <- "sk14_avoin.zip"
    if (verbose) {
      message("Helsinki Region Map (Seutukartta)")
      message("For metadata see 'http://ptp.hel.fi/paikkatietohakemisto/?id=30' and 'http://ptp.hel.fi/avoindata/aineistot/Seutukartta_aineistokuvaus.pdf'")
      message("License: 'http://ptp.hel.fi/avoindata/aineistot/Seudullinen_avoimen_tietoaineiston_lisenssi_1.0.pdf'")
    }    
  } else if (map.type=="piirijako") {
    zip.file <- "Helsingin_piirijako_2013.zip"
    if (verbose) {
      message("District Division of the City of Helsinki (Helsingin aluejaot - piirijako)")
      message("For metadata see 'http://ptp.hel.fi/paikkatietohakemisto/?id=139'")
      message("License: 'http://ptp.hel.fi/avoindata/aineistot/Helsinki_kv_kmo_avoin_data_lisenssi_1.0.pdf'")
    }
  } else if (map.type=="seudullinen osoiteluettelo") {
    zip.file <- "Seudullinen_osoiteluettelo.zip"
    if (verbose) {
      message("Regional Address List (Seudullinen osoiteluettelo)")
      message("For metadata see 'http://ptp.hel.fi/paikkatietohakemisto/?id=181' and 'http://ptp.hel.fi/avoindata/aineistot/Seudullisen_Avoimen_osoitetiedon_kuvaus.pdf'")
      message("License: 'http://ptp.hel.fi/avoindata/aineistot/Seudullinen_avoimen_tietoaineiston_lisenssi_1.0.pdf'")
    }
  } else if (map.type=="helsingin osoiteluettelo") {
    zip.file <- "Helsingin_osoiteluettelo.zip"
    if (verbose) {
      message("Register of Addresses of the City of Helsinki (Helsingin osoitekanta)")
      message("For metadata see 'http://ptp.hel.fi/paikkatietohakemisto/?id=11' and 'http://ptp.hel.fi/avoindata/aineistot/Avoimen_osoitetiedon_kuvaus.pdf'")
      message("License: 'http://ptp.hel.fi/avoindata/aineistot/Helsinki_kv_kmo_avoin_data_lisenssi_1.0.pdf'")
    }
  } else if (map.type=="rakennusrekisteri") {
    zip.file <- "rakennukset_Helsinki_06_2012.zip"
    if (verbose) {
      message("Helsinki city building registry (rakennusrekisterin ote) (C) Helsinging kaupunki, 2012")
      message("For metadata see file 'Metatieto_rakennukset.xls' in the zip file")
      message("Licence: 'http://ptp.hel.fi/avoindata/aineistot/Rakennusdata%20lisenssi_09_2012.pdf'")
      message("Warning! The zip file si really big and may cause problems for downloading!")
    } 
  } else {
    stop("Invalid 'map.type'! Run 'temp=get_helsinki_spatial()' to list available options.")
  }
  
  # Download data if the zip file not found
  remote.zip <- paste0("http://ptp.hel.fi/avoindata/aineistot/", zip.file)
  local.zip <-  file.path(data.dir, zip.file)
  if (!file.exists(local.zip)) {
    if (verbose)
      message("\nDowloading ", remote.zip, "\ninto ", local.zip, "\n")
    utils::download.file(remote.zip, destfile = local.zip, quiet=!verbose)
  } else {
    if (verbose)
      message("\nFile ", local.zip, " already found, will not download!")
  }
  
  ## Process data ----------------------------------------
  
  # Unzip the downloaded zip file
  utils::unzip(local.zip, exdir = data.dir)
  
  # Define spatial data file and proj4string to read
  if (map.type=="seutukartta") {
    filename <- file.path(data.dir, "Seutukartta", paste0(map.specifier, ".TAB"))
    p4s <- "+init=epsg:3879"
  } else if (map.type=="piirijako") {
    filename <- file.path(data.dir, paste0(map.specifier, ".tab"))
    p4s <- "+init=epsg:3879"
    
  } else if (map.type=="seudullinen osoiteluettelo") {
    filename <- file.path(data.dir, "Seudullinen_osoiteluettelo.csv")
    p4s <- "+init=epsg:3879" #NOTE! Not used currently as these are in csv
  } else if (map.type=="helsingin osoiteluettelo") {
    filename <- file.path(data.dir, "Helsingin_osoiteluettelo.csv")
    p4s <- "+init=epsg:3879" #NOTE! Not used currently as these are in csv
    
  }  else if (map.type=="rakennusrekisteri") {    
    if (map.specifier=="etrsgk25") {
      filename <- file.path(data.dir, paste0("rakennukset_Helsinki_", map.specifier), paste0("rakennukset_Helsinki_06_2012_", map.specifier, ".TAB"))
      p4s <- "+init=epsg:3879"      
    } else if (map.specifier=="wgs84") {
      filename <- file.path(data.dir, paste0("rakennukset_Helsinki_", map.specifier), paste0("rakennukset_Helsinki_06_2012_", map.specifier, ".TAB"))
      p4s <- "+init=epsg:4326"   
      
    } else if (map.specifier=="hkikoord") {
      filename <- file.path(data.dir, paste0("rakennukset_Helsinki_", map.specifier), paste0("rakennukset_Helsinki_06_2012_", map.specifier, ".TAB"))
      p4s <- NULL
      message("Warning: Coordinates not set for ", map.type, "!")
    } else if (map.specifier=="20m2_hkikoord") {
      filename <- file.path(data.dir, paste0("rakennukset_helsinki_", map.specifier), "ratuttomat_alle20m2_rakennukset_Helsinki_06_2012_hkikoord.TAB")
      p4s <- NULL
      message("Warning: Coordinates not set for ", map.type, "!")     
      
    } else {
      stop("Invalid 'map.specifier'! Run 'temp=get_helsinki_spatial()' to list available options.")
    }
  }
  
  # Check that file exists
  if (!file.exists(filename))
    stop("Invalid 'map.specifier'! Run 'temp=get_helsinki_spatial()' to list available options.")
  
  ## Read data
  if (map.type %in% c("seudullinen osoiteluettelo", "helsingin osoiteluettelo")) {
    # Read the csv
    res <- read.csv(filename, fileEncoding = "ISO-8859-1")
    # Set coordinate system to EPSG:3879
    coord.cols <- match(c("E", "N"), names(res))
    p4s <- "+init=epsg:3879 +proj=tmerc +lat_0=0 +lon_0=25 +k=1 +x_0=25500000 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
    # Convert to SpatialPointsDataFrame
    sp <- sp::SpatialPointsDataFrame(coords=res[, coord.cols], proj4string=CRS(p4s), data=res[, -coord.cols])    
    
  } else {
    # Read spatial data with defined p4s  
    sp <- rgdal::readOGR(filename, layer = rgdal::ogrListLayers(filename), verbose = verbose, p4s=p4s, drop_unsupported_fields=T, dropNULLGeometries=T, encoding="ISO-8859-1", use_iconv=TRUE)
  }
  
  if (verbose)
    message("\nData loaded successfully!")
  return(sp)
}
