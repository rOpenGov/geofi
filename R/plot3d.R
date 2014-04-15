#' ReadASC: read ASC file
#' Routines for 3D landscape visualization
#' contributed by Janne Aukia 2013
#'
#' Arguments:
#'   @param filename Input file name
#'
#' Returns:
#'   @return data matrix
#'
#' @export
#' @references
#' See citation("sorvi") 
#' @author Janne Aukia. Contact: \email{louhos@@googlegroups.com}
#' @seealso ReadXYZ
#' @examples # 
#' @keywords utilities

ReadASC <- function (filename) {

  dat   <- read.table(filename, sep = " ", skip = 6)
  mdat  <- data.matrix(dat)
  tmdat <- t(mdat)[,nrow(mdat):1]
  return(tmdat)

}


#' ReadXYZ: read XYZ coordinate file
#' Routines for 3D landscape visualization
#' contributed by Janne Aukia 2013
#'
#' Arguments:
#'   @param filename Input file name
#'
#' Returns:
#'   @return data matrix
#'
#' @export
#' @references
#' See citation("sorvi") 
#' @author Janne Aukia. Contact: \email{louhos@@googlegroups.com}
#' @seealso ReadASC
#' @examples # 
#' @keywords utilities

ReadXYZ <- function(filename) {

  .InstallMarginal("Matrix")

  dat <- read.table(filename)
  xp <- (dat$V1-min(dat$V1))/10
  yp <- (dat$V2-min(dat$V2))/10

  mat <- data.matrix(spMatrix(max(xp)+1,max(yp)+1,xp+1,yp+1,dat$V3))  
  return(mat)

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

