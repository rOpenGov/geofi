\name{get_helsinki_aluejakokartat}
\alias{get_helsinki_aluejakokartat}
\title{Retrieve District Boundaries in Helsinki}
\usage{
get_helsinki_aluejakokartat(map.specifier = NULL, data.dir = tempdir(),
  verbose = TRUE)
}
\arguments{
  \item{map.specifier}{A string. Specify the name of the
  Helsinki District Boundary data set to retrieve. Run
  'get_helsinki_aluejakokartat()' to see available
  options.}

  \item{data.dir}{A string. Specify a temporary folder for
  storing downloaded data.}

  \item{verbose}{logical. Should R report extra information
  on progress?}
}
\value{
a shape object (from SpatialPolygons class)
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
sp.suuralue <- get_helsinki_aluejakokartat(map.specifier="suuralue");
          plot_shape(sp=sp.suuralue, varname="Name", type="discrete", plot=FALSE)
}
\author{
Juuso Parkkinen, Joona Lehtomaki and Leo Lahti
\email{louhos@googlegroups.com}
}
\references{
See citation("fingis")
}

