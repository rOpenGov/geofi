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
#' @param map.type  A string. Specify the name of the Helsinki District Boundary data set to retrieve. Available options: c("kunta", "pienalue", "pienalue_piste",
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
  sp <- rgdal::readOGR(filename, layer = rgdal::ogrListLayers(filename), verbose = TRUE, drop_unsupported_fields=T, dropNULLGeometries=T)
  sp@data$id <- rownames(sp@data) # Add IDs

  # Fix encoding for aanestysalue
  if (map.type == "aanestysalue") {
    sp@data$TKNIMI <- factor(iconv(sp@data$TKNIMI, from="ISO-8859-1", to="UTF-8"))
    sp@data$Nimi <- factor(iconv(sp@data$Nimi, from="ISO-8859-1", to="UTF-8"))
  }
  
  ## NOTE: data.frame stuff for ggplot2 to be implemented separately
  
  message("\nData loaded successfully!")
  return(sp)
}


