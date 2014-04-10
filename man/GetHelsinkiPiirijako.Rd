\name{GetHelsinkiPiirijako}
\alias{GetHelsinkiPiirijako}
\title{Retrieve Helsingin piirijako data from HKK}
\usage{
GetHelsinkiPiirijako(which.data)
}
\arguments{
  \item{which.data}{A string. Specify the name of the HKK
  data set to retrieve. Options: Seutukartta}
}
\value{
a list of Shape objects (from SpatialPolygonsDataFrame
class)
}
\description{
Retrieves Helsingin piirijako data from Helsinki Real
Estate Department (Helsingin kaupungin kiinteistovirasto,
HKK) through the HKK website
http://kartta.hel.fi/avoindata/index.html
}
\details{
The data (C) 2011 Helsingin kaupunkimittausosasto.
}
\examples{
# tab <- GetHelsinkiPiirijako("ALUEJAKO_KUNTA")
}
\author{
Joona Lehtomaki and Leo Lahti
\email{louhos@googlegroups.com}
}
\references{
See citation("helsinki")
}

