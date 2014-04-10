# This file is a part of the sorvi program (http://louhos.github.com/sorvi/)

# Copyright (C) 2010-2013 Louhos <louhos.github.com>. All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#' Get blank ggplot2 theme for plotting maps
#'
#' @return theme_map A ggplot2 theme object
#' @importFrom ggplot2 theme_bw
#' @importFrom ggplot2 element_blank
#' @export
#' 
#' @references See citation("fingis")
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @examples # get_theme_map(); 
get_theme_map <- function() {
  
  theme_map <- ggplot2::theme_bw()
  theme_map$panel.background <- ggplot2::element_blank()
  theme_map$panel.grid.major <- ggplot2::element_blank()
  theme_map$panel.grid.minor <- ggplot2::element_blank()
  theme_map$axis.ticks <- ggplot2::element_blank()
  theme_map$axis.text.x <- ggplot2::element_blank()
  theme_map$axis.text.y <- ggplot2::element_blank()
  theme_map$axis.title.x <- ggplot2::element_blank()
  theme_map$axis.title.y <- ggplot2::element_blank()
  
  return(theme_map)  
}


#' Retrieve shape objects by their file names.
#'  
#' Takes list of shape file names (or IDs without the .shp ending).
#' Returns a corresponding list of shape objects from the working directory, 
#' or from the directory path specified as part of the file name.
#'
#' @param files vector of input files
#' @param proj4string projection information
#' @return shape object, or a list of shape objects, depending on the length of function argument (a single file name vs. multiple file names)
#' @export 
#' @references
#' See citation("sorvi") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # ReadShape(files)
#' @keywords utilities

ReadShape <- function (files, proj4string = NA) {

  # FIXME: Can we move completely to readOGR in shape file i/o?	  

  .InstallMarginal("maptools")

  ids <- unlist(sapply(files, function (x) {strsplit(x, "\\.")[[1]][[1]]}))
   
  shapedata <- list()

  for (id in ids) {
    print(id)
    shapedata[[id]] <- try(maptools::readShapePoly(id, 
                                         proj4string=CRS(as.character(proj4string))))
  }

  # If just one file converted, give directly the shape file as out put
  # (and not a list)
  if (length(files) == 1) {
    shapedata <- shapedata[[1]]
  }

  shapedata

}



#' Visualize the specified fields of a shape object on using 
#' 1- or 2-way color scale. 
#' 
#' This function is used for fast investigation of shape objects; standard visualization choices are made
#' automatically; fast and easy-to-use but does not necessarily provide optimal visualization.
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
#'
#' @return ggplot2 object
#' @details Visualization types include: oneway/sequential (color scale ranges from white to dark red, or custom color given with the palette argument); twoway/bipolar/diverging (color scale ranges from dark blue through white to dark red; or custom colors); discrete/qualitative (discrete color scale; the colors are used to visually separate regions); and "custom" (specify colors with the col.regions argument)
#' @export
#' @autoImport
#' @references
#' See citation("sorvi") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @examples # PlotShape(sp, varname) 
#' @keywords utilities
PlotShape <- function (sp, varname, type = "oneway", ncol = 10, at = NULL, palette = NULL, main = NULL, colorkey = TRUE, lwd = .4, border.col = "black", col.regions = NULL, min.color = "white", max.color = "red", plot = TRUE) {

  # type = "oneway"; ncol = 10; at = NULL; palette = NULL; main = NULL; colorkey = TRUE; lwd = .4; border.col = "black"; col.regions = NULL

  # FIXME: check if we could here use standard palettes and avoid dependency
  .InstallMarginal("RColorBrewer")

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

    q <- spplot(sp, varname,
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

    q <- spplot(sp, varname,
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
      cols <- sorvi::GenerateMapColours(sp) # Generate color indices
      col.regions <- RColorBrewer::brewer.pal(max(cols), "Paired")[cols]

    } else if ( is.null(col.regions) ) {
      
      # Use ncol colors, loop them to fill all regions    
      nlevels <- length(levels(vars))
      col.regions <- rep(RColorBrewer::brewer.pal(ncol, "Paired"), ceiling(nlevels/ncol))[1:nlevels]

    }

    colorkey <- FALSE

    pic <- spplot(sp, varname, col.regions = col.regions, main = main, colorkey = colorkey, lwd = lwd, col = border.col)

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
    pic <- spplot(sp, varname, col.regions = col.regions, main = main, colorkey = colorkey, lwd = lwd, col = border.col, at = at)
  }


  if (plot) {	  
    print(pic)
  }

  pic
}



#' Generate color indices for shape object with the aim to color 
#  neighboring objects with distinct colors.
#'
#' @param sp SpatialPolygonsDataFrame object
#' @return Color index vector
#' @references See citation("sorvi") 
#' @export
#' @author Modified from the code by Karl Ove Hufthammer from http://r-sig-geo.2731867.n2.nabble.com/Colouring-maps-so-that-adjacent-polygons-differ-in-colour-td6237661.html; modifications by Leo Lahti
#' @examples # col <- GenerateMapColours(sp)    
#' @keywords utilities


GenerateMapColours <- function(sp) {

  nb <- spdep::poly2nb(sp)   # Generate neighbours lists

  n <- length(sp)            # Number of polygons

  cols <- numeric(n)        # Initial colouring

  cols[1] <- 1              # Let the first polygon have colour 1

  cols1n <- 1:n             # Available colour indices

  for(i in 2:n)
    cols[i] <- which.min(cols1n %in% cols[nb[[i]]])

  cols

}


#' PlotSurface: visualize 3D surface
#'
#' Arguments:
#'   @param mat data matrix describing the surface
#'   @param colorlut surface colors
#'
#' Returns:
#'   @return Used for side effects. Return: NULL
#'
#' @export
#' @references
#' See citation("sorvi") 
#' @author Janne Aukia. Contact: \email{louhos@@googlegroups.com}
#' @examples # 
#' @keywords utilities

PlotSurface <- function(mat, colorlut = NULL) {

  .InstallMarginal("rgl")

  if (is.null(colorlut)) {
    colorlut <- natural.colors()
  }

  nmat <- NormalizeValues(mat)
  col <- colorlut[nmat+1]  
  rgl::surface3d(0:(nrow(mat)-1), 0:(ncol(mat)-1), mat, color = col)
  return(NULL)
}


#' natural.colors: map colors
#'
#' Arguments:
#'   @param ... Arguments to be passed.
#'
#' Returns:
#'   @return colorlut
#'
#' @references
#' See citation("sorvi") 
#' @author Janne Aukia. Contact: \email{louhos@@googlegroups.com}
#' @examples # 
#' @keywords utilities

natural.colors <- function(...) {
  
  colors <- colorRampPalette(c("cornflowerblue","darkolivegreen4","chartreuse4","chocolate4"))
  colorlut <- colors(100)[c(1,seq(0,25,length.out=7),
			seq(25,50,length.out=80),
		    	seq(50,75,length.out=100),
			seq(75,100,length.out=255))] 
  return(colorlut)

}

#' NormalizeValues: normalize coordinate values (auxiliary function)
#'
#' Arguments:
#'   @param mat data matrix
#'
#' Returns:
#'   @return normalized data matrix
#'
#' @references
#' See citation("sorvi") 
#' @author Janne Aukia. Contact: \email{louhos@@googlegroups.com}
#' @examples # 
#' @keywords utilities

NormalizeValues <- function ( mat ) {
	
  mat <- mat-min(na.omit(mat))
  mat <- mat/max(na.omit(mat))
  mat <- mat*255
  return(mat)	

}


