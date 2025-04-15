#' Get up-to-date municipality central locations
#'
#' Convert municipality central locations from on-board data frame into a sf point data
#'
#' @return sf object
#'
#' @author Markus Kainu <markus.kainu@@kela.fi>
#'
#' @export
#'
#' @examples
#'  \dontrun{
#'  f <- municipality_central_localities()
#'  plot(f)
#'  }
#'
#' @rdname municipality_central_localities
#' @export

municipality_central_localities <- function(){
  dat <- sf::st_as_sf(
    geofi::municipality_central_localities_df,
    coords = c("X","Y"),
    crs = 4326
  ) |>
    sf::st_transform(3067) |>
    dplyr::left_join(geofi::municipality_key_2025 |>
                       dplyr::select(kunta,municipality_code,municipality_name_fi,municipality_name_sv,municipality_name_en),
                     by = c("kuntatunnus" = "kunta"))
  return(dat)
}
