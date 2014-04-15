# ---------------------------------------------------------------------

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
#' @param map.type  A string. Specify the name of the
#' Helsinki District Boundary data set to retrieve.
#' Available options: c("kunta", "pienalue", "pienalue_piste",
#' "suuralue", "suuralue_piste", "tilastoalue", "tilastoalue_piste")
#' @param data.dir A string. Specify a temporary folder for storing downloaded data.
#'
#' @return a shape object (from SpatialPolygonsDataFrame class)
#' @importFrom rgdal readOGR
#' @importFrom rgdal ogrListLayers
#' @export
#' @note This function replaces sorvi::GetHRIaluejakokartat; The data is now retrieved directly from HKK.
#' @details Also aluejako_alueet_ja_pisteet file is available in the original HKK zip file. This contains all maps in a single list of shape objects and is thus redundant. We have ignored this for simplicity.
#' @references
#' See citation("fingis") 
#' @author Juuso Parkkinen, Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # sp <- get_Helsinki_district_boundaries("suuralue"); 
#'           # spplot(sp, "Name")

get_Helsinki_district_boundaries <- function(map.type=NULL, data.dir = tempdir()) {
  
  if (is.null(map.type)) {
    message("Available map types: kunta, pienalue, pienalue_piste, suuralue, suuralue_piste, tilastoalue, tilastoalue_piste, aanestysalue")
    stop("Please specify 'map.type'")
  }
  
  # Create data.dir if it does not exist
  if (!file.exists(data.dir))
    dir.create(data.dir)
  
  #  message(paste("Reading Helsinki Aluejakorajat data from ", "http://kartta.hel.fi/avoindata/aineistot/PKS_Kartta_Rajat_KML2011.zip", " (C) HKK 2011"))
  
  ## Download data -----------------------------------
  
  # Define data to download
  if (map.type %in% c("kunta", "pienalue", "pienalue_piste", "suuralue", "suuralue_piste", "tilastoalue", "tilastoalue_piste")) {
    zip.file <- "PKS_Kartta_Rajat_KML2011.zip"
  } else if (map.type == "aanestysalue") {
    zip.file <- "pk_seudun_aanestysalueet.zip"
  }
  
  # Download data
  remote.zip <- paste0("http://ptp.hel.fi/avoindata/aineistot/", zip.file)
  local.zip <-  file.path(data.dir, zip.file)
  if (!file.exists(local.zip)) {
    message("Dowloading ", remote.zip, "\ninto ", local.zip, "\n")
    utils::download.file(remote.zip, destfile = local.zip)
  } else {
    message("File ", local.zip, " already found, will not download!")
  }
  
  ## Process data ------------------------------
  
  # Unzip the downloaded zip file
  utils::unzip(local.zip, exdir = data.dir)
  
  # Specify spatial data file to read
  if (map.type %in% c("kunta", "pienalue", "suuralue", "tilastoalue")) {
    filename <- file.path(data.dir, paste0("PKS_", map.type, ".kml"))
  } else if (map.type == "aanestysalue") {
    filename <- file.path(data.dir, "PKS_aanestysalueet_kkj2.TAB")
  }
  
  # Read spatial data
  message("Reading filename ", filename)
  # TODO: fix warning about Z-dimension discarded
  sp <- rgdal::readOGR(filename, layer = rgdal::ogrListLayers(filename), verbose = TRUE, drop_unsupported_fields=T, dropNULLGeometries=T, encoding="ISO-8859-1", use_iconv=TRUE)
  sp@data$id <- rownames(sp@data) # Add IDs
  
#   # Fix encoding for aanestysalue
#   if (map.type == "aanestysalue") {
#     sp@data$TKNIMI <- factor(iconv(sp@data$TKNIMI, from="ISO-8859-1", to="UTF-8"))
#     sp@data$Nimi <- factor(iconv(sp@data$Nimi, from="ISO-8859-1", to="UTF-8"))
#   }
  
  message("\nData loaded successfully!")
  return(sp)
}



#' Retrieve HKK Seutukartta data 
#'
#' Retrieves Seutukartta data from Helsinki Real Estate Department (Helsingin 
#' kaupungin kiinteistovirasto, HKK) through the HKK website
#' http://kartta.hel.fi/avoindata/index.html
#'
#' For licensing information and other details, see http://kartta.hel.fi/avoindata/aineistot/Seutukartan%20avoimen%20datan%20lisenssi_1_11_2011.pdf 
#'
#' @param map  A string. Specify the name of the HKK data set to retrieve. Options: "A_es_pie", "a_hy_suu", "a_ki_pie", "a_nu_til", "a_tu_til", "l_jrata", " m_jarvet", "N_MERI_R", "A_es_suu", "a_hy_til", "a_ki_suu", "a_pkspie", "a_va_kos", "l_kiitor", "m_joet", "  N_MERI_S", "a_es_til", "a_ja_pie", "a_ki_til", "a_pkstil", "a_va_suu", "l_metras", "m_meri", "  N_PAIK_R", "a_hk_osa", "a_ja_til", "a_kunta", " a_pksuur", "a_vi_pie", "l_metror", "m_rantav", "N_PAIK_S", "a_hk_per", "a_ka_pie", "a_ma_pie", "a_po_til", "a_vi_suu", "l_tiest2", "m_teolal", "a_hk_pie", "a_ka_til", "a_ma_til", "a_si_pie", "a_vi_til", "l_tiesto", "m_vihral", "a_hk_suu", "a_ke_pie", "a_nu_pie", "a_tu_pie", "Copyrig", " Maankay2", "N_KOS_R", "a_hy_pie", "a_ke_til", "a_nu_suu", "a_tu_suu", "l_jasema", "m_asalue", "N_KOS_S"
#'
#' @return Shape object (from SpatialPolygonsDataFrame class)
#' @importFrom rgdal readOGR
#' @importFrom rgdal ogrListLayers
#' @export
#' 
#' @references
#' See citation("fingis") 
#' @author Juuso Parkkinen, Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # tab <- get_Helsinki_Seutukartta("m_rantav")

