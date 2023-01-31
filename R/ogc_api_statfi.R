
fetch_ogc_api_statfi <- function(api_url = "https://geo.stat.fi/inspire/ogc/api/pd/collections/StatisticalValue_by_StatisticalGridCell_RES_5000m_EPSG_3067_2019/items?f=json&limit=10000",
                          limitti){

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


#' Get Finnish municipality (multi)polygons for different years and/or scales.
#'
#' Thin wrapper around Finnish statistical area units OGC API by
#' [Statistics Finland](https://www.stat.fi/org/avoindata/paikkatietoaineistot/kuntapohjaiset_tilastointialueet_en.html).
#'
#' @param year A numeric for year of the administrative borders. Available are
#'             2020, 2021 and 2022.
#' @param scale A scale or resolution of the shape. Two options: \code{1000}
#'             equals 1:1 000 000 and \code{4500} equals 1:4 500 000.
#' @param tessellation A scale or resolution of the shape. Two options: \code{1000}
#'             equals 1:1 000 000 and \code{4500} equals 1:4 500 000.

#' @author Markus Kainu <markus.kainu@@kapsi.fi>

#' @return sf object
#' @examples
#' get_ogc_municipalities(year = 2020,
#'             tessellation = "maakunta",
#'             output_crs = 4326,
#'             limit = 10)
#'
ogc_get_statfi_area <- function(year = 2022,
                                 scale = 4500,
                                 tessellation = NULL,
                                 output_crs = 3067,
                                 limit = NULL,
                                 bbox = NULL) {


  if (!is.null(tessellation)){
    if (!tessellation %in% c("avi",
                             "ely",
                             "hyvinvointialue",
                             "kunta",
                             "maakunta",
                             "seutukunta",
                             "suuralue",
                             "tyossakayntialue",
                             "vaalipiiri")){
      stop('tessalation must be one of "avi", "ely", "hyvinvointialue", "kunta", "maakunta", "seutukunta", "suuralue", "tyossakayntialue", "vaalipiiri"')
    }
  }
  if (!output_crs %in% c(3067, 4326)){
    stop("output_crs must be one of '3067','4326'")
  }
  if (!year %in% c(2020:2022)){
    stop("output_crs must be one of '2020','2021','2022'")
  }

  if (scale == 4500){
    collection_pre <- "AreaStatisticalUnit_4500k_"
  } else if (scale == 1000){
    collection_pre <- "AreaStatisticalUnit_1000k_"
  }
  if (output_crs == 3067){
    collection_post <- paste0("EPSG_3067_",year,"/items")
  } else if (output_crs == 4326){
    collection_post <- paste0("EPSG_4326_",year,"/items")
  }

  base_url = paste0("https://geo.stat.fi/inspire/ogc/api/su/collections/",collection_pre,collection_post)

  queries <- paste0("?f=json")
  if (!is.null(tessellation)){
    queries <- paste0(queries, "&tessellation=", tessellation)
  }
  if (!is.null(bbox)){
    queries <- paste0(queries,"&bbox=",bbox)
  }

  # Set the user agent
  ua <- httr::user_agent("https://github.com/rOpenGov/geofi")

  # Construct the query URL
  urls <- paste0(base_url, queries)

  # Fetch all the features
  all_features <- fetch_ogc_api(api_url = urls, limitti = limit)

  return(all_features)
}


# ff <- ogc_get_statfi_area(tessellation = NULL, scale = 4500, output_crs = 4326,
#                           # bbox = lappi_bbox,
#                           limit=NULL)
# dim(ff)
# ggplot(ff) + geom_sf()






#' Get Finnish municipality (multi)polygons with population for different years and/or scales.
#'
#' Thin wrapper around Finnish statistical area units OGC API by
#' [Statistics Finland](https://www.stat.fi/org/avoindata/paikkatietoaineistot/kuntapohjaiset_tilastointialueet_en.html).
#'
#' @param year A numeric for year of the administrative borders. Available are
#'             2020, 2021 and 2022.
#' @param scale A scale or resolution of the shape. Two options: \code{1000}
#'             equals 1:1 000 000 and \code{4500} equals 1:4 500 000.
#' @param tessellation A scale or resolution of the shape. Two options: \code{1000}
#'             equals 1:1 000 000 and \code{4500} equals 1:4 500 000.

#' @author Markus Kainu <markus.kainu@@kapsi.fi>

#' @return sf object
#' @examples
#' get_ogc_municipalities_pop(year = 2020,
#'             tessellation = "maakunta",
#'             output_crs = 4326,
#'             limit = 10)
#'
ogc_get_statfi_area_pop <- function(year = 2021,
                                   output_crs = 3067,
                                   limit = NULL,
                                   bbox=NULL) {


  if (!output_crs %in% c(3067, 4326)){
    stop("output_crs must be one of '3067','4326'")
  }
  if (!year %in% c(2019:2021)){
    stop("output_crs must be one of '2019','2020','2021'")
  }

  if (output_crs == 3067){
    collection <- paste0("StatisticalValue_by_AreaStatisticalUnit_4500k_EPSG_3067_",year,"/items")
  } else if (output_crs == 4326){
    collection <- paste0("StatisticalValue_by_AreaStatisticalUnit_4500k_EPSG_4326_",year,"/items")
  }

  base_url = paste0("https://geo.stat.fi/inspire/ogc/api/pd/collections/",collection)

  queries <- paste0("?f=json")

  if (!is.null(bbox)){
    queries <- paste0(queries,"&bbox=",bbox)
  }
  # if (!is.null(limit)){
  #   queries <- paste0(queries,"&limit=",limit)
  # } else {
  #   queries <- paste0(queries,"&limit=10000")
  # }

  # Construct the query URL
  urls <- paste0(base_url, queries)
  all_features <- fetch_ogc_api(api_url = urls, limitti = limit)

  if (nrow(all_features) == 0){
    return()
  } else {
    # resp_sf$query <- x
    resp_sf <- all_features |>
      dplyr::select(areaStatisticalUnit_inspireId_localId,statisticalDistribution_inspireId_localId,value) |>
      dplyr::mutate(statisticalDistribution_inspireId_localId = gsub("^.+_pd_|_[0-9]{4}$", "", statisticalDistribution_inspireId_localId)) |>
      tidyr::pivot_wider(names_from = "statisticalDistribution_inspireId_localId", values_from = "value")
    return(resp_sf)
  }

  # dat <- lapply(urls, query_geocode) |> do.call("bind_rows", .)
  dat <- query_geocode(urls)
  return(dat)
}

# ff <- ogc_get_statfi_area_pop(year = 2021,
#                               # bbox = helsinki_bbox,
#                               output_crs = 3067,
#                               # limit = 22
#                               )
# dim(ff)
# ggplot(data = ff) + geom_sf()
# ggplot(data = ff[grepl("^kunta", ff$areaStatisticalUnit_inspireId_localId),]) + geom_sf()
#
#
# ff <- ogc_get_statfi_area_pop(year = 2021,
#                               output_crs = 4326
# )
# ggplot(data = ff[grepl("^kunta", ff$areaStatisticalUnit_inspireId_localId),], aes(fill = female_percentage)) + geom_sf()


#' Get Finnish municipality (multi)polygons with population for different years and/or scales.
#'
#' Thin wrapper around Finnish statistical area units OGC API by
#' [Statistics Finland](https://www.stat.fi/org/avoindata/paikkatietoaineistot/kuntapohjaiset_tilastointialueet_en.html).
#'
#' @param year A numeric for year of the administrative borders. Available are
#'             2020, 2021 and 2022.
#' @param scale A scale or resolution of the shape. Two options: \code{1000}
#'             equals 1:1 000 000 and \code{4500} equals 1:4 500 000.
#' @param tessellation A scale or resolution of the shape. Two options: \code{1000}
#'             equals 1:1 000 000 and \code{4500} equals 1:4 500 000.

#' @author Markus Kainu <markus.kainu@@kapsi.fi>

#' @return sf object
#' @examples
#' get_ogc_municipalities_pop(year = 2020,
#'             tessellation = "maakunta",
#'             output_crs = 4326,
#'             limit = 10)
#'
ogc_get_statfi_statistical_grid <- function(year = 2021,
                                            resolution = 5000,
                                            limit = NULL,
                                            bbox=NULL) {

  if (!year %in% c(2019:2021)){
    stop("output_crs must be one of '2019','2020','2021'")
  }
  if (!resolution %in% c(5000,1000)){
    stop("resolution must be one of '5000','1000'")
  }


    queries <- paste0("StatisticalValue_by_StatisticalGridCell_RES_",resolution,"m_EPSG_3067_",year,"/items?f=json")
    if (!is.null(bbox)){
      queries <- paste0(queries,"&bbox=",bbox)
    }
    # if (!is.null(limit)){
    #   queries <- paste0(queries,"&limit=",limit)
    # } else {
    #   queries <- paste0(queries,"&limit=10000")
    # }


  base_url = paste0("https://geo.stat.fi/inspire/ogc/api/pd/collections/",queries)

  all_features <- fetch_ogc_api(api_url = base_url, limitti = limit)

  if (nrow(all_features) == 0){
    return()
  } else {
    # resp_sf$query <- x
    resp_sf <- all_features |>
      dplyr::select(statisticalGridCell_statisticalGrid_inspireId_localId,statisticalDistribution_inspireId_localId,value) |>
      dplyr::mutate(statisticalDistribution_inspireId_localId = gsub("^.+_pd_|_[0-9]{4}$", "", statisticalDistribution_inspireId_localId)) |>
      tidyr::pivot_wider(names_from = "statisticalDistribution_inspireId_localId", values_from = "value")
    return(resp_sf)
  }
}

# helsinki <- geofi::get_municipalities() |>
#   dplyr::filter(municipality_code == 91) |>
#   sf::st_transform(4326)
# helsinki_bbox <- paste0(sf::st_bbox(helsinki),collapse = ",")
#
# lappi <- get_ogc_municipalities(tessellation = "maakunta", output_crs = 4326) |>
#   dplyr::filter(geographicalName_fin == "Lappi")
# lappi_bbox <- paste0(sf::st_bbox(lappi),collapse = ",")
#
# #
# #
# grid5000 <- ogc_get_statfi_statistical_grid(resolution = 5000,
#                                             bbox = helsinki_bbox,
#                                             limit = 6
#                                             )
# mapview::mapview(grid5000)
# #
# # grid1000 <- get_ogc_statistical_grid(resolution = 1000)
# #
# # get_ogc_municipalities_pop(bbox = lappi_bbox)
# #
# #
# #
# #
