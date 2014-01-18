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


