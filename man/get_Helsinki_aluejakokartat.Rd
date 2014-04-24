\name{get_Helsinki_aluejakokartat}
\alias{get_Helsinki_aluejakokartat}
\title{Retrieve District Boundaries in Helsinki}
\usage{
get_Helsinki_aluejakokartat(map.specifier = NULL, data.dir = tempdir())
}
\arguments{
  \item{map.specifier}{A string. Specify the name of the
  Helsinki District Boundary data set to retrieve. Run
  'get_Helsinki_aluejakokartat()' to see available
  options.}

  \item{data.dir}{A string. Specify a temporary folder for
  storing downloaded data.}
}
\value{
a shape object (from SpatialPolygonsDataFrame class)
}
\description{
Retrieves District Boundaries data (Aluejakorajat,
Aanestysalueet) from Helsinki Real Estate Department
(Helsingin kaupungin kiinteistovirasto, HKK) through the
HKK website http://ptp.hel.fi/avoindata/index.html
}
\details{
The data (C) 2011 Helsingin kaupunkimittausosasto.
}
\note{
This function replaces sorvi::GetHRIaluejakokartat; The
data is now retrieved directly from HKK.
}
\examples{
# sp <- get_Helsinki_district_boundaries(map.specifier="suuralue");
}
\author{
Juuso Parkkinen, Joona Lehtomaki and Leo Lahti
\email{louhos@googlegroups.com}
}
\references{
See citation("fingis")
}

