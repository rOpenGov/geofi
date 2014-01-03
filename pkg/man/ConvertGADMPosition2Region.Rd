\name{ConvertGADMPosition2Region}
\alias{ConvertGADMPosition2Region}
\title{Find municipality (kunta), subregion (seutukunta),
region (maakunta), or province (laani)
for given GADM map coordinates,}
\usage{
  ConvertGADMPosition2Region(coordinates, map = "FIN_adm",
    resolution = "Kunta")
}
\arguments{
  \item{coordinates}{matrix with columns named 'x' and 'y'.
  The columns specify x and y coordinates on the GADM map.
  These will be mapped to region names, with the resolution
  specified by the resolution parameter. For instance:
  coordinates <- cbind( x = c(24.9375, 24.0722), y =
  c(60.1783, 61.4639))}

  \item{map}{Map identifier. When the full GADM-URL has the
  form "http://gadm.org/data/rda/FIN_adm2.RData", this
  variable contains the part "FIN_adm". For further map
  identifiers, see http://gadm.org}

  \item{resolution}{Integer or String. Specifies map
  resolution.  This variable contains the part "4" from the
  full GADM-URL.  to the desired FIN_adm GADM map
  resolution with the following options: "Maa" (0 /
  Country); "Maakunta" (2 / Region); "Seutukunta" (3 /
  Sub-Region); "Kunta" (4 / Municipality)

  Returns:}
}
\value{
  A data frame with coordinates, region, province, and
  municipality information
}
\description{
  Arguments:
}
\author{
  Leo Lahti \email{louhos@googlegroups.com}
}
\references{
  See citation("sorvi")
}
\keyword{utilities}

