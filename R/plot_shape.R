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



