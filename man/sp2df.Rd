\name{sp2df}
\alias{sp2df}
\title{Transform data from sp to data frame for ggplot2}
\usage{
sp2df(sp, region)
}
\arguments{
  \item{sp}{A spatial object to be transformed}

  \item{region}{A string specifying the region of interest}
}
\value{
A ggplot2 theme object
}
\description{
Transform data from sp to data frame for ggplot2
}
\examples{
sp.suuralue <- get_Helsinki_aluejakokartat(map.specifier="suuralue");
          df.suuralue <- sp2df(sp.suuralue, "Name");
          theme_set(get_theme_map());
          ggplot(df.suuralue, aes(x=long, y=lat, fill=Name)) + geom_polygon() + theme(legend.position="none")
}
\author{
Juuso Parkkinen \email{louhos@googlegroups.com}
}
\references{
See citation("fingis")
}

