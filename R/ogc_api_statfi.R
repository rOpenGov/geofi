#' Fetch data from Statistics Finland OGC API
#'
#' Internal helper function to retrieve spatial data from Statistics Finland's OGC API.
#' Handles pagination for large datasets and single requests with specified limits.
#'
#' @param api_url Character. The API URL to query.
#' @param limit Integer or NULL. Number of features to retrieve. If NULL, fetches all available features (max 10000 per request).
#' @param crs Integer. Coordinate Reference System (EPSG code). Options: 3067 (ETRS89 / TM35FIN), 4326 (WGS84).
#'
#' @return An `sf` object containing the requested spatial data, or NULL if no data is retrieved.
#' @author Markus Kainu <markus.kainu@@kapsi.fi>
#' @keywords internal
fetch_ogc_api_statfi <- function(api_url, limit = NULL, crs) {
  # Input validation
  if (!is.character(api_url) || nchar(api_url) == 0) {
    stop("`api_url` must be a non-empty character string.", call. = FALSE)
  }
  if (!is.null(limit) && (!is.numeric(limit) || limit < 1)) {
    stop("`limit` must be a positive integer or NULL.", call. = FALSE)
  }
  if (!is.numeric(crs) || !crs %in% c(3067, 4326)) {
    stop("`crs` must be one of: 3067, 4326", call. = FALSE)
  }

  # Set user agent
  query_ua <- httr::user_agent("https://github.com/rOpenGov/geofi")

  # Handle pagination if limit is NULL
  if (is.null(limit)) {
    api_url <- paste0(api_url, "&limit=10000")
    data_list <- list()
    next_exists <- TRUE
    i <- 1

    while (next_exists) {
      message(sprintf("Requesting (query %d) from: %s", i, api_url))
      req <- httr2::request(api_url) |> httr2::req_user_agent(query_ua$options$useragent)
      resp <- tryCatch(
        httr2::req_perform(req),
        error = function(e) stop("Failed to perform request: ", e$message, call. = FALSE)
      )

      if (resp$status_code >= 400) {
        stop(
          sprintf(
            "OGC API request failed for %s\n[%s]",
            api_url,
            httr::http_status(resp$status_code)$message
          ),
          call. = FALSE
        )
      }

      # Read response into sf object with specified CRS
      data_list[[i]] <- suppressWarnings(suppressMessages(
        sf::st_read(httr2::resp_body_string(resp), quiet = TRUE, crs = crs)
      ))

      # Check for next page
      resp_json <- httr2::resp_body_json(resp)
      link_rels <- purrr::map_chr(resp_json$links, "rel")
      if ("next" %in% link_rels) {
        next_link <- purrr::keep(resp_json$links, ~ .x$rel == "next" && grepl("json", .x$type))
        if (length(next_link) == 0) {
          next_exists <- FALSE
        } else {
          api_url <- next_link[[1]]$href
        }
      } else {
        next_exists <- FALSE
      }
      i <- i + 1
    }

    # Filter out empty sf objects (those with zero rows)
    data_list <- data_list[purrr::map_lgl(data_list, ~ nrow(.x) > 0)]

    # Combine results
    if (length(data_list) == 0) {
      warning("No data retrieved from the API.", call. = FALSE)
      return(NULL)
    }
    all_features <- do.call(rbind, data_list)

  } else {
    # Single request with specified limit
    api_url <- paste0(api_url, "&limit=", limit)
    message(sprintf("Requesting from: %s", api_url))
    req <- httr2::request(api_url) |> httr2::req_user_agent(query_ua$options$useragent)
    resp <- tryCatch(
      httr2::req_perform(req),
      error = function(e) stop("Failed to perform request: ", e$message, call. = FALSE)
    )

    if (resp$status_code >= 400) {
      stop(
        sprintf(
          "OGC API request failed for %s\n[%s]",
          api_url,
          httr::http_status(resp$status_code)$message
        ),
        call. = FALSE
      )
    }

    # Read response into sf object with specified CRS
    all_features <- suppressWarnings(suppressMessages(
      sf::st_read(httr2::resp_body_string(resp), quiet = TRUE, crs = crs)
    ))
  }

  if (is.null(all_features) || nrow(all_features) == 0) {
    warning("No features retrieved from the API.", call. = FALSE)
    return(NULL)
  }

  return(all_features)
}

