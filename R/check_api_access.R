#' Check Access to Statistics Finland Geoserver APIs
#'
#' Tests whether R can access resources at Statistics Finland's geoserver APIs,
#' specifically the WFS (Web Feature Service) or OGC API. This internal function
#' is used to verify connectivity before making API requests.
#'
#' @param which_api Character. The API to check. Must be one of:
#'   \code{"statfi_wfs"} (checks WFS at \code{http://geo.stat.fi/geoserver/wfs})
#'   or \code{"statfi_ogc"} (checks OGC API at
#'   \code{https://geo.stat.fi/inspire/ogc/api/su/}). Defaults to
#'   \code{"statfi_wfs"}.
#'
#' @return Logical. Returns \code{TRUE} if the API is accessible (HTTP status 200),
#'   \code{FALSE} otherwise. Issues a warning if the request fails due to network
#'   issues or non-200 status codes.
#'
#' @details
#' This function sends a lightweight HTTP request to the specified API endpoint
#' to check for accessibility. It uses \code{httr2} for robust HTTP handling and
#' retries transient network failures up to 3 times. The function is intended for
#' internal use within the package to ensure API connectivity before executing
#' data retrieval operations.
#'
#' @author Markus Kainu \email{markus.kainu@@kapsi.fi}
#'
#' @importFrom httr2 request req_perform req_retry req_user_agent
#'
#' @examples
#' \dontrun{
#'   check_api_access()  # Check WFS API
#'   check_api_access("statfi_ogc")  # Check OGC API
#' }
#' @export
#'

check_api_access <- function(which_api = "statfi_wfs") {
  # Validate input
  valid_apis <- c("statfi_wfs", "statfi_ogc")
  if (!is.character(which_api) || length(which_api) != 1 || !which_api %in% valid_apis) {
    stop(
      "which_api must be one of: ", paste(valid_apis, collapse = ", "),
      call. = FALSE
    )
  }

  # Define API URL based on which_api
  http_url <- switch(which_api,
                     statfi_wfs = "http://geo.stat.fi/geoserver/wfs?service=WFS&version=1.0.0&request=getCapabilities",
                     statfi_ogc = "https://geo.stat.fi/inspire/ogc/api/su/?f=json"
  )

  # Perform request with retry logic
  req <- httr2::request(http_url) |>
    httr2::req_user_agent(string = "https://github.com/rOpenGov/geofi") |>
    httr2::req_retry(max_tries = 3, max_seconds = 10)

  # Try to perform the request
  resp <- tryCatch(
    httr2::req_perform(req),
    error = function(e) {
      warning(
        sprintf(
          "Failed to access %s API at %s: %s",
          which_api, http_url, e$message
        ),
        call. = FALSE
      )
      return(NULL)
    }
  )

  # Check response
  if (is.null(resp)) {
    return(FALSE)
  }

  if (resp$status_code == 200) {
    return(TRUE)
  } else {
    warning(
      sprintf(
        "API request to %s (%s) returned status code %s",
        which_api, http_url, resp$status_code
      ),
      call. = FALSE
    )
    return(FALSE)
  }
}

