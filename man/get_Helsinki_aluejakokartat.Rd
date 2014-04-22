\name{get_Helsinki_aluejakokartat}
\alias{get_Helsinki_aluejakokartat}
\title{Retrieve District Boundaries in Helsinki}
\usage{
get_Helsinki_aluejakokartat(map.type = NULL, data.dir = tempdir())
}
\arguments{
  \item{map.type}{A string. Specify the name of the
  Helsinki District Boundary data set to retrieve.
  Available options: c("kunta", "pienalue",
  "pienalue_piste", "suuralue", "suuralue_piste",
  "tilastoalue", "tilastoalue_piste")}

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

Also aluejako_alueet_ja_pisteet file is available in the
original HKK zip file. This contains all maps in a single
list of shape objects and is thus redundant. We have
ignored this for simplicity.
}
\note{
This function replaces sorvi::GetHRIaluejakokartat; The
data is now retrieved directly from HKK.
}
\examples{
# sp <- get_Helsinki_district_boundaries("suuralue");
          # spplot(sp, "Name")
}
\author{
Juuso Parkkinen, Joona Lehtomaki and Leo Lahti
\email{louhos@googlegroups.com}
}
\references{
See citation("fingis")
}

