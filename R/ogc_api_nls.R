#' Fetch Maastotietokanta Collections
#'
#' Retrieves a list of available collections from the Maastotietokanta (Topographic Database) OGC API,
#' including their titles and descriptions.
#'
#' @param api_key Character. [API key](https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje) for authenticating with the Maastotietokanta
#'   OGC API. Defaults to the value stored in `options(geofi_mml_api_key)`.
#'   You can obtain an API key from the Maanmittauslaitos (National Land Survey
#'   of Finland) website.
#'
#' @return A data frame with two columns:
#'   \itemize{
#'     \item \code{id}: The title of each collection.
#'     \item \code{description}: A brief description of each collection.
#'   }
#'
#' @details
#' This function queries the Maastotietokanta OGC API to retrieve metadata about
#' available collections of spatial data. The API is provided by the National Land
#' Survey of Finland (Maanmittauslaitos). The function requires a valid API key,
#' which can be provided directly or set via `options(geofi_mml_api_key)`.
#'
#' The function includes error handling:
#' \itemize{
#'   \item It retries failed requests up to 3 times for transient network issues
#'         or server errors (HTTP 500–599) with exponential backoff.
#'   \item It handles rate limits (HTTP 429) by respecting the `Retry-After` header.
#'   \item It validates the API response to ensure the expected data is present.
#' }
#'
#' @examples
#' \dontrun{
#' # Set your API key
#' options(geofi_mml_api_key = "your_api_key_here")
#'
#' # Fetch the list of collections
#' collections <- ogc_get_maastotietokanta_collections()
#' print(collections)
#'
#' # Alternatively, provide the API key directly
#' collections <- ogc_get_maastotietokanta_collections(api_key = "your_api_key_here")
#' print(collections)
#' }
#'
#' @seealso \url{https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje} for more information
#' on the Maastotietokanta OGC API and how to obtain an API key.
#'
#' @importFrom httr2 request req_perform resp_body_json
#' @importFrom purrr modify
#' @export
ogc_get_maastotietokanta_collections <- function(api_key = getOption("geofi_mml_api_key")) {
  # Input validation
  if (!is.character(api_key) || is.null(api_key) || api_key == "") {
    stop("api_key must be a non-empty character string", call. = FALSE)
  }
  
  # Construct the API URL
  url <- paste0(
    "https://avoin-paikkatieto.maanmittauslaitos.fi/maastotiedot/features/v1/collections",
    "?api-key=", api_key, "&f=json"
  )
  
  # Helper function to perform request with retries
  perform_request_with_retries <- function(req, max_retries = 3) {
    for (attempt in 1:max_retries) {
      resp <- tryCatch(
        httr2::req_perform(req),
        error = function(e) {
          message(sprintf("Request failed: %s", e$message))
          return(NULL)
        }
      )
      
      # Check if response is valid and status code
      if (!is.null(resp)) {
        if (resp$status_code >= 500 && resp$status_code < 600) {
          if (attempt < max_retries) {
            # Exponential backoff: 2^(attempt-1) seconds
            sleep_time <- 2^(attempt - 1)
            message(sprintf("500 error (attempt %d/%d). Retrying after %d seconds...", attempt, max_retries, sleep_time))
            Sys.sleep(sleep_time)
            next
          } else {
            stop(
              sprintf(
                "OGC API request failed after %d retries for %s\n[%s]",
                max_retries,
                req$url,
                httr::http_status(resp$status_code)$message
              ),
              call. = FALSE
            )
          }
        } else if (resp$status_code == 429) {
          # Handle rate limit
          retry_after <- as.numeric(resp$headers$`Retry-After`) %||% 5  # Default to 5 seconds
          message(sprintf("Rate limit (429) hit. Waiting %d seconds...", retry_after))
          Sys.sleep(retry_after)
          next
        } else if (resp$status_code >= 400) {
          stop(
            sprintf(
              "OGC API request to %s failed\n[%s]",
              req$url,
              httr::http_status(resp$status_code)$message
            ),
            call. = FALSE
          )
        } else {
          return(resp)
        }
      } else if (attempt < max_retries) {
        # Retry on network errors
        sleep_time <- 2^(attempt - 1)
        message(sprintf("Network error (attempt %d/%d). Retrying after %d seconds...", attempt, max_retries, sleep_time))
        Sys.sleep(sleep_time)
      } else {
        stop(sprintf("Request failed after %d retries.", max_retries), call. = FALSE)
      }
    }
  }
  
  # Perform the request
  req <- httr2::request(url)
  resp <- perform_request_with_retries(req)
  
  # Parse the JSON response
  resp_list <- tryCatch(
    httr2::resp_body_json(resp),
    error = function(e) {
      stop("Failed to parse API response as JSON: ", e$message, call. = FALSE)
    }
  )
  
  # Extract titles and descriptions, with safety checks
  if (!"collections" %in% names(resp_list) || length(resp_list$collections) == 0) {
    stop("No collections found in the API response", call. = FALSE)
  }
  
  ids <- tryCatch(
    resp_list$collections |> purrr::modify(c("title")) |> unlist(),
    error = function(e) {
      stop("Failed to extract collection titles: ", e$message, call. = FALSE)
    }
  )
  descriptions <- tryCatch(
    resp_list$collections |> purrr::modify(c("description")) |> unlist(),
    error = function(e) {
      stop("Failed to extract collection descriptions: ", e$message, call. = FALSE)
    }
  )
  
  # Validate extracted data
  if (length(ids) == 0 || length(descriptions) == 0 || length(ids) != length(descriptions)) {
    stop("Mismatch or empty data in extracted titles and descriptions", call. = FALSE)
  }
  
  # Create and return the data frame
  dat <- data.frame(id = ids, description = descriptions)
  return(dat)
}



