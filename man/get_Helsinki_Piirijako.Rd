\name{get_Helsinki_Piirijako}
\alias{get_Helsinki_Piirijako}
\title{Retrieve Helsingin piirijako data from HKK}
\usage{
get_Helsinki_Piirijako(map.type = NULL, data.dir = tempdir())
}
\arguments{
  \item{map}{A string. Specify the name of the HKK data set
  to retrieve. Options: "ALUEJAKO_KUNTA",
  "ALUEJAKO_OSAALUE_TUNNUS", "ALUEJAKO_OSAALUE",
  "ALUEJAKO_PERUSPIIRI_TUNNUS", "ALUEJAKO_PERUSPIIRI",
  "ALUEJAKO_PIENALUE_TUNNUS", "ALUEJAKO_PIENALUE",
  "ALUEJAKO_SUURPIIRI_TUNNUS", "ALUEJAKO_SUURPIIRI"}
}
\value{
Shape object (from SpatialPolygonsDataFrame class)
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
# tab <- get_Helsinki_Piirijako("m_rantav")
}
\author{
Juuso Parkkinen, Joona Lehtomaki and Leo Lahti
\email{louhos@googlegroups.com}
}
\references{
See citation("fingis")
}

