#' @title Get blank ggplot2 theme for plotting maps
#' @description Get blank ggplot2 theme for plotting maps
#' @return theme_map A ggplot2 theme object
#' @importFrom ggplot2 theme_bw
#' @importFrom ggplot2 element_blank
#' @export
#' @author Juuso Parkkinen \email{louhos@@googlegroups.com}
#' @references See citation("gisfin")
#' @examples sp.suuralue <- get_helsinki_aluejakokartat(map.specifier="suuralue"); 
#'           # Need to load rgeos and maptools for ggplot2::fortify in sp2df() 
#'           library(rgeos);
#'           library(maptools);
#'           # Transform to df and plot with ggplot2
#'           df.suuralue <- sp2df(sp.suuralue, "Name");
#'           library(ggplot2);
#'           theme_set(get_theme_map());
#'           ggplot(df.suuralue, aes(x=long, y=lat, fill=Name)) + 
#'           geom_polygon() + theme(legend.position="none")
get_theme_map <- function() {
  
  theme_map <- ggplot2::theme_bw()
  theme_map$panel.background <- ggplot2::element_blank()
  theme_map$panel.grid.major <- ggplot2::element_blank()
  theme_map$panel.grid.minor <- ggplot2::element_blank()
  theme_map$axis.ticks <- ggplot2::element_blank()
  theme_map$axis.text <- ggplot2::element_blank()
  theme_map$axis.title <- ggplot2::element_blank()
  
  return(theme_map)  
}
