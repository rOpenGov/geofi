\name{GetGeocodeOpenStreetMap}
\alias{GetGeocodeOpenStreetMap}
\title{Get geo code from OpenStreetMap}
\usage{
  GetGeocodeOpenStreetMap(query)
}
\arguments{
  \item{query}{Either a street address, e.g.
  'Mannerheimintie+100,Helsinki' or place, e.g.
  'Eduskuntatalo'}
}
\value{
  coordinates (lat, lon)
}
\description{
  Get gecode for given plave from OpenStreetMap Nominatim
  See http://wiki.openstreetmap.org/wiki/Nominatim
}
\author{
  Juuso Parkkinen \email{louhos@googlegroups.com}
}

