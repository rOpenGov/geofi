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