get_Helsinki_Seutukartta <- function(map.type=NULL, data.dir = tempdir()) {
  
  if (is.null(map.type)) {
    message("Available map types: a lot!")
    stop("Please specify 'map.type'")
  }
  
  # Create data.dir if it does not exist
  if (!file.exists(data.dir))
    dir.create(data.dir)

  ## Download data -----------------------------------
  
  # Download data
  zip.file <- "sk14_avoin.zip"
  remote.zip <- paste0("http://ptp.hel.fi/avoindata/aineistot/", zip.file)
  local.zip <-  file.path(data.dir, zip.file)
  if (!file.exists(local.zip)) {
    message("Dowloading ", remote.zip, "\ninto ", local.zip, "\n")
    utils::download.file(remote.zip, destfile = local.zip)
  } else {
    message("File ", local.zip, " already found, will not download!")
  }

  ## Process data ------------------------------
  
  # Unzip the downloaded zip file
  utils::unzip(local.zip, exdir = data.dir)
  
  # Define spatial data to read
  filename <- file.path(data.dir, "Seutukartta", paste0(map.type, ".TAB"))
  
  # Read spatial data
  sp <- rgdal::readOGR(filename, layer = rgdal::ogrListLayers(filename), verbose = TRUE, drop_unsupported_fields=T, dropNULLGeometries=T, encoding="ISO-8859-1", use_iconv=TRUE)
  sp@data$id <- rownames(sp@data) # Add IDs
  
  return(sp)
}


#' Retrieve Helsingin piirijako data from HKK
#'
#' Retrieves Helsingin piirijako data from Helsinki Real Estate Department (Helsingin 
#' kaupungin kiinteistovirasto, HKK) through the HKK website
#' http://kartta.hel.fi/avoindata/index.html
#'
#' The data (C) 2011 Helsingin kaupunkimittausosasto.
#'
#' @param map  A string. Specify the name of the HKK data set to retrieve. Options:
#' "ALUEJAKO_KUNTA", "ALUEJAKO_OSAALUE_TUNNUS", "ALUEJAKO_OSAALUE",
#' "ALUEJAKO_PERUSPIIRI_TUNNUS", "ALUEJAKO_PERUSPIIRI", "ALUEJAKO_PIENALUE_TUNNUS",
#' "ALUEJAKO_PIENALUE", "ALUEJAKO_SUURPIIRI_TUNNUS", "ALUEJAKO_SUURPIIRI"    
#'
#' @return Shape object (from SpatialPolygonsDataFrame class)
#' @importFrom rgdal readOGR
#' @importFrom rgdal ogrListLayers
#' @export
#' 
#' @references
#' See citation("fingis") 
#' @author Juuso Parkkinen, Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # tab <- get_Helsinki_Piirijako("m_rantav")

get_Helsinki_Piirijako <- function(map.type=NULL, data.dir = tempdir()) {
  
  if (is.null(map.type)) {
    message("Available map types: 'ALUEJAKO_KUNTA', 'ALUEJAKO_OSAALUE_TUNNUS', 'ALUEJAKO_OSAALUE', 'ALUEJAKO_PERUSPIIRI_TUNNUS', 'ALUEJAKO_PERUSPIIRI', 'ALUEJAKO_PIENALUE_TUNNUS', ' 'ALUEJAKO_PIENALUE', 'ALUEJAKO_SUURPIIRI_TUNNUS', 'ALUEJAKO_SUURPIIRI'")
    stop("Please specify 'map.type'")
  }
  
  # Create data.dir if it does not exist
  if (!file.exists(data.dir))
    dir.create(data.dir)
  
  ## Download data -----------------------------------
  
  # Download data
  zip.file <- "Helsingin_piirijako_2013.zip"
  remote.zip <- paste0("http://ptp.hel.fi/avoindata/aineistot/", zip.file)
  local.zip <-  file.path(data.dir, zip.file)
  if (!file.exists(local.zip)) {
    message("Dowloading ", remote.zip, "\ninto ", local.zip, "\n")
    utils::download.file(remote.zip, destfile = local.zip)
  } else {
    message("File ", local.zip, " already found, will not download!")
  }
  
  ## Process data ------------------------------
  
  # Unzip the downloaded zip file
  utils::unzip(local.zip, exdir = data.dir)
  
  # Define spatial data to read
  filename <- file.path(data.dir, paste0(map.type, ".tab"))
  
  # Read spatial data
  sp <- rgdal::readOGR(filename, layer = rgdal::ogrListLayers(filename), verbose = TRUE, drop_unsupported_fields=T, dropNULLGeometries=T, encoding="ISO-8859-1", use_iconv=TRUE)
  sp@data$id <- rownames(sp@data) # Add IDs
  
  return(sp)
}