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
#' @author Markus Kainu <markus.kainu@@kapsi.fi>
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

  # check which columns are integers
  nums <- unlist(lapply(muni_key, is.integer))
  nsm <- names(nums[nums])
  for (i in seq_along(nsm)){
    muni_key[[nsm[i]]] <- integers_as_character(muni_key, nsm[i])
  }
  return(muni_key)
}

#' Convert an integer variable into character variable of varying width based on variable name.
#'
#' @param dat named vector
#' @param varname named vector
#'
#' @note For internal use, not exported.
#'
#' @importFrom stringr str_pad
#'
#' @author Markus Kainu <markus.kainu@@kapsi.fi>
#'

integers_as_character <- function(dat, varname){
  x <- dat[[varname]]
  if (varname %in% c("municipality_code","seutukunta_code")){
    y <- stringr::str_pad(string = x, width = 3, pad = "0")
    } else if (grepl("kela", varname)|varname == "kunta"){
      y <- x
    } else {
      y <- stringr::str_pad(string = x, width = 2, pad = "0")
    }
  return(y)
  }


