#' @title Transform data from sp to data frame for ggplot2
#' @description Transform data from sp to data frame for ggplot2
#' @param sp A spatial object to be transformed
#' @param region A string specifying the region of interest
#' @param verbose logical. Should R report extra information on progress? 
#' @return A ggplot2 theme object
#' @importFrom ggplot2 fortify
#' @export
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @references See citation("gisfin")
#' @examples sp.suuralue <- get_helsinki_aluejakokartat(map.specifier="suuralue");
#'           # Need to load rgeos and maptools for ggplot2::fortify in sp2df() 
#'           library(rgeos);
#'           library(maptools);
#'           # Transform to df and plot with ggplot2
#'           df.suuralue <- sp2df(sp.suuralue, "Name");
#'           library(ggplot2);
#'           theme_set(get_theme_map());
#'           ggplot(df.suuralue, aes(x=long, y=lat, fill=Name)) + 
#'           geom_polygon() + theme(legend.position="none")
sp2df <- function(sp, region=NULL, verbose=TRUE) {
    
  if (verbose)
    message("Transforming ", class(sp), " into a data frame")
  if (!is.null(region))
    message("Parameter 'region' not used anymore!")
  
  if (class(sp)=="SpatialPointsDataFrame") {
    # Construct data frame manually, as ggplot::fortify can not handle SpatialPoints
#     if (!is.null(region) & verbose)
#       message("Note! parameter 'region' not used for SpatialPointsDataFrame")
    df <- data.frame(long=sp@coords[,1], lat=sp@coords[,2], sp@data)
    
  } else {
#     if (is.null(region))
#       stop("Please specify 'region'!")
    
    ## NEW implementation 6.1.2015
    # Following https://github.com/hadley/ggplot2/wiki/plotting-polygon-shapefiles
    sp@data$id <- rownames(sp@data)
    sp.points <- ggplot2::fortify(sp, region="id")
    df <- merge(sp.points, sp@data, by="id")
    
    ## NEW implementation 8.5.2014
#     # Get point data
#     sp.points <- ggplot2::fortify(sp, region=region)
#     names(sp.points)[names(sp.points)=="id"] <- region
#     # Merge original data
#     df <- merge(sp.points, sp@data, by=region) 
    
    ## OLD implementation
#     # Add IDs 
#     sp@data$id <- rownames(sp@data) 
#     # Get point data
#     sp.points <- ggplot2::fortify(sp, region=region)
#     # Regex to joinable format
#     sp.points$group <- sub(".1", "", sp.points$group) 
#     # Put everything together
#     df <- merge(sp.points, sp@data, by.x="group", by.y = region, all.x=TRUE) 
#     
#     # sort DF so that polygons come out in the right order
#     df <- df[order(df$order),] 
#     df[[region]] <- df$group
#     df$group <- df$id.x <- df$id <- df$id.y <- NULL 
  }
  return(df)  
}



