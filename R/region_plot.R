#' Fast wrapper for visualizing regions on a map
#' 
#' @param sp \link{SpatialPolygon} shape object
#' @param color Colour variable for filling
#' @param region Grouping variable (the desired regions)
#' @param palette Colour palette
#' @param by Interval for colors
#' @param main Plot title
#' 
#' @return \link{ggplot2} object
#'
#' @export
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @references See citation("gisfin") 
#' @examples sp <- get_municipality_map("MML"); region_plot(sp, color = "Kieli_ni1", region = "kuntakoodi") 
region_plot <- function (sp, color, region, palette = c("darkblue", "blue", "white", "red", "darkred"), by = 20, main = "") {

  # Get data frame
  df <- sp2df(sp)

  # Define the grouping variable
  df$group <- df[[region]]
  df$fill <- df[[color]]
  if (is.factor(df$fill)) {
    df$fill <- as.numeric(df$fill)
  }
  
  # Set map theme
  theme_set(get_theme_map())

  # Plot regions, add labels using the points data
  p <- ggplot(df, aes(x=long, y=lat)) + 
    geom_polygon(aes(fill=fill, group=group)) 

  # Add custom color scale
  p <- p + scale_fill_gradientn(color, breaks = seq(from = min(df$fill),
       	 			     to = max(df$fill), by = by),
	colours = palette, limits = range(df$fill))

  p <- p + ggtitle(main)
  
  p
}