#' Retrieve Finnish Administrative Area Polygons
#'
#' Retrieves municipality or other administrative (multi)polygons from Statistics Finland's OGC API.
#' Supports different years, scales, and tessellation types for Finnish administrative boundaries.
#'
#' @param year Integer. Year of the administrative borders. Options: 2020, 2021, 2022. Default: 2022.
#' @param scale Integer. Map scale/resolution. Options: 1000 (1:1,000,000), 4500 (1:4,500,000). Default: 4500.
#' @param tessellation Character or NULL. Type of administrative unit. Options: "avi", "ely", "hyvinvointialue",
#'   "kunta", "maakunta", "seutukunta", "suuralue", "tyossakayntialue", "vaalipiiri". If NULL, retrieves all units.
#'   Default: NULL.
#' @param crs Integer. Coordinate Reference System (EPSG code). Options: 3067 (ETRS89 / TM35FIN), 4326 (WGS84).
#'   Default: 3067.
#' @param limit Integer or NULL. Maximum number of features to retrieve. If NULL, retrieves all available features.
#'   Default: NULL.
#' @param bbox Character or NULL. Bounding box for spatial filtering in format "xmin,ymin,xmax,ymax" (in the specified CRS).
#'   Default: NULL.
#'
#' @return An `sf` object containing the requested spatial data, or NULL if no data is retrieved.
#' @author Markus Kainu <markus.kainu@@kapsi.fi>
#' @export
#' @examples
#' \dontrun{
#' # Get all municipalities for 2020 at 1:4,500,000 scale
#' munis <- ogc_get_statfi_area(year = 2020, scale = 4500, tessellation = "kunta")
#'
#' # Get wellbeing areas for 2022 with a limit of 10 features
#' wellbeing <- ogc_get_statfi_area(year = 2022, tessellation = "hyvinvointialue", limit = 10)
#'
#' # Get data within a bounding box
#' bbox <- "200000,6600000,500000,6900000"
#' data <- ogc_get_statfi_area(year = 2021, bbox = bbox, crs = 3067)
#' }
ogc_get_statfi_area <- function(year = 2022,
                                scale = 4500,
                                tessellation = NULL,
                                crs = 3067,
                                limit = NULL,
                                bbox = NULL) {
  # Input validation
  valid_years <- 2020:2022
  valid_scales <- c(1000, 4500)
  valid_crs <- c(3067, 4326)
  valid_tessellations <- c(
    "avi", "ely", "hyvinvointialue", "kunta", "maakunta",
    "seutukunta", "suuralue", "tyossakayntialue", "vaalipiiri"
  )

  if (!is.numeric(year) || !year %in% valid_years) {
    stop(sprintf("`year` must be one of: %s", paste(valid_years, collapse = ", ")), call. = FALSE)
  }
  if (!is.numeric(scale) || !scale %in% valid_scales) {
    stop(sprintf("`scale` must be one of: %s", paste(valid_scales, collapse = ", ")), call. = FALSE)
  }
  if (!is.numeric(crs) || !crs %in% valid_crs) {
    stop(sprintf("`crs` must be one of: %s", paste(valid_crs, collapse = ", ")), call. = FALSE)
  }
  if (!is.null(tessellation) && !tessellation %in% valid_tessellations) {
    stop(
      sprintf(
        "`tessellation` must be one of: %s",
        paste(valid_tessellations, collapse = ", ")
      ),
      call. = FALSE
    )
  }
  if (!is.null(limit) && (!is.numeric(limit) || limit < 1)) {
    stop("`limit` must be a positive integer or NULL.", call. = FALSE)
  }
  if (!is.null(bbox) && !is.character(bbox)) {
    stop("`bbox` must be a character string in format 'xmin,ymin,xmax,ymax' or NULL.", call. = FALSE)
  }

  # Construct collection prefix and postfix
  collection_pre <- switch(as.character(scale),
                           "1000" = "AreaStatisticalUnit_1000k_",
                           "4500" = "AreaStatisticalUnit_4500k_"
  )
  collection_post <- sprintf("EPSG_%d_%d/items", crs, year)

  # Build base URL
  base_url <- sprintf(
    "https://geo.stat.fi/inspire/ogc/api/su/collections/%s%s",
    collection_pre, collection_post
  )

  # Construct query parameters
  queries <- "?f=json"
  if (!is.null(tessellation)) {
    queries <- paste0(queries, "&tessellation=", tessellation)
  }
  if (!is.null(bbox)) {
    queries <- paste0(queries, "&bbox=", bbox)
  }

  # Fetch data, passing the CRS
  all_features <- fetch_ogc_api_statfi(api_url = paste0(base_url, queries), limit = limit, crs = crs)

  if (is.null(all_features)) {
    message("No features retrieved. Check parameters or API availability.")
    return(NULL)
  }

  return(all_features)
}



