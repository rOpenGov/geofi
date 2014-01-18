\name{GetGADM}
\alias{GetGADM}
\title{Get map data in GADM format}
\usage{
  GetGADM(map = "FIN_adm", resolution = 4,
    url = "http://gadm.org/data/rda/")
}
\arguments{
  \item{map}{Map identifier. When the full GADM-URL has the
  form "http://gadm.org/data/rda/FIN_adm2.RData", this
  variable contains the part "FIN_adm". For further map
  identifiers, see http://gadm.org}

  \item{resolution}{Integer or String. Specifies map
  resolution.  This variable contains the part "4" from the
  full GADM-URL.  Alternatively, the user can provide a
  string corresponding to the desired FIN_adm GADM map
  resolution with the following options: "Maa" (0 /
  Country); "Laani" (1 / Province); "Maakunta" (2 /
  Region); "Seutukunta" (3 / Sub-Region); "Kunta" (4 /
  Municipality)}

  \item{url}{URL of the GADM R data source

  Returns:}
}
\value{
  GADM object
}
\description{
  Args:
}
\note{
  Suomen osalta kuntatiedot (FIN_adm4) nayttaa olevan
  paivittamatta uusimpaan. Suositellaan MML:n karttoja, ks.
  help(MML).
}
\examples{
# Suomen kunnat: gadm <- get.gadm(map = "FIN_adm", resolution = 4)
}
\author{
  Leo Lahti \email{louhos@googlegroups.com}
}
\references{
  See citation("sorvi")
}
\keyword{utilities}

