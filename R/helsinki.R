# ---------------------------------------------------------------------

#' Retrieve District Boundaries in Helsinki
#'
#' Retrieves District Boundaries data (Aluejakorajat) from Helsinki 
#' Real Estate Department (Helsingin 
#' kaupungin kiinteistovirasto, HKK) through the HKK website
#' http://kartta.hel.fi/avoindata/index.html
#'
#' The data (C) 2011 Helsingin kaupunkimittausosasto.
#' 
#' @param map  A string. Specify the name of the Helsinki District Boundary data set to retrieve. Available options: c("kunta", "pienalue", "suuralue", "tilastoalue")
#'
#' @return a list of Shape objects (from SpatialPolygonsDataFrame class)
#' @importFrom rgdal readOGR
#' @importFrom rgdal ogrListLayers
#' @export
#' @note This function replaces sorvi::GetHRIaluejakokartat; The data is now retrieved directly from HKK.
#' @details Also aluejako_alueet_ja_pisteet file is available in the original HKK zip file. This contains all maps in a single list of shape objects and is thus redundant. We have ignored this for simplicity. There are also map versions "pienalue_piste"; "suuralue_piste"; "tilastoalue_piste". These point maps are not currently implemented.
#' @references
#' See citation("helsinki") 
#' @author Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # res <- GetDistrictBoundariesHelsinki("tilastoalue"); 
#'           # sp <- res$shape; df <- res$data
#'           # pdf("~/tmp/tmp.pdf"); PlotShape(sp, "Name"); dev.off()
  
GetDistrictBoundariesHelsinki <- function( map, data.dir = "." ) {

  # Need to install package rgdal
  # Mac users, see http://www.r-bloggers.com/installing-rgdal-on-mac-os-x-2/

  message(paste("Reading Helsinki Aluejakorajat data from ", "http://kartta.hel.fi/avoindata/aineistot/PKS_Kartta_Rajat_KML2011.zip", " (C) HKK 2011"))
  
  data.url <- "http://kartta.hel.fi/avoindata/aineistot/"

  if (is.null(data.dir)) {data.dir <- tempdir() }

  # Aluejakorajat:
  # HKK: http://kartta.hel.fi/avoindata/aineistot/PKS_Kartta_Rajat_KML2011.zi
  # HRI: Same data available in http://www.hri.fi/fi/data/paakaupunkiseudun-aluejakokartat/

  #> dir(data.dir)
  # "Kartta_avoindata_kayttoehdot_v02_3_2011.pdf"

  # Remote zip to download
  remote.zip <- "PKS_Kartta_Rajat_KML2011.zip"
  unzip.files(data.dir, remote.zip, local.zip, data.url, map)

  # Read the specified map	       
  f <- file.path(data.dir, paste("PKS_", map, ".kml", sep = ""))

  #.InstallMarginal("rgdal")
  #.InstallMarginal("gpclib")
  #.InstallMarginal("ggplot2") 
  #gpclibPermit()

  # Shape file or list of shape files; one for each layer
  res <- readmap(f)

  # Remove temporary directory
  unlink(data.dir, recursive=T)

  res

}


