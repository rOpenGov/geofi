\name{GetElectionDistrictsHelsinki}
\alias{GetElectionDistrictsHelsinki}
\title{Retrieve Helsinki Election District data
from Helsinki Real Estate Department (Helsingin
kaupungin kiinteistovirasto, HKK) through the HKK website
http://kartta.hel.fi/avoindata/index.html}
\usage{
GetElectionDistrictsHelsinki(...)
}
\arguments{
  \item{city}{Name the municipality for which to retrieve
  the election districts}
}
\value{
a list of Shape objects (from SpatialPolygonsDataFrame
class)
}
\description{
The data (C) 2011 Helsingin kaupunkimittausosasto.
}
\examples{
# sp <- GetElectionDistrictsHelsinki()
}
\author{
Joona Lehtomaki and Leo Lahti
\email{louhos@googlegroups.com}
}
\references{
See citation("helsinki")
}

