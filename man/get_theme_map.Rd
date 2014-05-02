\name{get_theme_map}
\alias{get_theme_map}
\title{Get blank ggplot2 theme for plotting maps}
\usage{
get_theme_map()
}
\value{
theme_map A ggplot2 theme object
}
\description{
Get blank ggplot2 theme for plotting maps
}
\examples{
sp.suuralue <- get_Helsinki_aluejakokartat(map.specifier="suuralue");
          df.suuralue <- sp2df(sp.suuralue, "Name");
          library(ggplot2);
          theme_set(get_theme_map());
          ggplot(df.suuralue, aes(x=long, y=lat, fill=Name)) +
          geom_polygon() + theme(legend.position="none")
}
\author{
Juuso Parkkinen \email{louhos@googlegroups.com}
}
\references{
See citation("fingis")
}