#' Fetch Data from OGC API (Internal)
#'
#' This internal function retrieves spatial data from an OGC API endpoint with
#' pagination support. It handles both limited and unlimited requests, automatically
#' paginating through results when no limit is specified. It includes basic error
#' handling and rate limit handling.
#'
#' @param api_url Character. The base URL of the OGC API endpoint.
#' @param limitti Numeric or NULL. The maximum number of features to retrieve
#'   per request. If NULL, the function first attempts to fetch all available features
#'   without pagination (limit=-1) for speed, falling back to pagination with
#'   a default limit of 10,000 per request if the no-paging request fails.
#' @param max_pages Numeric. The maximum number of pages to fetch during pagination
#'   when `limitti` is NULL. Defaults to 100. Increase this value for very large
#'   datasets, but be cautious of long runtimes.
#'
#' @return An `sf` object containing the retrieved spatial features.
#'
#' @details
#' This function is intended for internal use within the package. It uses the `httr2`
#' package to make HTTP requests and `sf` to parse GeoJSON responses into spatial data.
#' When `limitti` is NULL, it first attempts to fetch all features in a single request
#' (limit=-1). If this fails (e.g., due to R's character string size limit), it falls
#' back to paginating through features by following the "next" links in the API response.
#' It includes basic rate limit handling for status code 429.
#'
#' @note This function is not exported and should only be called by other functions
#' within the package.
#'
#' @importFrom httr2 request req_perform resp_body_json resp_body_string
#' @importFrom sf st_read
#' @importFrom purrr modify keep compact
#' @keywords internal
fetch_ogc_api_mml <- function(api_url,
                              limitti = NULL,
                              max_pages = 100) {
  # Input validation
  if (!is.character(api_url) || !nzchar(api_url)) {
    stop("api_url must be a non-empty string", call. = FALSE)
  }
  if (!is.null(limitti) && (!is.numeric(limitti) || limitti <= 0)) {
    stop("limitti must be a positive number or NULL", call. = FALSE)
  }
  if (!is.numeric(max_pages) || max_pages <= 0) {
    stop("max_pages must be a positive number", call. = FALSE)
  }

  # Set the user agent
  query_ua <- httr::user_agent("https://github.com/rOpenGov/geofi")

  if (is.null(limitti)) {
    # First attempt: Try fetching all features in one request with limit=-1
    api_url_no_paging <- paste0(api_url, "&limit=-1")
    print(paste("Attempting to fetch all features without paging from:", api_url_no_paging))

    # Perform request
    req <- httr2::request(api_url_no_paging)
    all_features <- tryCatch(
      {
        resp <- httr2::req_perform(req)

        # Handle HTTP errors, including rate limits (429)
        if (resp$status_code >= 400) {
          if (resp$status_code == 429) {
            retry_after <- as.numeric(resp$headers$`Retry-After`) %||% 5  # Default to 5 seconds
            Sys.sleep(retry_after)
            resp <- httr2::req_perform(req)
          } else {
            stop(
              sprintf(
                "OGC API %s request failed\n[%s]",
                api_url_no_paging,
                httr::http_status(resp$status_code)$message
              ),
              call. = FALSE
            )
          }
        }

        # Parse response into spatial data
        suppressMessages(sf::st_read(httr2::resp_body_string(resp), quiet = TRUE))
      },
      error = function(e) {
        # If the no-paging request fails (e.g., due to string size limit), fall back to pagination
        message("Failed to fetch all features without paging: ", e$message)
        message("Falling back to pagination...")

        # Pagination logic: fetch features in chunks with limit=10000
        api_url_paging <- paste0(api_url, "&limit=10000")
        next_exists <- TRUE
        i <- 1
        data_list <- list()

        while (next_exists && i <= max_pages) {
          print(paste("Requesting query nr.", i, "from:", api_url_paging))

          # Perform request
          req <- httr2::request(api_url_paging)
          resp <- httr2::req_perform(req)

          # Handle HTTP errors, including rate limits (429)
          if (resp$status_code >= 400) {
            if (resp$status_code == 429) {
              retry_after <- as.numeric(resp$headers$`Retry-After`) %||% 5  # Default to 5 seconds
              Sys.sleep(retry_after)
              resp <- httr2::req_perform(req)
            } else {
              stop(
                sprintf(
                  "OGC API %s request failed\n[%s]",
                  api_url_paging,
                  httr::http_status(resp$status_code)$message
                ),
                call. = FALSE
              )
            }
          }

          # Parse response into spatial data
          data_list[[i]] <- suppressMessages(sf::st_read(httr2::resp_body_string(resp), quiet = TRUE))

          # Check for next page
          resp_json <- httr2::resp_body_json(resp)
          link_rels <- resp_json$links |> purrr::modify(c("rel")) |> unlist()
          if ("next" %in% link_rels) {
            link_list <- resp_json$links |>
              purrr::keep(function(x) x$rel == "next") |>
              purrr::keep(function(x) grepl("json", x$type))
            api_url_paging <- link_list[[1]]$href
            next_exists <- TRUE
          } else {
            next_exists <- FALSE
          }

          if (i == max_pages) {
            warning("Reached maximum number of pages (", max_pages, "); additional features may exist but were not retrieved", call. = FALSE)
            break
          }
          i <- i + 1
        }

        # Combine results
        data_list <- purrr::compact(data_list)
        if (length(data_list) == 0) {
          stop("No valid data retrieved", call. = FALSE)
        }
        do.call("rbind", data_list)
      }
    )

  } else {
    # Single request with specified limit
    api_url <- paste0(api_url, "&limit=", limitti)
    print(paste("Requesting from:", api_url))

    # Perform request
    req <- httr2::request(api_url)
    resp <- httr2::req_perform(req)

    # Handle HTTP errors, including rate limits (429)
    if (resp$status_code >= 400) {
      if (resp$status_code == 429) {
        retry_after <- as.numeric(resp$headers$`Retry-After`) %||% 5  # Default to 5 seconds
        Sys.sleep(retry_after)
        resp <- httr2::req_perform(req)
      } else {
        stop(
          sprintf(
            "OGC API %s request failed\n[%s]",
            api_url,
            httr::http_status(resp$status_code)$message
          ),
          call. = FALSE
        )
      }
    }

    # Parse response into spatial data
    all_features <- suppressMessages(sf::st_read(httr2::resp_body_string(resp), quiet = TRUE))
  }

  return(all_features)
}


