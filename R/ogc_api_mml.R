#' Get all collections provided by Maastotietokanta (Topographic Database)
#'
#' Thin wrapper around OGC API for [Topographic database](https://www.maanmittauslaitos.fi/en/maps-and-spatial-data/expert-users/product-descriptions/topographic-database) provided by
#' [National Land Survey of Finland](https://www.maanmittauslaitos.fi/en) (NLS).
#'
#' @param api_key A string An [api key](https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje) is required to use NLS api services.
#'
#' @author Markus Kainu <markus.kainu@@kapsi.fi>
#'
#' @return data.frame
#' @examples
#' ogc_get_maastotietokanta_collections()
#'
ogc_get_maastotietokanta_collections <- function(api_key = getOption("geofi_mml_api_key")){

  if (is.null(api_key) | api_key == ""){
    stop("api_key must be provided")
  }
  url <- paste0("https://avoin-paikkatieto.maanmittauslaitos.fi/maastotiedot/features/v1/collections?api-key=", api_key)
  resp <- httr2::request(url) |>
    httr2::req_perform()
  resp_list <- httr2::resp_body_json(resp)
  ids <- resp_list$collections |> purrr::modify(c("id")) |> unlist()
  descriptions <- resp_list$collections |> purrr::modify(c("description")) |> unlist()
  dat <- data.frame(id = ids, description = descriptions)
  return(dat)
}


#' A internal helper
#'
#' @param api_url
#'
#' @author Markus Kainu <markus.kainu@@kapsi.fi>
#'
fetch_ogc_api_mml <- function(api_url,
                          limitti,
                          custom_params,
                          mml_apikey = getOption("geofi_mml_api_key")){

  # Set the user agent
  query_ua <- httr::user_agent("https://github.com/rOpenGov/geofi")

  if (is.null(limitti)){

    # if limit is missing, lets add the max to reduce the number of loop sequences
    api_url <- paste0(api_url, "&limit=10000")
    next_exists <- TRUE
    i <- 1
    data_list <- list()
    while (next_exists) {
      print(paste("Requesting (query nr.", i, ") from:", api_url))
      req <- httr2::request(api_url)
      resp <- httr2::req_perform(req)

      if (resp$status_code >= 400) {
        status_code <- resp$status_code
        stop(
          sprintf(
            "OGC API %s request failed\n[%s]",
            paste(api_url),
            httr::http_status(status_code)$message#,
          ),
          call. = FALSE
        )
      }
      # read the raw response into a list item as a data
      data_list[[i]] <- suppressMessages(sf::st_read(httr2::resp_body_string(resp), quiet = TRUE))
      # then check if the api offers more (if next link exists)
      resp_json <- httr2::resp_body_json(resp)
      link_rels <- resp_json$links |> purrr:: modify(c("rel")) |> unlist()
      if ("next" %in% link_rels){
        next_exists <- TRUE
        link_list <- resp_json$links |> purrr::keep(function(x) x$rel == "next") |> purrr::keep(function(x) grepl("json", x$type))
        api_url <- link_list[[1]]$href
      } else {
        next_exists <- FALSE
      }
      i <- i + 1
    }
    all_features <- do.call("rbind", data_list)

  } else {

    api_url <- paste0(api_url, "&limit=", limitti)

    req <- httr2::request(api_url)
    resp <- httr2::req_perform(req)

    if (resp$status_code >= 400) {
      status_code <- resp$status_code
      stop(
        sprintf(
          "OGC API %s request failed\n[%s]",
          paste(api_url),
          httr::http_status(status_code)$message#,
        ),
        call. = FALSE
      )
    }
    # read the raw response into a list item as a data
    print(paste("Requesting from:", api_url))
    all_features <- suppressMessages(sf::st_read(httr2::resp_body_string(resp), quiet = TRUE))

  }

  # dim(all_features)
  return(all_features)

}

#' Get a selected collection from [Topographic database](https://www.maanmittauslaitos.fi/en/maps-and-spatial-data/expert-users/product-descriptions/topographic-database)
#'
#' Thin wrapper around OGC API for [Topographic database](https://www.maanmittauslaitos.fi/en/maps-and-spatial-data/expert-users/product-descriptions/topographic-database) provided by
#' [National Land Survey of Finland](https://www.maanmittauslaitos.fi/en) (NLS).
#'
#' @param collection A string
#' @param output_crs
#' @param limit
#' @param bbox
#' @param custom_params
#' @param api_key A string An [api key](https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje) is required to use NLS api services.
#'
#' @author Markus Kainu <markus.kainu@@kapsi.fi>
#'
#' @return sf object
#' @examples
#' ogc_get_maastotietokanta(collection = "hautausmaa", output_crs = 3067)
#'
ogc_get_maastotietokanta <- function(collection = "hautausmaa",
                                 output_crs = 3067,
                                 limit = NULL,
                                 bbox = NULL,
                                 custom_params = NULL,
                                 api_key = getOption("geofi_mml_api_key")) {



  if (is.null(api_key)){
    stop("api_key must be provided")
  }
  if (!is.null(custom_params)){
    if (is.list(custom_params)) stop("")
  }

  if (!output_crs %in% c(3067, 4326)){
    stop("output_crs must be one of '3067','4326'")
  }

  base_url = paste0("https://avoin-paikkatieto.maanmittauslaitos.fi/maastotiedot/features/v1/collections/",collection,"/items?f=json")

  queries <- paste0("&api-key=",api_key)
  if (!is.null(bbox)){
    queries <- paste0(queries,"&bbox=",bbox)
  }

  # Construct the query URL
  urls <- paste0(base_url, queries)

  # Fetch all the features
  all_features <- fetch_ogc_api_mml(api_url = urls, limitti = limit)

  return(all_features)
}



