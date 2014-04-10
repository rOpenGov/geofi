\name{ReadShape}
\alias{ReadShape}
\title{Retrieve shape objects by their file names.}
\usage{
ReadShape(files, proj4string = NA)
}
\arguments{
  \item{files}{vector of input files}

  \item{proj4string}{projection information}
}
\value{
shape object, or a list of shape objects, depending on the
length of function argument (a single file name vs.
multiple file names)
}
\description{
Takes list of shape file names (or IDs without the .shp
ending). Returns a corresponding list of shape objects from
the working directory, or from the directory path specified
as part of the file name.
}
\examples{
# ReadShape(files)
}
\author{
Leo Lahti \email{louhos@googlegroups.com}
}
\references{
See citation("sorvi")
}
\keyword{utilities}

