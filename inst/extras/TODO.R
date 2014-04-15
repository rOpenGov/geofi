



# #' Retrieve HKK Seutukartta data 
# #'
# #' Retrieves Seutukartta data from Helsinki Real Estate Department (Helsingin 
# #' kaupungin kiinteistovirasto, HKK) through the HKK website
# #' http://kartta.hel.fi/avoindata/index.html
# #'
# #' For licensing information and other details, see http://kartta.hel.fi/avoindata/aineistot/Seutukartan%20avoimen%20datan%20lisenssi_1_11_2011.pdf 
# #'
# #' @param map  A string. Specify the name of the HKK data set to retrieve. Options: "A_es_pie", "a_hy_suu", "a_ki_pie", "a_nu_til", "a_tu_til", "l_jrata", " m_jarvet", "N_MERI_R", "A_es_suu", "a_hy_til", "a_ki_suu", "a_pkspie", "a_va_kos", "l_kiitor", "m_joet", "  N_MERI_S", "a_es_til", "a_ja_pie", "a_ki_til", "a_pkstil", "a_va_suu", "l_metras", "m_meri", "  N_PAIK_R", "a_hk_osa", "a_ja_til", "a_kunta", " a_pksuur", "a_vi_pie", "l_metror", "m_rantav", "N_PAIK_S", "a_hk_per", "a_ka_pie", "a_ma_pie", "a_po_til", "a_vi_suu", "l_tiest2", "m_teolal", "a_hk_pie", "a_ka_til", "a_ma_til", "a_si_pie", "a_vi_til", "l_tiesto", "m_vihral", "a_hk_suu", "a_ke_pie", "a_nu_pie", "a_tu_pie", "Copyrig", " Maankay2", "N_KOS_R", "a_hy_pie", "a_ke_til", "a_nu_suu", "a_tu_suu", "l_jasema", "m_asalue", "N_KOS_S"
# #'
# #' @return Shape object (from SpatialPolygonsDataFrame class)
# #' @references
# #' See citation("helsinki") 
# #' @author Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
# #' @examples # tab <- GetRegionalMapsHelsinki("m_rantav")
# 
# GetRegionalMapsHelsinki <- function( map ) {
#   
#   stop("GetRegionalMapsHelsinki to be implemented. The rgdal functions not yet working with this.")
# 
#   # TODO: find out how to read the map files from the zip and implement
#   # export when ready
# 
#   skip <- TRUE
#   
#   if (!skip) {
# 
#   data.url <- "http://kartta.hel.fi/avoindata/aineistot/"
#   data.dir <- tempdir()  
# 
#   # Seutukartta: 
#   # http://kartta.hel.fi/avoindata/aineistot/sk11_avoin.zip
#     
#   # Remote zip to download
#   remote.zip <- "sk11_avoin.zip"
#   unzip.files(data.dir, remote.zip, local.zip, data.url, map)
#   
#   # Specify the file name
#   f <- file.path(data.dir, paste(map, ".TAB", sep = ""))
#   
#   # This works!
# #   data.dir <- "/Users/juusoparkkinen/Downloads/Seutukartta/"
# #   files <- dir(data.dir, pattern=".TAB")
# #   for (fi in seq(files)) {      
# #     f <- file.path(data.dir, files[fi])
# #     l1 <- rgdal::ogrListLayers(f)
# # #    temp <- rgdal::readOGR(f, layer=l1)
# #     # This helped to read the few files with scandinavian characters
# #     temp <- rgdal::readOGR(f, layer=l1, encoding="ISO-8859-1", use_iconv=TRUE)
# #   }
# 
#   
#   # Read map layers
#   layers <- rgdal::ogrListLayers(f)
# 
#   # Read Shape object
#   sp <- rgdal::readOGR(f, layer = layers)
#     
#   # Fix encoding
#   #sp@data$Nimi <- factor(iconv(sp@data$Nimi, 
#   #                                      from="ISO-8859-1", to="UTF-8"))
# 
#   # Remove temporary directory
#   unlink(data.dir, recursive=T)
#     
#   return(sp)
# 
#   }
# 
# }



# #' Retrieve Helsingin piirijako data from HKK
# #'
# #' Retrieves Helsingin piirijako data from Helsinki Real Estate Department (Helsingin 
# #' kaupungin kiinteistovirasto, HKK) through the HKK website
# #' http://kartta.hel.fi/avoindata/index.html
# #'
# #' The data (C) 2011 Helsingin kaupunkimittausosasto.
# #' 
# #' @param which.data  A string. Specify the name of the HKK data set to retrieve. Options: Seutukartta
# #'
# #' @return a list of Shape objects (from SpatialPolygonsDataFrame class)
# 
# #' @references
# #' See citation("helsinki") 
# #' @author Joona Lehtomaki and Leo Lahti \email{louhos@@googlegroups.com}
# #' @examples # tab <- GetHelsinkiPiirijako("ALUEJAKO_KUNTA")
# 
# GetHelsinkiPiirijako <- function( which.data ) {
# 
#   # TODO: could not read the map files from the zip with readOGR
#   # Find out how to do and implement		     
#   # Then export the function
#   stop(paste("GetHelsinkiPiirijako not implemented"))
# 
#   data.url <- "http://kartta.hel.fi/avoindata/aineistot/"
#   data.dir <- tempdir()  
# 
#   skip <- TRUE
# 
#   if (!skip) {
# 
#   # Helsingin piirijako:
#   # http://kartta.hel.fi/avoindata/aineistot/Helsingin_piirijako_2013.zip
# 
#   remote.zip <- "Helsingin_piirijako_2013.zip"
#   unzip.files(data.dir, remote.zip, local.zip, data.url, which.data)
# 
#   # Specify the file name
#   f <- file.path(data.dir, paste(map, ".TAB", sep = ""))
#   
# #   data.dir <- "/Users/juusoparkkinen/Downloads/Helsingin_piirijako_2013//"
# #   files <- dir(data.dir, pattern=".tab")
# #   for (fi in seq(files)) {      
# #     f <- file.path(data.dir, files[fi])
# #     l1 <- rgdal::ogrListLayers(f)
# #     temp <- rgdal::readOGR(f, layer=l1)
# # #     # This helped to read the few files with scandinavian characters
# # #     temp <- rgdal::readOGR(f, layer=l1, encoding="ISO-8859-1", use_iconv=TRUE)
# #   }
#   
#   
#   # Read map layers
#   layers <- rgdal::ogrListLayers(f)
# 
#   # Read Shape object
#   sp <- rgdal::readOGR(f, layer = layers)
#     
#   # Fix encoding
#   #sp@data$Nimi <- factor(iconv(sp@data$Nimi, 
#   #                                      from="ISO-8859-1", to="UTF-8"))
# 
#   # Remove temporary directory
#   unlink(data.dir, recursive=T)
#     
#   return(sp)
# 
#   }
# 
# }
# 