#' Get all buildings related collections  [](https://www.maanmittauslaitos.fi/rakennusten-kyselypalvelu/tekninen-kuvaus)
#'
#' Thin wrapper around OGC API for [buildings data](https://www.maanmittauslaitos.fi/rakennusten-kyselypalvelu/tekninen-kuvaus) (In Finnish) provided by
#' [National Land Survey of Finland](https://www.maanmittauslaitos.fi/en) (NLS).
#'
#' @param api_key A string An [api key](https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje) is required to use NLS api services.
#'
#' @author Markus Kainu <markus.kainu@@kapsi.fi>
#'
#' @return data.frame
#' @examples
#' ogc_get_buildings_collections()
#'

ogc_get_buildings_collections <- function(api_key = getOption("geofi_mml_api_key")){

  if (is.null(api_key)){
    stop("api_key must be provided")
  }

  url <- paste0("https://avoin-paikkatieto.maanmittauslaitos.fi/buildings/features/v1/collections?api-key=", api_key)
  resp <- httr2::request(url) |>
    httr2::req_perform()
  resp_list <- httr2::resp_body_json(resp)
  ids <- resp_list$collections |> purrr::modify(c("id")) |> unlist()
  descriptions <- resp_list$collections |> purrr::modify(c("description")) |> unlist()
  dat <- data.frame(id = ids)
  return(dat)
}

#' Get a selected collection from [Topographic database](https://www.maanmittauslaitos.fi/en/maps-and-spatial-data/expert-users/product-descriptions/topographic-database)
#'
#' Thin wrapper around OGC API for [Topographic database](https://www.maanmittauslaitos.fi/en/maps-and-spatial-data/expert-users/product-descriptions/topographic-database) provided by
#' [National Land Survey of Finland](https://www.maanmittauslaitos.fi/en) (NLS).
#'
#' @param collection A string
#' @param output_crs
#' @param limit
#' @param bbox
#' @param custom_params
#' @param api_key A string An [api key](https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje) is required to use NLS api services.
#'
#' @author Markus Kainu <markus.kainu@@kapsi.fi>
#'
#' @return sf object
#' @examples
#' ogc_get_maastotietokanta(collection = "hautausmaa", output_crs = 3067)
#'
ogc_get_buildings <- function(collection = "buildings",
                              output_crs = 3067,
                              limit = 10,
                              bbox = NULL,
                              custom_params = NULL,
                              api_key = getOption("geofi_mml_api_key")) {



  if (is.null(api_key)){
    stop("api_key must be provided")
  }

  if (!output_crs %in% c(3067, 4326)){
    stop("output_crs must be one of '3067','4326'")
  }

  base_url = paste0("https://avoin-paikkatieto.maanmittauslaitos.fi/buildings/features/v1/collections/",collection,"/items?f=json")

  queries <- paste0("&api-key=",api_key)
  if (!is.null(bbox)){
    queries <- paste0(queries,"&bbox=",bbox)
  }

  # Construct the query URL
  urls <- paste0(base_url, queries)

  # Fetch all the features
  all_features <- fetch_ogc_api_mml(api_url = urls, limitti = limit)

  return(all_features)
}




#' Query OCG API features service on [Geographic names](https://www.maanmittauslaitos.fi/en/maps-and-spatial-data/expert-users/product-descriptions/geographic-names) (Nimistö)
#'
#' Thin wrapper around OGC API for [Geographic names](https://www.maanmittauslaitos.fi/en/maps-and-spatial-data/expert-users/product-descriptions/geographic-names) provided by
#' [National Land Survey of Finland](https://www.maanmittauslaitos.fi/en) (NLS).
#'
#' @param search_string A string
#' @param output_crs
#' @param limit
#' @param bbox \code{1000}
#' @param custom_params
#' @param api_key A string An [api key](https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje) is required to use NLS api services.
#'
#' @author Markus Kainu <markus.kainu@@kapsi.fi>
#'
#' @return sf object
#' @examples
#' ogc_get_nimisto(collection = "hautausmaa", output_crs = 3067)
#'
ogc_get_nimisto <- function(search_string = NULL,
                              output_crs = 3067,
                              limit = 10,
                              bbox = NULL,
                              custom_params = NULL,
                              api_key = getOption("geofi_mml_api_key")) {



  if (is.null(api_key)){
    stop("api_key must be provided")
  }

  if (!output_crs %in% c(3067, 4326)){
    stop("output_crs must be one of '3067','4326'")
  }

  base_url = "https://avoin-paikkatieto.maanmittauslaitos.fi/geographic-names/features/v1/collections/placenames/items?f=json"

  queries <- paste0("&api-key=",api_key)
  if (!is.null(bbox)){
    queries <- paste0(queries,"&bbox=",bbox)
  }
  if (!is.null(search_string)){
    queries <- paste0(queries,"&spelling_case_insensitive=",search_string)
  }

  # Construct the query URL
  urls <- paste0(base_url, queries) |> URLencode()

  # Fetch all the features
  all_features <- fetch_ogc_api_mml(api_url = urls, limitti = limit)

  return(all_features)
}

