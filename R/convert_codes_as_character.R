#' Convert regional codes in on-board municipality key data sets into variable length characters
#'
#' Statistics Finland provides numerical codes of regions as two or three digit characters.
#' By default, those are converted to integers by geofi for convenience, but can be converted back
#' using this function.
#'
#' @param muni_key a municipality key from geofi-package
#'
#' @return tibble with codes converted to variable length characters as provided by Statistics Finland
#'
#' @author Markus Kainu <markus.kainu@@kapsi.fi>, Pyry Kantanen
#'
#' @examples
#'  \dontrun{
#'  convert_municipality_key_codes(muni_key = geofi::municipality_key)
#'  }
#'
#' @rdname convert_municipality_key_codes
#' @export
#'
convert_municipality_key_codes <- function(muni_key = geofi::municipality_key) {

  width_3 <- c("municipality_code", "seutukunta_code")
  width_2 <- c("maakunta_code", "ely_code", "sairaanhoitop_code",
               # "tyossakayntial_code",
               "vaalipiiri_code")
  integer_columns <- c("kunta", "kuntaryhmitys_code", "kielisuhde_code", "avi_code",
                "suuralue_code",
                # "kela_vakuutuspiiri_code", "kela_asumistukialue_code",
                "hyvinvointialue_code")

  muni_key[, width_3] <- sapply(muni_key[, width_3],
                                formatC, flag = "0", width = 3)
  muni_key[, width_2] <- sapply(muni_key[, width_2],
                                formatC, flag = "0", width = 2)
  muni_key[, integer_columns] <- sapply(muni_key[, integer_columns], as.integer)

  return(muni_key)
}

