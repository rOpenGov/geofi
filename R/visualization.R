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


#' @title Get blank ggplot2 theme for plotting maps
#' @description Get blank ggplot2 theme for plotting maps
#' @return theme_map A ggplot2 theme object
#' @importFrom ggplot2 theme_bw
#' @importFrom ggplot2 element_blank
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
get_theme_map <- function() {
  
  theme_map <- ggplot2::theme_bw()
  theme_map$panel.background <- ggplot2::element_blank()
  theme_map$panel.grid.major <- ggplot2::element_blank()
  theme_map$panel.grid.minor <- ggplot2::element_blank()
  theme_map$axis.ticks <- ggplot2::element_blank()
  theme_map$axis.text <- ggplot2::element_blank()
  theme_map$axis.title <- ggplot2::element_blank()
  
  return(theme_map)  
}



#' @title Generate color indices
#' @description Generate color indices for shape object with the aim to color neighboring objects with distinct colors.
#' @param sp A SpatialPolygonsDataFrame object
#' @param verbose logical. Should R report extra information on progress? 
#' @return Color index vector
#' @importFrom spdep poly2nb
#' @export
#' @author Modified from the code by Karl Ove Hufthammer from
#' \url{http://r-sig-geo.2731867.n2.nabble.com/Colouring-maps-so-that-adjacent-polygons-differ-in-colour-td6237661.html}; modifications by Leo Lahti and Juuso Parkkinen
#' @references See citation("gisfin") 
#' @examples sp.suuralue <- get_helsinki_aluejakokartat(map.specifier="suuralue");
#'           cols <- factor(generate_map_colours(sp=sp.suuralue));
#' @keywords utilities
generate_map_colours <- function(sp, verbose=TRUE) {
  
  if (verbose)
    message("Generating colours for map regions...")
  
  # Generate neighbours lists
  nb <- spdep::poly2nb(sp)   
  # Number of polygons
  n <- length(sp)            
  # Initial colouring
  cols <- numeric(n)        
  # Let the first polygon have colour 1
  cols[1] <- 1             
  # Available colour indices
  cols1n <- 1:n             
  # Set good colours by magic
  for(i in 2:n)
    cols[i] <- which.min(cols1n %in% cols[nb[[i]]])
  
  return(cols)
}


