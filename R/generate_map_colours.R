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
