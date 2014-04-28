\name{generate_map_colours}
\alias{generate_map_colours}
\title{Generate color indices for shape object with the aim to color}
\usage{
generate_map_colours(sp)
}
\arguments{
  \item{sp}{A SpatialPolygonsDataFrame object}
}
\value{
Color index vector
}
\description{
Generate color indices for shape object with the aim to
color
}
\examples{
sp.suuralue <- get_Helsinki_aluejakokartat(map.specifier="suuralue");
          col <- generate_map_colours(sp.suuralue)
}
\author{
Modified from the code by Karl Ove Hufthammer from
http://r-sig-geo.2731867.n2.nabble.com/Colouring-maps-so-that-adjacent-polygons-differ-in-colour-td6237661.html;
modifications by Leo Lahti
}
\references{
See citation("fingis")
}
\keyword{utilities}