#' @title Visualize fields
#' @description Visualize the specified fields of a shape object on using 1- or 2-way color scale. 
#' 
#' This function is used for fast investigation of shape objects;
#' standard visualization choices are made automatically;
#' fast and easy-to-use but does not necessarily provide optimal visualization.
#'
#' @param sp Shape object 
#' @param varname Variable name from the shape object sp to be visualized
#' @param type String. Specifies visualization type. Options: "oneway", "twoway", "qualitative", "custom". See details. 
#' @param ncol Number of distinct colors shades
#' @param at Color transition points
#' @param palette Optional. Color palette.
#' @param main Optional. Title text.
#' @param colorkey Logical. Show color interpretation in a separate legend.
#' @param lwd Optional. Line width for shape polygon borders.
#' @param border.col Optional. Color for shape polygon borders.
#' @param col.regions Optional. Specify color for the shape object regions manually.
#' @param min.color Color for minimum values in the color scale
#' @param max.color Color for maximum values in the color scale
#' @param plot Plot the image TRUE/FALSE
#' @return A Trellis Plot Object
#' @details Visualization types include: oneway/sequential (color scale ranges from white to dark red, or custom color given with the palette argument); twoway/bipolar/diverging (color scale ranges from dark blue through white to dark red; or custom colors); discrete/qualitative (discrete color scale; the colors are used to visually separate regions); and "custom" (specify colors with the col.regions argument)
#' @export
#' @references See citation("gisfin") 
#' @author Leo Lahti and Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @examples sp.suuralue <- get_helsinki_aluejakokartat(map.specifier="suuralue"); 
#'           plot_shape(sp=sp.suuralue, varname="Name", type="discrete", plot=FALSE);
#' @keywords utilities
plot_shape <- function (sp, varname, type = "oneway", ncol = 10, at = NULL, palette = NULL, main = NULL, colorkey = TRUE, lwd = .4, border.col = "black", col.regions = NULL, min.color = "white", max.color = "red", plot = TRUE) {
  
  # type = "oneway"; ncol = 10; at = NULL; palette = NULL; main = NULL; colorkey = TRUE; lwd = .4; border.col = "black"; col.regions = NULL
  
  pic <- NULL
  
  if (is.null(main)) {
    main <- varname
  }
  
  if (is.factor(sp[[varname]]) && (!type %in% c("discrete", "qualitative", "custom"))) {
    warning("Discrete/custom color scale required for factors; resetting color type")
    type <- "qualitative"
  }
  
  if (type %in% c("oneway", "quantitative", "sequential")) {
    # Define color palette
    if (is.null(palette)) {
      palette <- colorRampPalette(c(min.color, max.color), space = "rgb")
    }
    
    sp[[varname]] <- as.numeric(as.character(sp[[varname]]))
    
    if (is.null(at)) { 
      mini <- min(sp[[varname]]) - 1
      maxi <- max(sp[[varname]]) + 1
      at <- seq(mini, maxi, length = ncol) 
    } else {
      # Override ncol if at is given
      ncol <- length(at)
    }
    
    if (is.null(main)) {
      main <- varname
    }
    
    if (is.null(col.regions)) {
      col.regions <- palette(ncol)
    }
    
    q <- sp::spplot(sp, varname,
                    col.regions = col.regions,
                    main = main,
                    colorkey = colorkey,
                    lwd = lwd,
                    col = border.col,
                    at = at)
    
    
  } else if (type %in% c("twoway", "bipolar", "diverging")) { 
    
    # Plot palette around the data average
    # To highlight deviations in both directions
    
    # Define color palette
    if (is.null(palette)) {
      palette <- colorRampPalette(c("blue", "white", "red"), space = "rgb")
    }
    
    if (is.null(at)) { 
      
      # Linear color palette around the average
      mini <- min(sp[[varname]])
      maxi <- max(sp[[varname]])
      at <- seq(mini - 1, maxi + 1, length = ncol) 
      
    } else {
      # Override ncol if at is given
      ncol <- length(at)
    }
    # message(at)
    
    if (is.null(main)) {
      main <- varname
    }
    
    if (is.null(col.regions)) {
      col.regions <- palette(ncol)
    }
    
    q <- sp::spplot(sp, varname,
                    col.regions = col.regions,
                    main = main,
                    colorkey = colorkey,
                    lwd = lwd,
                    col = border.col,
                    at = at)
    
  } else if (type %in% c("qualitative", "discrete")) {
    
    vars <- factor(sp[[varname]])
    sp[[varname]] <- vars
    
    if (is.null(col.regions) && length(sp[[varname]]) == length(levels(sp[[varname]]))) {
      # Aims to find colors such that neighboring polygons have 
      # distinct colors
      cols <- generate_map_colours(sp) # Generate color indices
      # Changed 6.5.2014 to use rainbow()
      col.regions <- rainbow(max(cols))[cols]
      # FIXME: check if we could here use standard palettes and avoid dependency  
      #       col.regions <- RColorBrewer::brewer.pal(max(cols), "Paired")[cols]
      
    } else if ( is.null(col.regions) ) {
      
      # Use ncol colors, loop them to fill all regions    
      nlevels <- length(levels(vars))
      # Changed 6.5.2014 to use rainbow()
      col.regions <- rep(rainbow(ncol), ceiling(nlevels/ncol))[1:nlevels]  
      #      col.regions <- rep(RColorBrewer::brewer.pal(ncol, "Paired"), ceiling(nlevels/ncol))[1:nlevels]  
    }
    
    colorkey <- FALSE
    
    pic <- sp::spplot(sp, varname, col.regions = col.regions, main = main, colorkey = colorkey, lwd = lwd, col = border.col)
    
  } else if (type == "custom") {
    
    # User-defined colors for each region  
    if (is.null(col.regions)) {  
      stop("Define region colors through the col.regions argument 
      		   in the custom mode!")
    }
  }
  
  if (is.null(col.regions)) {
    col.regions <- palette(ncol)
  }
  
  if (is.null(pic)) {
    pic <- sp::spplot(sp, varname, col.regions = col.regions, main = main, colorkey = colorkey, lwd = lwd, col = border.col, at = at)
  }
  
  if (plot) {	  
    print(pic)
  }
  
  pic
}



