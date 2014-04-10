\name{GetStaticmapGoogleMaps}
\alias{GetStaticmapGoogleMaps}
\title{Load static Google Map}
\usage{
GetStaticmapGoogleMaps(center, zoom = 10, GRAYSCALE = FALSE, scale = 1,
  maptype = "map", destfile = "TemporaryMap.png", n_pix = 640,
  format = "png32")
}
\arguments{
  \item{center}{Coordinates for the center of the map}

  \item{zoom}{Zoom-level}

  \item{GRAYSCALE}{Grayscale or colours?}

  \item{scale}{Scale of the map, 1: less details, faster to
  load, 2: more details, much slower to load}

  \item{maptype}{Type of the map}

  \item{destfile}{Temporary file to save the obtained map
  picture}

  \item{n_pix}{Size of the figure (max = 640)}

  \item{format}{Format of the map picture (png32 is best)}
}
\value{
df Map data frame
}
\description{
Get static map from Google Maps API and convert it to
ggplot2-compatible form. See Terms and Conditions from
http://code.google.com/apis/maps/documentation/staticmaps/index.html.
https://github.com/hadley/ggplot2/wiki/Crime-in-Downtown-Houston,-Texas-:-Combining-ggplot2-and-Google-Maps
}
\author{
Juuso Parkkinen \email{louhos@googlegroups.com}
}

