\name{GetDistrictBoundariesHelsinki}
\alias{GetDistrictBoundariesHelsinki}
\title{Retrieve District Boundaries in Helsinki}
\usage{
GetDistrictBoundariesHelsinki(map, data.dir = ".")
}
\arguments{
  \item{map}{A string. Specify the name of the Helsinki
  District Boundary data set to retrieve. Available
  options: c("kunta", "pienalue", "suuralue",
  "tilastoalue")}
}
\value{
a list of Shape objects (from SpatialPolygonsDataFrame
class)
}
\description{
Retrieves District Boundaries data (Aluejakorajat) from
Helsinki Real Estate Department (Helsingin kaupungin
kiinteistovirasto, HKK) through the HKK website
http://kartta.hel.fi/avoindata/index.html
}
\details{
The data (C) 2011 Helsingin kaupunkimittausosasto.

Also aluejako_alueet_ja_pisteet file is available in the
original HKK zip file. This contains all maps in a single
list of shape objects and is thus redundant. We have
ignored this for simplicity. There are also map versions
"pienalue_piste"; "suuralue_piste"; "tilastoalue_piste".
These point maps are not currently implemented.
}
\note{
This function replaces sorvi::GetHRIaluejakokartat; The
data is now retrieved directly from HKK.
}
\examples{
# res <- GetDistrictBoundariesHelsinki("tilastoalue");
          # sp <- res$shape; df <- res$data
          # pdf("~/tmp/tmp.pdf"); PlotShape(sp, "Name"); dev.off()
}
\author{
Joona Lehtomaki and Leo Lahti
\email{louhos@googlegroups.com}
}
\references{
See citation("helsinki")
}

