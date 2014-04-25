\name{get_Helsinki_spatial}
\alias{get_Helsinki_spatial}
\title{Retrieve spatial data for Helsinki region}
\usage{
get_Helsinki_spatial(map.type = NULL, map.specifier = NULL,
  data.dir = tempdir())
}
\arguments{
  \item{map.type}{A string. Specify the type of HKK map
  data to retrieve: 'seutukartta', 'piirijako',
  'rakennusrekisteri'}

  \item{map.specifier}{A string. Specify the specific data
  to retrieve. Run 'get_Helsinki_mapdata()' to see
  available options.}

  \item{data.dir}{A string. Specify a temporary folder for
  storing downloaded data.}
}
\value{
Shape object (from SpatialPolygonsDataFrame class)
}
\description{
Retrieves spatial data for Helsinki region from Helsinki
Real Estate Department (Helsingin kaupungin
kiinteistovirasto, HKK) through the HKK website
http://kartta.hel.fi/avoindata/index.html.
}
\details{
For licensing information and other details, see
http://kartta.hel.fi/avoindata/aineistot/
}
\examples{
tab <- get_Helsinki_spatial(map.type="seutukartta", map.specifier="l_kiitor")
}
\author{
Juuso Parkkinen, Joona Lehtomaki and Leo Lahti
\email{louhos@googlegroups.com}
}
\references{
See citation("fingis")
}

