

#' Geocode Finnish Place Names or Street Addresses
#'
#' Geocodes Finnish place names or street addresses using the National Land Survey
#' of Finland (NLS) geocoding REST API. This function converts textual location
#' descriptions into spatial coordinates.
#'
#' @param search_string Character. The place name or street address to geocode
#'   (e.g., \code{"Suomenlinna"} or \code{"Mannerheimintie 100, Helsinki"}).
#' @param source Character. The data source to search in. Must be one of:
#'   \code{"interpolated-road-addresses"} (default), \code{"geographic-names"},
#'   \code{"addresses"}, \code{"mapsheets-tm35"}, or \code{"cadastral-units"}.
#' @param crs Character. The coordinate reference system (CRS) for the
#'   output data, specified as an EPSG code. Must be one of \code{"EPSG:3067"}
#'   (ETRS-TM35FIN, default) or \code{"EPSG:4326"} (WGS84).
#' @param lang Character. The language for the API response labels. Must be one of
#'   \code{"fi"} (Finnish, default), \code{"sv"} (Swedish), or \code{"en"} (English).
#' @param size Numeric or NULL. The maximum number of results to return. Must be a
#'   positive integer. If \code{NULL} (default), the API’s default size is used.
#' @param options Character or NULL. Additional options to pass to the API, specified
#'   as a single string (e.g., \code{"focus.point.lat=60.1699&focus.point.lon=24.9384"}).
#'   If \code{NULL} (default), no additional options are included. See the NLS
#'   geocoding API documentation for valid options.
#' @param api_key Character. API key for authenticating with the NLS geocoding API.
#'   Defaults to the value stored in \code{options(geofi_mml_api_key)}. You can
#'   obtain an API key from the National Land Survey of Finland website (see
#'   \url{https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje}).
#'
#' @return An \code{sf} object containing the geocoded locations as points in the
#'   specified \code{crs}. If no results are found, a warning is issued, and
#'   an empty \code{sf} object is returned.
#'
#' @details
#' This function uses the NLS geocoding REST API to convert place names or street
#' addresses into spatial coordinates. It supports multiple data sources, including
#' interpolated road addresses, geographic names, and cadastral units. The function
#' includes robust error handling:
#' \itemize{
#'   \item Retries failed requests up to 3 times for transient network issues.
#'   \item Handles HTTP errors and rate limits (HTTP 429).
#'   \item Validates inputs to prevent common errors.
#' }
#'
#' @examples
#' \dontrun{
#' # Set your API key
#' options(geofi_mml_api_key = "your_api_key_here")
#'
#' # Geocode a place name
#' locations <- geocode(search_string = "Suomenlinna", source = "geographic-names")
#' print(locations)
#'
#' # Geocode a street address with a custom size and output CRS
#' addresses <- geocode(
#'   search_string = "Mannerheimintie 100, Helsinki",
#'   source = "addresses",
#'   crs = "EPSG:4326",
#'   size = 5
#' )
#' print(addresses)
#' }
#'
#' @seealso
#' \code{\link{geocode_reverse}} for reverse geocoding.
#' \url{https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje} for
#' instructions on obtaining an API key.
#' \url{https://www.maanmittauslaitos.fi/kartat-ja-paikkatieto/aineistot-ja-rajapinnat/paikkatietojen-rajapintapalvelut/geokoodauspalvelu}
#' for more information on the NLS geocoding API.
#'
#' @author Markus Kainu \email{markus.kainu@@kapsi.fi}
#'
#' @importFrom httr2 request req_perform req_retry resp_body_json
#' @importFrom sf st_read st_crs
#' @export
geocode <- function(search_string,
                    source = "interpolated-road-addresses",
                    crs = 3067,
                    lang = "fi",
                    size = NULL,
                    options = NULL,
                    api_key = getOption("geofi_mml_api_key")) {
  # Input validation
  if (!is.character(search_string) || search_string == "") {
    stop("search_string must be a non-empty character string", call. = FALSE)
  }
  if (!is.character(source) || !source %in% c(
    "interpolated-road-addresses",
    "geographic-names",
    "addresses",
    "mapsheets-tm35",
    "cadastral-units"
  )) {
    stop(
      "source must be one of 'interpolated-road-addresses', 'geographic-names', 'addresses', 'mapsheets-tm35', or 'cadastral-units'",
      call. = FALSE
    )
  }
  if (!is.numeric(crs) || !crs %in% c(3067, 4326)) {
    stop("crs must be one of '3067' (ETRS-TM35FIN) or '4326' (WGS84)", call. = FALSE)
  }
  if (!is.character(lang) || !lang %in% c("fi", "sv", "en")) {
    stop("lang must be one of 'fi' (Finnish), 'sv' (Swedish), or 'en' (English)", call. = FALSE)
  }
  if (!is.null(size) && (!is.numeric(size) || size <= 0 || size %% 1 != 0)) {
    stop("size must be a positive integer or NULL", call. = FALSE)
  }
  if (!is.null(options) && (!is.character(options) || options == "")) {
    stop("options must be a non-empty character string or NULL (e.g., 'focus.point.lat=60.1699&focus.point.lon=24.9384')", call. = FALSE)
  }
  if (!is.character(api_key) || is.null(api_key) || api_key == "") {
    stop("api_key must be a non-empty character string", call. = FALSE)
  }

  # Construct the base URL
  base_url <- "https://avoin-paikkatieto.maanmittauslaitos.fi/geocoding/v2/pelias/search"

  # Construct query parameters
  queries <- paste0(
    "?text=", utils::URLencode(search_string),
    "&sources=", source,
    "&crs=", crs,
    "&lang=", lang,
    "&api-key=", api_key
  )
  if (!is.null(size)) {
    queries <- paste0(queries, "&size=", size)
  }
  if (!is.null(options)) {
    queries <- paste0(queries, "&", options)
  }

  # Construct the full URL
  api_url <- paste0(base_url, queries)

  # Set the user agent
  query_ua <- httr::user_agent("https://github.com/rOpenGov/geofi")

  # Fetch the data
  query_geocode <- function(url, query_ua, expected_crs) {
    # Perform request with retry logic
    req <- httr2::request(url) |>
      httr2::req_user_agent(query_ua$options$useragent) |>
      httr2::req_retry(max_tries = 3, max_seconds = 10)
    resp <- tryCatch(
      httr2::req_perform(req),
      error = function(e) {
        stop("Failed to perform API request: ", e$message, call. = FALSE)
      }
    )

    # Handle HTTP errors, including rate limits (429)
    if (resp$status_code >= 400) {
      if (resp$status_code == 429) {
        retry_after <- as.numeric(resp$headers$`Retry-After`) %||% 5  # Default to 5 seconds
        Sys.sleep(retry_after)
        resp <- httr2::req_perform(req, query_ua)
      } else {
        stop(
          sprintf(
            "Geocoding API request to %s failed\n[%s]",
            url,
            httr::http_status(resp$status_code)$message
          ),
          call. = FALSE
        )
      }
    }

    # Parse response into spatial data
    resp_sf <- tryCatch(
      suppressWarnings(
        sf::st_read(httr2::resp_body_string(resp), quiet = TRUE, crs = crs)
      ),
      error = function(e) {
        stop("Failed to parse API response as spatial data: ", e$message, call. = FALSE)
      }
    )

    # Check if the response has features
    if (nrow(resp_sf) == 0) {
      return(NULL)
    }

    # Verify the CRS matches the requested CRS
    resp_crs <- sf::st_crs(resp_sf)$input
    expected_crs_val <- if (expected_crs == 3067) "EPSG:3067" else "EPSG:4326"
    if (!is.na(resp_crs) && resp_crs != expected_crs_val) {
      warning(
        sprintf(
          "Response CRS (%s) does not match requested CRS (%s). The data will be returned as-is.",
          resp_crs,
          expected_crs_val
        ),
        call. = FALSE
      )
    }

    # Add the query URL as an attribute
    resp_sf$query <- url
    return(resp_sf)
  }

  # Fetch the data
  dat <- tryCatch(
    query_geocode(url = api_url, query_ua = query_ua, expected_crs = crs),
    error = function(e) {
      stop(
        sprintf(
          "Failed to geocode '%s': %s",
          search_string,
          e$message
        ),
        call. = FALSE
      )
    }
  )

  # Check if any features were returned
  if (is.null(dat)) {
    warning(
      sprintf(
        "No geocoding results found for search string '%s' with source '%s'",
        search_string,
        source
      ),
      call. = FALSE
    )
    # Return an empty sf object
    empty_sf <- sf::st_sf(geometry = sf::st_sfc(crs = as.integer(sub("EPSG:", "", crs))))
    return(empty_sf)
  }

  return(dat)
}


