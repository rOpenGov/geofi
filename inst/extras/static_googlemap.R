#' Load static Google Map
#'
#' Get static map from Google Maps API and convert it to ggplot2-compatible form.
#' See Terms and Conditions from http://code.google.com/apis/maps/documentation/staticmaps/index.html.
#' https://github.com/hadley/ggplot2/wiki/Crime-in-Downtown-Houston,-Texas-:-Combining-ggplot2-and-Google-Maps
#'
#' @param center Coordinates for the center of the map
#' @param zoom Zoom-level
#' @param GRAYSCALE Grayscale or colours?
#' @param scale Scale of the map, 1: less details, faster to load, 2: more details, much slower to load
#' @param maptype Type of the map
#' @param destfile Temporary file to save the obtained map picture
#' @param n_pix Size of the figure (max = 640)
#' @param format Format of the map picture (png32 is best)
#'
#' @return df Map data frame
#' 
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @export
GetStaticmapGoogleMaps <- function(center, zoom = 10, GRAYSCALE = FALSE, scale = 1, maptype = 'map', destfile = 'TemporaryMap.png', n_pix = 640, format = "png32") {
  
  .InstallMarginal("png")
  .InstallMarginal("RgoogleMaps")
  .InstallMarginal("reshape2")
  .InstallMarginal("plyr")
  
  # Get map with given scale
  if (scale==1) 
    RgoogleMaps::GetMap(center = center[c('lat','lon')], GRAYSCALE=FALSE, size = c(n_pix, n_pix), 
                        zoom = zoom, format = format, maptype = maptype, destfile=destfile)
  else if (scale==2)
    RgoogleMaps::GetMap(center = center[c('lat','lon')], GRAYSCALE=FALSE, size = c(n_pix, n_pix),
                        zoom = zoom, format = format, maptype = paste(maptype, "&scale=2", sep=""), destfile=destfile)
  else
    stop("Invalid scale-value!")
  
  # Read downloaded map png and delete the temporary files
  map <- png::readPNG(destfile)
  if (file.exists("TemporaryMap.png"))
    file.remove("TemporaryMap.png")
  if (file.exists("TemporaryMap.png.rda"))
    file.remove("TemporaryMap.png.rda")
  
  # Double the number of pixels if scale==2
  n_pix <- n_pix*scale 
  
  # FIXME: now the TRUE option may work, too. Test later.  
  GRAYSCALE <- FALSE
  # Deal with color
  if(GRAYSCALE == FALSE) {
    cat("Colours: yes\n")
    map <- apply(map, 1:2, function(v) rgb(v[1], v[2], v[3]))     
  } else {
    cat("Colours: no\n")
    nrow <- nrow(map)
    ncol <- ncol(map)
    
    coefs = c(0, 1, 0)
    img <- map
    map <- imagematrix(coefs[1] * img[,,1] + coefs[2] * img[,,2] + coefs[3] * img[,,3], type="grey")
    
    map <- matrix(map, nrow = nrow, ncol = ncol)
    
  }
  
  # Reshape map for plotting
  m_map <- reshape2::melt(map)
  names(m_map) <- c('x','y','fill')
  m_map <- within(m_map,{
    x <- x - n_pix/2 - 1
    y <- y - n_pix/2 - 1
  })     
  
  mapInfo <- list(lat = center['lat'], lon = center['lon'], zoom = zoom, map, url="NA")
  XY_cent <- RgoogleMaps::LatLon2XY.centered(mapInfo, center['lat'], center['lon'])
  
  # Geocode pixel references
  s <- (-n_pix/2) : (n_pix/2 - 1)  
  lat_wrapper <- function(x) RgoogleMaps::XY2LatLon(mapInfo, -n_pix/2, x)[1]
  lats <- apply(data.frame(s), 1, lat_wrapper)  
  lon_wrapper <- function(y) RgoogleMaps::XY2LatLon(mapInfo, y, -n_pix/2)[2]
  lons <- apply(data.frame(s), 1, lon_wrapper)
  
  # Merge colors to latlons and return
  df_xy   <- expand.grid(x = s, y = s)
  df_ll   <- expand.grid(lat = rev(lats), lon = lons)
  df_xyll <- data.frame(df_xy, df_ll)
  df <- suppressMessages(plyr::join(df_xyll, m_map, type = 'right'))
  df <- df[,c('lon','lat','fill')]
  return(df)
}


## Modified from the deprecated ReadImages package:
## imagematrix class definition
##
## Copyright (c) 2003 Nikon Systems Inc.
## License: BSD

imagematrix <- function(mat, type=NULL, ncol=dim(mat)[1], nrow=dim(mat)[2],
                        noclipping=FALSE) {
  if (is.null(dim(mat)) && is.null(type)) stop("Type should be specified.")
  if (length(dim(mat)) == 2 && is.null(type)) type <- "grey"
  if (length(dim(mat)) == 3 && is.null(type)) type <- "rgb"
  if (type != "rgb" && type != "grey") stop("Type is incorrect.")
  if (is.null(ncol) || is.null(nrow)) stop("Dimension is uncertain.")
  imgdim <- c(ncol, nrow, if (type == "rgb") 3 else NULL)
  if (length(imgdim) == 3 && type == "grey") {
    # force to convert grey image
    mat <- rgb2grey(mat)
  }
  if (noclipping == FALSE && ((min(mat) < 0) || (1 < max(mat)))) {
    warning("Pixel values were automatically clipped because of range over.") 
    mat <- clipping(mat)
  }
  mat <- array(mat, dim=imgdim)
  attr(mat, "type") <- type
  class(mat) <- c("imagematrix", class(mat))
  mat
}
clipping <- function(img, low=0, high=1) {
  img[img < low] <- low
  img[img > high] <- high
  img
}
rgb2grey <- function(img, coefs=c(0.30, 0.59, 0.11)) {
  if (is.null(dim(img))) stop("image matrix isn't correct.")
  if (length(dim(img))<3) stop("image matrix isn't rgb image.")
  imagematrix(coefs[1] * img[,,1] + coefs[2] * img[,,2] + coefs[3] * img[,,3],
              type="grey")
}