readmap <- function (f) {

  lyr <- rgdal::ogrListLayers(f)

  maps <- list()
  dfs <- list()

  if (length(lyr) > 1) { stop(paste("Multiple layers in ", f, ". Check!")) }

  for (k in 1:length(lyr)) {

    layername <- lyr[[k]]

    message(paste("Reading layer", layername))
    sp <- rgdal::readOGR(f, layer = layername, verbose = TRUE, drop_unsupported_fields=T, dropNULLGeometries=T)

    sp@data$id <- rownames(sp@data) # Add IDs
    sp.points <- ggplot2::fortify(sp, region="Name") # Get point data
    sp.points$group <- sub(".1", "", sp.points$group) # Regex to joinable format

    df <- merge(sp.points, sp@data, by.x="group", by.y = "Name") # Put everything together
    df <- df[order(df$order),] # sort DF so that polygons come out in the right order
    df$Name <- df$group
    df$group <- df$id.x <- df$id <- df$id.y <- NULL    

    # Fix encoding
    #df$Nimi <- factor(iconv(df$Nimi, from="ISO-8859-1", to="UTF-8"))
    #df$NIMI_ISO <- factor(iconv(df$NIMI_ISO, from="ISO-8859-1", to="UTF-8"))
    #df$Name <- factor(iconv(df$Name, from="ISO-8859-1", to="UTF-8"))
    #sp@data$Nimi <- factor(iconv(sp@data$Nimi, from="ISO-8859-1", to="UTF-8"))
    #sp@data$NIMI_ISO <- factor(iconv(sp@data$NIMI_ISO, from="ISO-8859-1", to="UTF-8"))
    #sp@data$Name <- factor(iconv(sp@data$Name, from="ISO-8859-1", to="UTF-8"))
    #return(list(shape = sp, df = df))

    maps[[layername]] <- sp
    dfs[[layername]] <- df
  }

  if (length(lyr) == 1) { 
    maps <- maps[[1]]
    dfs <- dfs[[1]]
  }

  list(shape = maps, data = dfs)

}

# ---------------------------------------------------

#' Retrieve Helsinki Election District data 
#' from Helsinki Real Estate Department (Helsingin 
#' kaupungin kiinteistovirasto, HKK) through the HKK website
#' http://kartta.hel.fi/avoindata/index.html
#'
#' The data (C) 2011 Helsingin kaupunkimittausosasto.
#' 
#' @param city Name the municipality for which to retrieve the election districts
#'
#' @return a list of Shape objects (from SpatialPolygonsDataFrame class)
#' @export
#' @references
#' See citation("helsinki") 
#' @author Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # sp <- GetElectionDistrictsHelsinki()

GetElectionDistrictsHelsinki <- function( ... ) {

  # TODO: should we combine this with GetDistrictBoundariesHelsinki ?
  
  data.url <- "http://kartta.hel.fi/avoindata/aineistot/"
  data.dir <- tempdir()  

    # Remote zip to download
    remote.zip <- "pk_seudun_aanestysalueet.zip"
    unzip.files(data.dir, remote.zip, local.zip, data.url, which.data)

    # dir(data.dir)

    # Paakaupunkiseudun aanestysalueiden tunnukset ja nimet Tilastokeskuksen 
    # StatFin-vaalitietopalvelussa 2012. Not used in this function for now.
    # Since these seem to be listed in the final shapefile anyway.
    #"Aanestysaluekoodit.xls" 

    #"Avoin lisenssi aanestysalueet.pdf" 
    #"PKS_aanestysalueet_kkj2.DAT" -> Associated with the TAB file?      
    #"PKS_aanestysalueet_kkj2.ID"  -> Associated with the TAB file?      
    #"PKS_aanestysalueet_kkj2.MAP" -> Associated with the TAB file?      
    #"PKS_aanestysalueet_kkj2.TAB" -> Used in this function     
    #"PKS_aanestysalueet_kkj2.txt" -> Skipped for now, presumably the 
    #                                 same information as in the mapinfo files

    mapinfo.file <- file.path(data.dir, "PKS_aanestysalueet_kkj2.TAB")
    
    sp.cities <- rgdal::readOGR(mapinfo.file, 
                                 layer = rgdal::ogrListLayers(mapinfo.file))
    
    # Fix encoding
    sp.cities@data$TKNIMI <- factor(iconv(sp.cities@data$TKNIMI, 
                                          from="ISO-8859-1", to="UTF-8"))
    sp.cities@data$Nimi <- factor(iconv(sp.cities@data$Nimi, 
                                        from="ISO-8859-1", to="UTF-8"))
    # Remove temporary directory
    unlink(data.dir, recursive=T)
    
    return(sp.cities)
    
}


 
   