#' Reverse Geocode Geographic Locations into Finnish Place Names or Addresses
#'
#' Reverse geocodes geographic coordinates into Finnish place names or street
#' addresses using the National Land Survey of Finland (NLS) geocoding REST API.
#' This function converts spatial points into textual location descriptions.
#'
#' @param point An \code{sf} object with POINT geometries, representing the
#'   locations to reverse geocode. The input must be in EPSG:4326 (WGS84) CRS.
#' @param boundary_circle_radius Numeric or NULL. The radius (in kilometers) of a
#'   circular boundary around each point to limit the search area. Must be a
#'   positive number. If \code{NULL} (default), no boundary radius is applied.
#' @param size Numeric or NULL. The maximum number of results to return per point.
#'   Must be a positive integer. If \code{NULL} (default), the API’s default size
#'   is used.
#' @param layers Character or NULL. The layers to include in the search, specified
#'   as a comma-separated string (e.g., \code{"address,poi"}). If \code{NULL}
#'   (default), the API’s default layers are used. See the NLS geocoding API
#'   documentation for valid layers.
#' @param sources Character or NULL. The data sources to search in, specified as a
#'   comma-separated string (e.g., \code{"geographic-names,addresses"}). Must be
#'   one or more of \code{"interpolated-road-addresses"}, \code{"geographic-names"},
#'   \code{"addresses"}, \code{"mapsheets-tm35"}, or \code{"cadastral-units"}.
#'   If \code{NULL} (default), the API’s default sources are used.
#' @param boundary_country Character or NULL. The country to limit the search to,
#'   specified as an ISO 3166-1 alpha-3 code (e.g., \code{"FIN"} for Finland).
#'   If \code{NULL} (default), no country boundary is applied.
#' @param return Character. The format of the returned data. Must be one of
#'   \code{"sf"} (default, returns an \code{sf} object) or \code{"json"} (returns
#'   a list of raw JSON responses).
#' @param api_key Character. API key for authenticating with the NLS geocoding API.
#'   Defaults to the value stored in \code{options(geofi_mml_api_key)}. You can
#'   obtain an API key from the National Land Survey of Finland website (see
#'   \url{https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje}).
#'
#' @return If \code{return="sf"}, an \code{sf} object containing the reverse
#'   geocoded locations as points in EPSG:4326 (WGS84) CRS. If \code{return="json"},
#'   a list of raw JSON responses from the API. If no results are found for a point,
#'   a warning is issued, and that point may be omitted from the results.
#'
#' @details
#' This function uses the NLS geocoding REST API to convert geographic coordinates
#' into place names or street addresses. It supports multiple points in a single
#' call and allows filtering by search radius, layers, sources, and country.
#' The function includes robust error handling:
#' \itemize{
#'   \item Retries failed requests up to 3 times for transient network issues.
#'   \item Handles HTTP errors and rate limits (HTTP 429).
#'   \item Validates inputs to prevent common errors.
#' }
#'
#' @examples
#' \dontrun{
#' # Set your API key
#' options(geofi_mml_api_key = "your_api_key_here")
#'
#' # Create a point for Suomenlinna (in EPSG:4326)
#' suomenlinna <- data.frame(lon = 24.933333, lat = 60.1725) |>
#'   sf::st_as_sf(coords = c("lon", "lat"), crs = 4326)
#'
#' # Reverse geocode to get place names
#' places <- geocode_reverse(
#'   point = suomenlinna,
#'   sources = "geographic-names"
#' )
#' print(places)
#'
#' # Reverse geocode with a search radius and return raw JSON
#' places_json <- geocode_reverse(
#'   point = suomenlinna,
#'   boundary_circle_radius = 1,
#'   return = "json"
#' )
#' print(places_json)
#' }
#'
#' @seealso
#' \code{\link{geocode}} for forward geocoding.
#' \url{https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje} for
#' instructions on obtaining an API key.
#' \url{https://www.maanmittauslaitos.fi/kartat-ja-paikkatieto/aineistot-ja-rajapinnat/paikkatietojen-rajapintapalvelut/geokoodauspalvelu}
#' for more information on the NLS geocoding API.
#'
#' @author Markus Kainu \email{markus.kainu@@kapsi.fi}
#'
#' @importFrom httr2 request req_perform req_retry resp_body_json
#' @importFrom sf st_as_sf st_coordinates st_is_valid st_crs st_read
#' @importFrom jsonlite toJSON