#' Retrieve Finnish Administrative Area Polygons with Population Data
#'
#' Retrieves municipality or other administrative (multi)polygons with population data from Statistics Finland's OGC API.
#' Supports different years and coordinate reference systems for Finnish administrative boundaries at a fixed scale of 1:4,500,000.
#'
#' @param year Integer. Year of the administrative borders and population data. Options: 2019, 2020, 2021. Default: 2021.
#' @param crs Integer. Coordinate Reference System (EPSG code). Options: 3067 (ETRS89 / TM35FIN), 4326 (WGS84). Default: 3067.
#' @param limit Integer or NULL. Maximum number of features to retrieve. If NULL, retrieves all available features. Default: NULL.
#' @param bbox Character or NULL. Bounding box for spatial filtering in format "xmin,ymin,xmax,ymax" (in the specified CRS). Default: NULL.
#'
#' @return An `sf` object containing spatial data and population statistics, pivoted to wide format with variables as columns, or NULL if no data is retrieved.
#' @author Markus Kainu <markus.kainu@@kapsi.fi>
#' @export
#' @examples
#' \dontrun{
#' # Get population data for 2020
#' pop_data <- ogc_get_statfi_area_pop(year = 2020, crs = 3067)
#'
#' # Get population data within a bounding box
#' bbox <- "200000,6600000,500000,6900000"
#' pop_data <- ogc_get_statfi_area_pop(year = 2021, bbox = bbox, crs = 3067)
#'
#' # Limit to 10 features
#' pop_data <- ogc_get_statfi_area_pop(year = 2019, limit = 10, crs = 4326)
#' }
ogc_get_statfi_area_pop <- function(year = 2023,
                                    crs = 3067,
                                    limit = NULL,
                                    bbox = NULL) {
  # Input validation
  valid_years <- 2019:2023
  valid_crs <- c(3067, 4326)

  if (!is.numeric(year) || !year %in% valid_years) {
    stop(sprintf("`year` must be one of: %s", paste(valid_years, collapse = ", ")), call. = FALSE)
  }
  if (!is.numeric(crs) || !crs %in% valid_crs) {
    stop(sprintf("`crs` must be one of: %s", paste(valid_crs, collapse = ", ")), call. = FALSE)
  }
  if (!is.null(limit) && (!is.numeric(limit) || limit < 1)) {
    stop("`limit` must be a positive integer or NULL.", call. = FALSE)
  }
  if (!is.null(bbox) && !is.character(bbox)) {
    stop("`bbox` must be a character string in format 'xmin,ymin,xmax,ymax' or NULL.", call. = FALSE)
  }

  # Construct collection
  collection <- sprintf("StatisticalValue_by_AreaStatisticalUnit_4500k_EPSG_%d_%d/items", crs, year)

  # Build base URL
  base_url <- sprintf("https://geo.stat.fi/inspire/ogc/api/pd/collections/%s", collection)

  # Construct query parameters
  queries <- "?f=json"
  if (!is.null(bbox)) {
    queries <- paste0(queries, "&bbox=", bbox)
  }

  # Fetch data
  all_features <- fetch_ogc_api_statfi(api_url = paste0(base_url, queries), limit = limit, crs = crs)

  if (is.null(all_features) || nrow(all_features) == 0) {
    message("No features retrieved. Check parameters or API availability.")
    return(NULL)
  }

  # Process data
  resp_sf <- all_features[c("areaStatisticalUnit_inspireId_localId", "statisticalDistribution_inspireId_localId", "value")]
  resp_sf$statisticalDistribution_inspireId_localId <- gsub("^.+_pd_|_[0-9]{4}$", "", resp_sf$statisticalDistribution_inspireId_localId)
  res  <- resp_sf |>
    tidyr::pivot_wider(names_from = "statisticalDistribution_inspireId_localId",
                       values_from = "value")

  return(res)
}