#' Download a Collection from the Maastotietokanta (Topographic Database)
#'
#' Downloads a specific collection of spatial data from the Maastotietokanta
#' (Topographic Database) using the OGC API provided by the National Land Survey
#' of Finland (NLS).
#'
#' @param collection Character. The name of the collection to download (e.g.,
#'   \code{"hautausmaa"} for cemeteries). Use
#'   \code{\link{ogc_get_maastotietokanta_collections}} to see available
#'   collections.
#' @param crs Numeric or Character. The coordinate reference system (CRS)
#'   for the output data, specified as an EPSG code. Supported values are
#'   \code{3067} (ETRS-TM35FIN, default) and \code{4326} (WGS84). The returned
#'   \code{sf} object will be transformed to this CRS.
#' @param limit Numeric or NULL. The maximum number of features to retrieve in
#'   a single API request. If \code{NULL} (default), all available features are
#'   fetched, potentially using pagination for large collections.
#' @param max_pages Numeric. The maximum number of pages to fetch during pagination
#'   when \code{limit=NULL}. Defaults to 100. Increase this value for very large
#'   collections (e.g., \code{"suo"}), but be cautious of long runtimes.
#' @param bbox Character or NULL. A bounding box to filter the data, specified as
#'   a string in the format \code{"minx,miny,maxx,maxy"} (e.g.,
#'   \code{"24.5,60.1,25.5,60.5"}). Coordinates must be in the same CRS as the
#'   API (EPSG:4326). If \code{NULL} (default), no spatial filter is applied.
#' @param api_key Character. API key for authenticating with the Maastotietokanta
#'   OGC API. Defaults to the value stored in
#'   \code{options(geofi_mml_api_key)}. You can obtain an API key from the
#'   National Land Survey of Finland website (see
#'   \url{https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje}).
#'
#' @return An \code{sf} object containing the spatial features from the specified
#'   collection, transformed to the requested \code{crs}.
#'
#' @details
#' This function retrieves spatial data from the Maastotietokanta (Topographic
#' Database) OGC API, provided by the National Land Survey of Finland (NLS). It
#' acts as a wrapper around a lower-level API request function, adding user-friendly
#' features like CRS transformation and spatial filtering.
#'
#' Key features:
#' \itemize{
#'   \item Supports pagination for large collections when \code{limit=NULL}.
#'   \item Limits the number of pages fetched during pagination using \code{max_pages}.
#'   \item Applies spatial filtering using a bounding box (\code{bbox}).
#'   \item Transforms the output to the specified CRS (\code{crs}).
#'   \item Validates inputs to prevent common errors.
#' }
#'
#' To see the list of available collections, use
#' \code{\link{ogc_get_maastotietokanta_collections}}.
#'
#' For very large collections (e.g., \code{"suo"}), the function may fetch data in
#' pages of 10,000 features each. If the number of pages exceeds \code{max_pages},
#' a warning is issued, and only the features from the first \code{max_pages} pages
#' are returned. Increase \code{max_pages} to retrieve more features, but be aware
#' that this may significantly increase runtime.
#'
#' @examples
#' \dontrun{
#' # Set your API key
#' options(geofi_mml_api_key = "your_api_key_here")
#'
#' # Download the "hautausmaa" (cemeteries) collection in EPSG:3067
#' cemeteries <- ogc_get_maastotietokanta(collection = "hautausmaa")
#' print(cemeteries)
#'
#' # Download the "suo" (bogs/marshes) collection with a higher page limit
#' bogs <- ogc_get_maastotietokanta(
#'   collection = "suo",
#'   max_pages = 500
#' )
#' print(bogs)
#'
#' # Download with a bounding box (in EPSG:4326) and transform to EPSG:4326
#' cemeteries_bbox <- ogc_get_maastotietokanta(
#'   collection = "hautausmaa",
#'   bbox = "24.5,60.1,25.5,60.5",
#'   crs = 4326
#' )
#' print(cemeteries_bbox)
#'
#' # Download with a custom limit and additional query parameters
#' cemeteries_limited <- ogc_get_maastotietokanta(
#'   collection = "hautausmaa",
#'   limit = 100,
#'   custom_params = "filter=attribute='value'"
#' )
#' print(cemeteries_limited)
#' }
#'
#' @seealso
#' \code{\link{ogc_get_maastotietokanta_collections}} to list available collections.
#' \url{https://www.maanmittauslaitos.fi/en/maps-and-spatial-data/datasets-and-interfaces/product-descriptions/topographic-database}
#' for more information on the Maastotietokanta.
#' \url{https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje} for
#' instructions on obtaining an API key.
#'
#' @author Markus Kainu \email{markus.kainu@@kapsi.fi}
#'
#' @importFrom httr2 request req_perform req_retry resp_body_json resp_body_string
#' @importFrom sf st_read st_transform
#' @importFrom purrr modify keep compact
#' @export
ogc_get_maastotietokanta <- function(collection = "hautausmaa",
                                     crs = 3067,
                                     limit = NULL,
                                     max_pages = 100,
                                     bbox = NULL,
                                     # custom_params = NULL,
                                     api_key = getOption("geofi_mml_api_key")) {
  # Input validation
  if (!is.character(collection) || collection == "") {
    stop("collection must be a non-empty character string", call. = FALSE)
  }
  if (!is.character(api_key) || is.null(api_key) || api_key == "") {
    stop("api_key must be a non-empty character string", call. = FALSE)
  }
  if (!crs %in% c(3067, 4326)) {
    stop("crs must be one of 3067 (ETRS-TM35FIN) or 4326 (WGS84)", call. = FALSE)
  }
  if (!is.null(limit) && (!is.numeric(limit) || limit <= 0)) {
    stop("limit must be a positive number or NULL", call. = FALSE)
  }
  if (!is.numeric(max_pages) || max_pages <= 0) {
    stop("max_pages must be a positive number", call. = FALSE)
  }
  if (!is.null(bbox)) {
    if (!is.character(bbox) || !grepl("^[0-9.-]+,[0-9.-]+,[0-9.-]+,[0-9.-]+$", bbox)) {
      stop("bbox must be a string in the format 'minx,miny,maxx,maxy' (e.g., '24.5,60.1,25.5,60.5')", call. = FALSE)
    }
    bbox_vals <- as.numeric(unlist(strsplit(bbox, ",")))
    if (length(bbox_vals) != 4 || any(is.na(bbox_vals))) {
      stop("bbox values must be numeric in the format 'minx,miny,maxx,maxy'", call. = FALSE)
    }
    if (bbox_vals[1] >= bbox_vals[3] || bbox_vals[2] >= bbox_vals[4]) {
      stop("bbox must satisfy minx < maxx and miny < maxy", call. = FALSE)
    }
  }
  # if (!is.null(custom_params)) {
  #   if (!is.character(custom_params) || custom_params == "") {
  #     stop("custom_params must be a non-empty character string (e.g., 'attribute=value')", call. = FALSE)
  #   }
  # }

  # Construct the base URL
  base_url <- paste0(
    "https://avoin-paikkatieto.maanmittauslaitos.fi/maastotiedot/features/v1/collections/",
    collection,
    "/items?f=json"
  )

  # Construct query parameters
  queries <- paste0("&api-key=", api_key)
  if (!is.null(bbox)) {
    queries <- paste0(queries, "&bbox=", bbox)
  }
  # if (!is.null(custom_params)) {
  #   queries <- paste0(queries, "&", custom_params)
  # }

  # Combine base URL and query parameters
  api_url <- paste0(base_url, queries)

  # Fetch the features using fetch_ogc_api_mml
  all_features <- tryCatch(
    fetch_ogc_api_mml(api_url = api_url, limitti = limit, max_pages = max_pages),
    error = function(e) {
      stop(
        sprintf(
          "Failed to fetch collection '%s': %s",
          collection,
          e$message
        ),
        call. = FALSE
      )
    }
  )

  # Check if any features were returned
  if (is.null(all_features) || nrow(all_features) == 0) {
    warning(
      sprintf(
        "No features found for collection '%s' with the specified parameters",
        collection
      ),
      call. = FALSE
    )
    return(all_features)
  }

  # Transform the CRS if needed
  if (sf::st_crs(all_features)$epsg != crs) {
    all_features <- tryCatch(
      sf::st_transform(all_features, crs = crs),
      error = function(e) {
        stop(
          sprintf(
            "Failed to transform data to CRS %s: %s",
            crs,
            e$message
          ),
          call. = FALSE
        )
      }
    )
  }
  # remove sijaintipiste
  all_features$sijainti_piste <- NULL

  return(all_features)
}