#' @export
geocode_reverse <- function(point,
                            boundary_circle_radius = NULL,
                            size = NULL,
                            layers = NULL,
                            sources = NULL,
                            boundary_country = NULL,
                            return = "sf",
                            api_key = getOption("geofi_mml_api_key")) {
  # Input validation
  if (!inherits(point, "sf")) {
    stop("point must be an sf object with POINT geometries", call. = FALSE)
  }
  if (!all(sf::st_is_valid(point))) {
    stop("point contains invalid geometries", call. = FALSE)
  }
  if (!all(sf::st_geometry_type(point) == "POINT")) {
    stop("point must contain only POINT geometries", call. = FALSE)
  }
  if (sf::st_crs(point)$epsg != 4326) {
    stop("point must be in EPSG:4326 (WGS84) CRS", call. = FALSE)
  }
  if (!is.null(boundary_circle_radius) && (!is.numeric(boundary_circle_radius) || boundary_circle_radius <= 0)) {
    stop("boundary_circle_radius must be a positive number or NULL", call. = FALSE)
  }
  if (!is.null(size) && (!is.numeric(size) || size <= 0 || size %% 1 != 0)) {
    stop("size must be a positive integer or NULL", call. = FALSE)
  }
  if (!is.null(layers) && (!is.character(layers) || layers == "")) {
    stop("layers must be a non-empty character string or NULL (e.g., 'address,poi')", call. = FALSE)
  }
  if (!is.null(sources)) {
    valid_sources <- c("interpolated-road-addresses", "geographic-names", "addresses", "mapsheets-tm35", "cadastral-units")
    sources_list <- unlist(strsplit(sources, ","))
    if (!is.character(sources) || sources == "" || !all(sources_list %in% valid_sources)) {
      stop(
        "sources must be a comma-separated string of valid sources (e.g., 'geographic-names,addresses') or NULL",
        call. = FALSE
      )
    }
  }
  if (!is.null(boundary_country) && (!is.character(boundary_country) || boundary_country == "" || !grepl("^[A-Z]{3}$", boundary_country))) {
    stop("boundary_country must be a 3-letter ISO 3166-1 alpha-3 code (e.g., 'FIN') or NULL", call. = FALSE)
  }
  if (!is.character(return) || !return %in% c("sf", "json")) {
    stop("return must be one of 'sf' or 'json'", call. = FALSE)
  }
  if (!is.character(api_key) || is.null(api_key) || api_key == "") {
    stop("api_key must be a non-empty character string", call. = FALSE)
  }

  # Construct query URLs for each point
  create_queries <- function(x, api_key) {
    coords <- sf::st_coordinates(x)
    query <- paste0(
      "?point.lat=", coords[2],
      "&point.lon=", coords[1],
      "&api-key=", api_key
    )
    if (!is.null(boundary_circle_radius)) {
      query <- paste0(query, "&boundary.circle.radius=", boundary_circle_radius)
    }
    if (!is.null(size)) {
      query <- paste0(query, "&size=", size)
    }
    if (!is.null(layers)) {
      query <- paste0(query, "&layers=", layers)
    }
    if (!is.null(sources)) {
      query <- paste0(query, "&sources=", sources)
    }
    if (!is.null(boundary_country)) {
      query <- paste0(query, "&boundary.country=", boundary_country)
    }
    return(query)
  }

  queries <- vapply(
    1:nrow(point),
    function(i) create_queries(point[i, ], api_key),
    character(1)
  )

  # Construct the full URLs
  base_url <- "https://avoin-paikkatieto.maanmittauslaitos.fi/geocoding/v2/pelias/reverse"
  urls <- paste0(base_url, queries)

  # Set the user agent
  query_ua <- httr::user_agent("https://github.com/rOpenGov/geofi")

  # Fetch the data
  query_geocode <- function(url, query_ua, return_type) {
    # Perform request with retry logic
    req <- httr2::request(url) |>
      httr2::req_user_agent(query_ua$options$useragent) |>
      httr2::req_retry(max_tries = 3, max_seconds = 10)
    resp <- tryCatch(
      httr2::req_perform(req),
      error = function(e) {
        stop("Failed to perform API request: ", e$message, call. = FALSE)
      }
    )

    # Handle HTTP errors, including rate limits (429)
    if (resp$status_code >= 400) {
      if (resp$status_code == 429) {
        retry_after <- as.numeric(resp$headers$`Retry-After`) %||% 5  # Default to 5 seconds
        Sys.sleep(retry_after)
        resp <- httr2::req_perform(req)
      } else {
        stop(
          sprintf(
            "Reverse geocoding API request to %s failed\n[%s]",
            url,
            httr::http_status(resp$status_code)$message
          ),
          call. = FALSE
        )
      }
    }

    # Parse the response based on return type
    if (return_type == "sf") {
      ddat <- tryCatch(
        suppressWarnings(
          # sf::st_read(resp, quiet = TRUE)
          sf::st_read(httr2::resp_body_string(resp), quiet = TRUE, crs = sf::st_crs(4326))
        ),
        error = function(e) {
          stop("Failed to parse API response as spatial data: ", e$message, call. = FALSE)
        }
      )
      if (nrow(ddat) == 0) {
        return(NULL)
      }
      return(ddat)
    } else {
      ddat <- tryCatch(
        httr2::resp_body_json(resp),
        error = function(e) {
          stop("Failed to parse API response as JSON: ", e$message, call. = FALSE)
        }
      )
      return(ddat)
    }
  }

  # Fetch data for all points
  dat_list <- lapply(
    urls,
    function(url) {
      tryCatch(
        query_geocode(url, query_ua, return),
        error = function(e) {
          warning(
            sprintf(
              "Failed to reverse geocode for URL %s: %s",
              url,
              e$message
            ),
            call. = FALSE
          )
          return(NULL)
        }
      )
    }
  )

  # Combine results based on return type
  if (return == "sf") {
    dat_list <- dat_list[!sapply(dat_list, is.null)]
    if (length(dat_list) == 0) {
      warning("No reverse geocoding results found for any points", call. = FALSE)
      return(sf::st_sf(geometry = sf::st_sfc(crs = 4326)))
    }
    dat <- do.call("rbind", dat_list)
  } else {
    names(dat_list) <- urls
    if (all(sapply(dat_list, is.null))) {
      warning("No reverse geocoding results found for any points", call. = FALSE)
      return(list())
    }
    dat <- jsonlite::toJSON(dat_list, pretty = TRUE)
  }
  return(dat)
}



