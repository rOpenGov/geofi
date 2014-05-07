\name{get_helsinki_spatial}
\alias{get_helsinki_spatial}
\title{Retrieve spatial data for Helsinki region}
\usage{
get_helsinki_spatial(map.type = NULL, map.specifier = NULL,
  data.dir = tempdir(), verbose = TRUE)
}
\arguments{
  \item{map.type}{A string. Specify the type of HKK map
  data to retrieve: 'seutukartta', 'piirijako',
  'rakennusrekisteri'}

  \item{map.specifier}{A string. Specify the specific data
  to retrieve. Run 'get_helsinki_spatial()' to see
  available options.}

  \item{data.dir}{A string. Specify a temporary folder for
  storing downloaded data.}

  \item{verbose}{logical. Should R report extra information
  on progress?}
}
\value{
Shape object (from SpatialPolygonsDataFrame class)
}
\description{
Retrieves spatial data for Helsinki region from Helsinki
Real Estate Department (Helsingin kaupungin
kiinteistovirasto, HKK) through the HKK website
http://ptp.hel.fi/avoindata/.
}
\details{
For licensing information and other details, see
http://ptp.hel.fi/avoindata/.
}
\examples{
sp.piiri <- get_helsinki_spatial(map.type="piirijako", map.specifier="ALUEJAKO_SUURPIIRI");
          plot_shape(sp=sp.piiri, varname="NIMI", type="discrete", plot=FALSE);
}
\author{
Juuso Parkkinen, Joona Lehtomaki and Leo Lahti
\email{louhos@googlegroups.com}
}
\references{
See citation("gisfin")
}

