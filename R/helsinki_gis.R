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
#' Run 'get_Helsinki_aluejakokartat()' to see available options.
#' @param data.dir A string. Specify a temporary folder for storing downloaded data.
#' @param verbose logical. Should R report extra information on progress? 
#'
#' @return a shape object (from SpatialPolygons class)
#' @importFrom rgdal readOGR
#' @importFrom rgdal ogrListLayers
#' @export
#' @note This function replaces sorvi::GetHRIaluejakokartat; The data is now retrieved directly from HKK.
#'
#' @author Juuso Parkkinen, Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @references See citation("fingis") 
#' @examples sp.suuralue <- get_Helsinki_aluejakokartat(map.specifier="suuralue"); 
#'           plot_shape(sp=sp.suuralue, varname="Name", type="discrete", plot=FALSE)

get_Helsinki_aluejakokartat <- function(map.specifier=NULL, data.dir = tempdir(), verbose=TRUE) {
  
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
    sp <- rgdal::readOGR(filename, layer = rgdal::ogrListLayers(filename), verbose = verbose, drop_unsupported_fields=T, dropNULLGeometries=T)
  } else {
    sp <- rgdal::readOGR(filename, layer = rgdal::ogrListLayers(filename), verbose = verbose, drop_unsupported_fields=T, dropNULLGeometries=T, encoding="ISO-8859-1", use_iconv=TRUE)
  }
  if (verbose)
    message("\nData loaded successfully!")
  return(sp)
}


#' Retrieve spatial data for Helsinki region
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
#' 'seutukartta', 'piirijako', 'rakennusrekisteri'
#' @param map.specifier  A string. Specify the specific data to retrieve. 
#' Run 'get_Helsinki_mapdata()' to see available options.
#' @param data.dir A string. Specify a temporary folder for storing downloaded data.
#' @param verbose logical. Should R report extra information on progress? 
#'
#' @return Shape object (from SpatialPolygonsDataFrame class)
#' @importFrom rgdal readOGR
#' @importFrom rgdal ogrListLayers
#' @export
#' 
#' @references See citation("fingis") 
#' @author Juuso Parkkinen, Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @examples sp.piiri <- get_Helsinki_spatial(map.type="piirijako", map.specifier="ALUEJAKO_SUURPIIRI");
#'           plot_shape(sp=sp.piiri, varname="NIMI", type="discrete", plot=FALSE);

get_Helsinki_spatial <- function(map.type=NULL, map.specifier=NULL, data.dir = tempdir(), verbose=TRUE) {
  
  # If data not specified, return a list of available options
  if (is.null(map.type) | is.null(map.specifier)) {
    message("Please specify 'map.type' and 'map.specifier'!")
    return(list("seutukartta"=c("A_es_pie", "a_hy_suu", "a_ki_pie", "a_nu_til", "a_tu_til", "l_jrata", " m_jarvet", "N_MERI_R", "A_es_suu", "a_hy_til", "a_ki_suu", "a_pkspie", "a_va_kos", "l_kiitor", "m_joet", "  N_MERI_S", "a_es_til", "a_ja_pie", "a_ki_til", "a_pkstil", "a_va_suu", "l_metras", "m_meri", "  N_PAIK_R", "a_hk_osa", "a_ja_til", "a_kunta", " a_pksuur", "a_vi_pie", "l_metror", "m_rantav", "N_PAIK_S", "a_hk_per", "a_ka_pie", "a_ma_pie", "a_po_til", "a_vi_suu", "l_tiest2", "m_teolal", "a_hk_pie", "a_ka_til", "a_ma_til", "a_si_pie", "a_vi_til", "l_tiesto", "m_vihral", "a_hk_suu", "a_ke_pie", "a_nu_pie", "a_tu_pie", "Copyrig", " Maankay2", "N_KOS_R", "a_hy_pie", "a_ke_til", "a_nu_suu", "a_tu_suu", "l_jasema", "m_asalue", "N_KOS_S"),
                "piirijako"=c("ALUEJAKO_KUNTA", "ALUEJAKO_OSAALUE_TUNNUS", "ALUEJAKO_OSAALUE", "ALUEJAKO_PERUSPIIRI_TUNNUS", "ALUEJAKO_PERUSPIIRI", "ALUEJAKO_PIENALUE_TUNNUS", "ALUEJAKO_PIENALUE", "ALUEJAKO_SUURPIIRI_TUNNUS", "ALUEJAKO_SUURPIIRI"),
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
      message("Licence: 'http://ptp.hel.fi/avoindata/aineistot/Seudullinen_avoimen_tietoaineiston_lisenssi_1.0.pdf'")
    }    
  } else if (map.type=="piirijako") {
    zip.file <- "Helsingin_piirijako_2013.zip"
    if (verbose) {
      message("District Division of the City of Helsinki (Helsingin aluejaot - piirijako)")
      message("For metadata see 'http://ptp.hel.fi/paikkatietohakemisto/?id=139'")
      message("Licence information: 'http://www.hel.fi/hki/Kv/fi/Kaupunkimittausosasto'")
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
    stop("Invalid 'map.type'! Run 'temp=get_Helsinki_mapdata()' to list available options.")
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
  
  # Define spatial data to read
  if (map.type=="seutukartta")
    filename <- file.path(data.dir, "Seutukartta", paste0(map.specifier, ".TAB"))
  else if (map.type=="piirijako")
    filename <- file.path(data.dir, paste0(map.specifier, ".tab"))
  
  else if (map.type=="rakennusrekisteri") {
    if (map.specifier!="20m2_hkikoord") {
      filename <- file.path(data.dir, paste0("rakennukset_Helsinki_", map.specifier), paste0("rakennukset_Helsinki_06_2012_", map.specifier, ".TAB"))
    } else if (map.specifier=="20m2_hkikoord") {
      filename <- file.path(data.dir, paste0("rakennukset_helsinki_", map.specifier), "ratuttomat_alle20m2_rakennukset_Helsinki_06_2012_hkikoord.TAB") 
    } else {
      stop("Invalid 'map.specifier'! Run 'temp=get_Helsinki_mapdata()' to list available options.")
    }
  }
  
  # Check that file exists
  if (!file.exists(filename))
    stop("Invalid 'map.specifier'! Run 'temp=get_Helsinki_mapdata()' to list available options.")
  
  # Read spatial data
  sp <- rgdal::readOGR(filename, layer = rgdal::ogrListLayers(filename), verbose = verbose, drop_unsupported_fields=T, dropNULLGeometries=T, encoding="ISO-8859-1", use_iconv=TRUE)

  if (verbose)
    message("\nData loaded successfully!")
  return(sp)
}