#' Query Geographic Names (Nimistö) from the National Land Survey of Finland
#'
#' Queries the Geographic Names (Nimistö) OGC API to retrieve spatial data on
#' place names provided by the National Land Survey of Finland (NLS).
#'
#' @param search_string Character or NULL. A search string to filter place names
#'   (e.g., \code{"kainu"}). The search is case-insensitive. If \code{NULL}
#'   (default), no search filter is applied, and all place names are retrieved
#'   (subject to the \code{limit} parameter).
#' @param collection Character or NULL. The name of collection for places, place names and map names of the 
#' Geographic Names Register provided by the National Land Survey of Finland where the search if performed from. 
#' Supported values are \code{placenames}, \code{mapnames}, and \code{placenames_simple}
#' @param crs Numeric or Character. The coordinate reference system (CRS)
#'   for the output data, specified as an EPSG code. Supported values are
#'   \code{3067} (ETRS-TM35FIN, default) and \code{4326} (WGS84). The returned
#'   \code{sf} object will be transformed to this CRS.
#' @param limit Numeric. The maximum number of features to retrieve in a single
#'   API request. Defaults to 10. Set to \code{NULL} to fetch all available
#'   features (potentially using pagination for large datasets).
#' @param bbox Character or NULL. A bounding box to filter the data, specified as
#'   a string in the format \code{"minx,miny,maxx,maxy"} (e.g.,
#'   \code{"24.5,60.1,25.5,60.5"}). Coordinates must be in the same CRS as the
#'   API (EPSG:4326). If \code{NULL} (default), no spatial filter is applied.
#' @param custom_params Character or NULL. Additional query parameters to append
#'   to the API URL, specified as a single string (e.g.,
#'   \code{"attribute='value'"}). If \code{NULL} (default), no additional
#'   parameters are included.
#' @param api_key Character. API key for authenticating with the Geographic Names
#'   OGC API. Defaults to the value stored in
#'   \code{options(geofi_mml_api_key)}. You can obtain an API key from the
#'   National Land Survey of Finland website (see
#'   \url{https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje}).
#'
#' @return An \code{sf} object containing the spatial features (place names) from
#'   the Geographic Names dataset, transformed to the requested \code{crs}.
#'   If no features are found, a warning is issued, and an empty \code{sf} object
#'   may be returned.
#'
#' @details
#' This function retrieves spatial data on place names from the Geographic Names
#' (Nimistö) OGC API, provided by the National Land Survey of Finland (NLS). It
#' supports filtering by a search string (case-insensitive), spatial filtering
#' using a bounding box, and limiting the number of returned features.
#'
#' Key features:
#' \itemize{
#'   \item Supports pagination for large datasets when \code{limit=NULL}.
#'   \item Applies spatial filtering using a bounding box (\code{bbox}).
#'   \item Transforms the output to the specified CRS (\code{crs}).
#'   \item Validates inputs to prevent common errors.
#' }
#'
#' @examples
#' \dontrun{
#' # Set your API key
#' options(geofi_mml_api_key = "your_api_key_here")
#'
#' # Search for place names containing "kainu" in EPSG:3067
#' places <- ogc_get_nimisto(search_string = "kainu")
#' print(places)
#'
#' # Search with a bounding box (in EPSG:4326) and transform to EPSG:4326
#' places_bbox <- ogc_get_nimisto(
#'   search_string = "kainu",
#'   bbox = "24.5,60.1,25.5,60.5",
#'   crs = 4326
#' )
#' print(places_bbox)
#'
#' # Fetch all place names (no search filter) with a custom limit
#' all_places <- ogc_get_nimisto(
#'   search_string = NULL,
#'   limit = 100
#' )
#' print(all_places)
#' }
#'
#' @seealso
#' \url{https://www.maanmittauslaitos.fi/nimiston-kyselypalvelu-ogc-api/tekninen-kuvaus}
#' for more information on the Geographic Names dataset.
#' \url{https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje} for
#' instructions on obtaining an API key.
#'
#' @author Markus Kainu \email{markus.kainu@@kapsi.fi}
#'
#' @importFrom httr2 request req_perform req_retry resp_body_json resp_body_string
#' @importFrom sf st_read st_transform
#' @importFrom purrr modify keep compact
#' @export
ogc_get_nimisto <- function(search_string = NULL,
                            collection = "placenames",
                            crs = 3067,
                            limit = NULL,
                            bbox = NULL,
                            custom_params = NULL,
                            api_key = getOption("geofi_mml_api_key")) {
  # Input validation
  if (!is.null(search_string) && (!is.character(search_string) || search_string == "")) {
    stop("search_string must be a non-empty character string or NULL", call. = FALSE)
  }
  if (!is.character(api_key) || is.null(api_key) || api_key == "") {
    stop("api_key must be a non-empty character string", call. = FALSE)
  }
  if (!crs %in% c(3067, 4326)) {
    stop("crs must be one of 3067 (ETRS-TM35FIN) or 4326 (WGS84)", call. = FALSE)
  }
  if (!collection %in% c("placenames", "mapnames", "placenames_simple")) {
    stop("collection must be one of placenames, mapnames or placenames_simple", call. = FALSE)
  }
  if (!is.null(limit) && (!is.numeric(limit) || limit <= 0)) {
    stop("limit must be a positive number or NULL", call. = FALSE)
  }
  if (!is.null(bbox)) {
    if (!is.character(bbox) || !grepl("^[0-9.-]+,[0-9.-]+,[0-9.-]+,[0-9.-]+$", bbox)) {
      stop("bbox must be a string in the format 'minx,miny,maxx,maxy' (e.g., '24.5,60.1,25.5,60.5')", call. = FALSE)
    }
    bbox_vals <- as.numeric(unlist(strsplit(bbox, ",")))
    if (length(bbox_vals) != 4 || any(is.na(bbox_vals))) {
      stop("bbox values must be numeric in the format 'minx,miny,maxx,maxy'", call. = FALSE)
    }
    if (bbox_vals[1] >= bbox_vals[3] || bbox_vals[2] >= bbox_vals[4]) {
      stop("bbox must satisfy minx < maxx and miny < maxy", call. = FALSE)
    }
  }
  if (!is.null(custom_params)) {
    if (!is.character(custom_params) || custom_params == "") {
      stop("custom_params must be a non-empty character string (e.g., 'attribute=value')", call. = FALSE)
    }
  }

  # Construct the base URL
  base_url <- paste0("https://avoin-paikkatieto.maanmittauslaitos.fi/geographic-names/features/v1/collections/",collection,"/items")

  # Construct query parameters
  queries <- paste0("api-key=", api_key)
  if (!is.null(limit)) {
    queries <- paste0(queries, "&limit=", limit)
  }
  if (!is.null(bbox)) {
    queries <- paste0(queries, "&bbox=", bbox)
  }
  if (!is.null(search_string)) {
    # URL-encode the search string to handle special characters
    encoded_search <- utils::URLencode(search_string, reserved = TRUE)
    queries <- paste0(queries, "&spelling_case_insensitive=", encoded_search)
  }
  if (!is.null(custom_params)) {
    queries <- paste0(queries, "&", custom_params)
  }

  # Combine base URL and query parameters
  api_url <- paste0(base_url, "?", queries)

  # Fetch the features using fetch_ogc_api_mml
  all_features <- tryCatch(
    fetch_ogc_api_mml(api_url = api_url, limitti = limit),
    error = function(e) {
      stop(
        sprintf(
          "Failed to fetch geographic names with search string '%s': %s",
          if (is.null(search_string)) "NULL" else search_string,
          e$message
        ),
        call. = FALSE
      )
    }
  )

  # Check if any features were returned
  if (is.null(all_features) || nrow(all_features) == 0) {
    warning(
      sprintf(
        "No features found for search string '%s' with the specified parameters",
        if (is.null(search_string)) "NULL" else search_string
      ),
      call. = FALSE
    )
    return(all_features)
  }

  # Transform the CRS if needed
  if (sf::st_crs(all_features)$epsg != crs) {
    all_features <- tryCatch(
      sf::st_transform(all_features, crs = crs),
      error = function(e) {
        stop(
          sprintf(
            "Failed to transform data to CRS %s: %s",
            crs,
            e$message
          ),
          call. = FALSE
        )
      }
    )
  }
  # remove  parallelName
  all_features$parallelName <- NULL

  return(all_features)
}
