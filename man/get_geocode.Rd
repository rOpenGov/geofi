\name{get_geocode}
\alias{get_geocode}
\title{Get geo code from Google Map}
\usage{
get_geocode(query, service)
}
\arguments{
  \item{query}{Either a street address, e.g.
  'Mannerheimintie 100, Helsinki' or place, e.g.
  'Eduskuntatalo'}

  \item{service}{Geocoding service to use, one of
  'openstreetmap' or 'google'}
}
\value{
vector of coordinates (lat, lon)
}
\description{
Get gecode for given street address from Google Maps API
See Terms and Conditions from
http://code.google.com/apis/maps/documentation/geocoding/
}
\examples{
# gc <- get_geocode("Mannerheimintie 100, Helsinki");
}
\author{
Juuso Parkkinen \email{louhos@googlegroups.com}
}
\references{
See citation("fingis")
}

