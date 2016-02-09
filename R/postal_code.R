#' @title Retrieve postal code areas as spatial data
#' @description Retrieves postal code areas from http://www.palomaki.info/apps/pnro/
#' The data is created by Duukkis and licensed under CC BY 4.0
#' Please not that this function requires a recent version of GDAL.
#' Please see the tutorial for more instructions
#' @param data.dir A string. Specify a temporary folder for storing downloaded data.
#' @param verbose logical. Should R report extra information on progress? 
#' @return a spatial object (from SpatialPolygonsDataFrame class)
#' @export
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @references See citation("gisfin")
#' @examples pnro.sp <- get_postalcode_areas()
get_postalcode_areas <- function(data.dir = tempdir(), verbose=TRUE) {
  
  # Create data.dir if it does not exist
  if (!file.exists(data.dir))
    dir.create(data.dir)
  
  if (verbose) {
    message("Finnish postal code areas by Duukkis from http://www.palomaki.info/apps/pnro/")
    message("Version 2.1.2015")
    message("License: CC BY 4.0")
  }
  
  # Set file url
  # Instructions for updating the url as new versions become available
  # 1. Go to http://www.palomaki.info/apps/pnro/
  # 2. Click "Google Fusion Table", and then "Map of Geometry"
  # 3. Click File -> Download -> Format: KML, download the file and get the download URL from your browser
  
  kml.file <- file.path(data.dir, "pnro.kml")  
  kml.url <- "https://www.google.com/fusiontables/exporttable?query=select+col2+from+1m9trydaf6rdt9qBfQkU-4iRKkhNn6O1lRw7XWnXF&o=kml&g=col2&styleId=2&templateId=2"
  if (!RCurl::url.exists(kml.url)) {
    message(paste("Sorry! Url", kml.url, "not available!\nReturned NULL."))
    return(NULL)
  }
  if (verbose)
    message("Downloading ", kml.url, "\ninto ", kml.file, "\n")
  download.file(kml.url, kml.file, method="curl")
  
  # Read kml
  layer.name <- rgdal::ogrListLayers(kml.file)
  pnro.sp <- rgdal::readOGR(dsn=kml.file, layer=layer.name)
  
  # Clean the data (can remove everything else than the name)
  pnro.sp@data <- pnro.sp@data[1]
  names(pnro.sp@data) <- "pnro"
  pnro.sp@data$pnro <- as.character(pnro.sp@data$pnro)
  


  if (verbose)
    message("\nData loaded successfully!")
  return(pnro.sp)
}

