\name{ConvertGADMResolution}
\alias{ConvertGADMResolution}
\title{Convert GADM map resolution identifiers between strings and integers}
\usage{
  ConvertGADMResolution(resolution,
    output.type = "integer")
}
\arguments{
  \item{resolution}{string or integer specifying the
  resolution for region borders}

  \item{output.type}{"integer" or "string" specifying
  whether the resolution is converted into integer or
  string (if not already in that format)

  Returns:}
}
\value{
  integer or string
}
\description{
  "Maa" (0 / Country); "Laani" (1 / Province); "Maakunta"
  (2 / Region); "Seutukunta" (3 / Sub-Region); "Kunta" (4 /
  Municipality)
}
\details{
  Arguments:
}
\author{
  Leo Lahti \email{louhos@googlegroups.com}
}
\references{
  See citation("sorvi")
}
\keyword{utilities}