#' Retrieve Finnish Statistical Grid with Population Data
#'
#' Retrieves population data for Finnish statistical grid cells from Statistics Finland's OGC API.
#' Supports different years and grid resolutions, with data in EPSG:3067 (ETRS89 / TM35FIN).
#'
#' @param year Integer. Year of the grid and population data. Options: 2019, 2020, 2021. Default: 2021.
#' @param resolution Integer. Grid cell resolution in meters. Options: 1000 (1km), 5000 (5km). Default: 5000.
#' @param limit Integer or NULL. Maximum number of features to retrieve. If NULL, retrieves all available features. Default: NULL.
#' @param bbox Character or NULL. Bounding box for spatial filtering in format "xmin,ymin,xmax,ymax" (in EPSG:3067). Default: NULL.
#'
#' @return An `sf` object containing grid cell spatial data and population statistics, pivoted to wide format with variables as columns, or NULL if no data is retrieved.
#' @author Markus Kainu <markus.kainu@@kapsi.fi>
#' @export
#' @examples
#' \dontrun{
#' # Get 5km grid population data for 2020
#' grid_data <- ogc_get_statfi_statistical_grid2(year = 2020, resolution = 5000)
#'
#' # Get 1km grid data within a bounding box
#' bbox <- "200000,6600000,500000,6900000"
#' grid_data <- ogc_get_statfi_statistical_grid2(year = 2021, resolution = 1000, bbox = bbox)
#'
#' # Limit to 10 features
#' grid_data <- ogc_get_statfi_statistical_grid2(year = 2019, resolution = 5000, limit = 10)
#' }
ogc_get_statfi_statistical_grid <- function(year = 2021,
                                             resolution = 5000,
                                             limit = NULL,
                                             bbox = NULL) {
  # Input validation
  valid_years <- 2019:2021
  valid_resolutions <- c(1000, 5000)

  if (!is.numeric(year) || !year %in% valid_years) {
    stop(sprintf("`year` must be one of: %s", paste(valid_years, collapse = ", ")), call. = FALSE)
  }
  if (!is.numeric(resolution) || !resolution %in% valid_resolutions) {
    stop(sprintf("`resolution` must be one of: %s", paste(valid_resolutions, collapse = ", ")), call. = FALSE)
  }
  if (!is.null(limit) && (!is.numeric(limit) || limit < 1)) {
    stop("`limit` must be a positive integer or NULL.", call. = FALSE)
  }
  if (!is.null(bbox) && !is.character(bbox)) {
    stop("`bbox` must be a character string in format 'xmin,ymin,xmax,ymax' or NULL.", call. = FALSE)
  }

  # Construct collection
  collection <- sprintf("StatisticalValue_by_StatisticalGridCell_RES_%dm_EPSG_3067_%d/items", resolution, year)

  # Build base URL
  base_url <- sprintf("https://geo.stat.fi/inspire/ogc/api/pd/collections/%s", collection)

  # Construct query parameters
  queries <- "?f=json"
  if (!is.null(bbox)) {
    queries <- paste0(queries, "&bbox=", bbox)
  }

  # Fetch data (hardcoded to EPSG:3067 as per API)
  all_features <- fetch_ogc_api_statfi(api_url = paste0(base_url, queries), limit = limit, crs = 3067)

  if (is.null(all_features) || nrow(all_features) == 0) {
    message("No features retrieved. Check parameters or API availability.")
    return(NULL)
  }

  # Process data
  resp_sf <- all_features[c("statisticalGridCell_statisticalGrid_inspireId_localId", "statisticalDistribution_inspireId_localId", "value")]
  resp_sf$statisticalDistribution_inspireId_localId <- gsub("^.+_pd_|_[0-9]{4}$", "", resp_sf$statisticalDistribution_inspireId_localId)
  res <- resp_sf |>
    tidyr::pivot_wider(names_from = "statisticalDistribution_inspireId_localId", values_from = "value")
  return(res)
}

