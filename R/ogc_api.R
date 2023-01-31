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
get_ogc_municipalities <- function(year = 2022,
                                   scale = 4500,
                                   tessellation = "kunta",
                                   output_crs = 3067,
                                   limit = 310) {


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

  queries <- paste0("?f=json",
                    "&limit=",limit,
                    "&tessellation=",tessellation)
  # if (!is.null(size)){
  #   queries <- paste0(queries, "&size=", size)
  # }

  # Set the user agent
  ua <- httr::user_agent("https://github.com/rOpenGov/geofi")
  # Construct the query URL
  urls <- paste0(base_url, queries)

  query_geocode <- function(x, query_ua = ua, crs1=output_crs){
    # Get the response and check the response.
    resp <- httpcache::GET(x, query_ua)

    if (httr::http_error(resp)) {
      status_code <- httr::status_code(resp)
      stop(
        sprintf(
          "OGC API %s request failed\n[%s]",
          paste(x),
          httr::http_status(status_code)$message#,
        ),
        call. = FALSE
      )
    }
    resp_sf <- suppressMessages(sf::st_read(resp, quiet = TRUE))
    if (nrow(resp_sf) == 0){
      return()
    } else {
      resp_sf$query <- x
      return(resp_sf)
    }
  }
  dat <- query_geocode(urls)
  print(paste0("Requesting data from: ", urls))
  return(dat)
}


# ff <- get_ogc_municipalities(tessellation = "maakunta", scale = 4500, output_crs = 3067)
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
get_ogc_municipalities_pop <- function(year = 2021,
                                       tessellation = "maakunta",
                                   output_crs = 3067,
                                   limit = 310,
                                   bbox=NULL) {


  # if (!tessellation %in% c("avi",
  #                          "ely",
  #                          "hyvinvointialue",
  #                          "kunta",
  #                          "maakunta",
  #                          "seutukunta",
  #                          "suuralue",
  #                          "tyossakayntialue",
  #                          "vaalipiiri")){
  #   stop('tessalation must be one of "avi", "ely", "hyvinvointialue", "kunta", "maakunta", "seutukunta", "suuralue", "tyossakayntialue", "vaalipiiri"')
  # }
  if (!output_crs %in% c(3067, 4326)){
    stop("output_crs must be one of '3067','4326'")
  }
  if (!year %in% c(2019:2021)){
    stop("output_crs must be one of '2019','2020','2021'")
  }

  # if (scale == 4500){
  #   collection <- paste0("StatisticalDistribution_by_AreaStatisticalUnit_4500k_",year,"/items")
  # } else if (scale == 1000){
  #   collection <- paste0("StatisticalDistribution_by_AreaStatisticalUnit_1000k_",year,"/items")
  # }
  if (output_crs == 3067){
    collection <- paste0("StatisticalValue_by_AreaStatisticalUnit_4500k_EPSG_3067_",year,"/items")
  } else if (output_crs == 4326){
    collection <- paste0("StatisticalValue_by_AreaStatisticalUnit_4500k_EPSG_4326_",year,"/items")
  }

  base_url = paste0("https://geo.stat.fi/inspire/ogc/api/pd/collections/",collection)

  # constructing the tessallation query
  if (FALSE){
    library(httr2)
    library(dplyr)
    url_items <- "https://geo.stat.fi/inspire/ogc/api/pd/collections/StatisticalValue_by_AreaStatisticalUnit_4500k_EPSG_3067_2020/items?f=json&limit=1000"
    next_exists <- TRUE
    i <- 1
    data_list <- list()
    while (next_exists) {
      print(i)
      req <- request(url_items)
      resp <- req_perform(req)
      # read the raw response into a list item as a data
      data_list[[i]] <- st_read(resp_body_string(resp))
      # then check if the api offers more (if next link exists)
      resp_json <- resp_body_json(resp)
      link_rels <- resp_json$links %>% purrr:: modify(c("rel")) %>% unlist()
      if ("next" %in% link_rels){
        next_exists <- TRUE
        # next link
        url_items <- resp_json$links %>% purrr::keep(function(x) x$rel == "next") %>% .[[1]] %>% .$href
      } else {
        next_exists <- FALSE
      }
      i <- i + 1
    }
    all_features <- do.call("bind_rows", data_list)
    dim(all_features)

    st_drop_geometry(all_features) |>
      count(areaStatisticalUnit_inspireId_localId) |>
      mutate(tessellation = sub("_.+$", "", areaStatisticalUnit_inspireId_localId)) |>
      select(-n) -> tessellation_df
  }

  tessellation_df <- structure(list(areaStatisticalUnit_inspireId_localId = c("avi_1_20210101_1",
                                                           "avi_1_20210101_2", "avi_1_20210101_3", "avi_1_20210101_4", "avi_1_20210101_5",
                                                           "avi_1_20210101_6", "avi_1_20210101_7", "ely_1_20210101_01",
                                                           "ely_1_20210101_02", "ely_1_20210101_03", "ely_1_20210101_04",
                                                           "ely_1_20210101_05", "ely_1_20210101_06", "ely_1_20210101_07",
                                                           "ely_1_20210101_08", "ely_1_20210101_09", "ely_1_20210101_10",
                                                           "ely_1_20210101_11", "ely_1_20210101_12", "ely_1_20210101_13",
                                                           "ely_1_20210101_14", "ely_1_20210101_15", "ely_1_20210101_16",
                                                           "kunta_1_20210101_005", "kunta_1_20210101_009", "kunta_1_20210101_010",
                                                           "kunta_1_20210101_016", "kunta_1_20210101_018", "kunta_1_20210101_019",
                                                           "kunta_1_20210101_020", "kunta_1_20210101_035", "kunta_1_20210101_043",
                                                           "kunta_1_20210101_046", "kunta_1_20210101_047", "kunta_1_20210101_049",
                                                           "kunta_1_20210101_050", "kunta_1_20210101_051", "kunta_1_20210101_052",
                                                           "kunta_1_20210101_060", "kunta_1_20210101_061", "kunta_1_20210101_062",
                                                           "kunta_1_20210101_065", "kunta_1_20210101_069", "kunta_1_20210101_071",
                                                           "kunta_1_20210101_072", "kunta_1_20210101_074", "kunta_1_20210101_075",
                                                           "kunta_1_20210101_076", "kunta_1_20210101_077", "kunta_1_20210101_078",
                                                           "kunta_1_20210101_079", "kunta_1_20210101_081", "kunta_1_20210101_082",
                                                           "kunta_1_20210101_086", "kunta_1_20210101_090", "kunta_1_20210101_091",
                                                           "kunta_1_20210101_092", "kunta_1_20210101_097", "kunta_1_20210101_098",
                                                           "kunta_1_20210101_102", "kunta_1_20210101_103", "kunta_1_20210101_105",
                                                           "kunta_1_20210101_106", "kunta_1_20210101_108", "kunta_1_20210101_109",
                                                           "kunta_1_20210101_111", "kunta_1_20210101_139", "kunta_1_20210101_140",
                                                           "kunta_1_20210101_142", "kunta_1_20210101_143", "kunta_1_20210101_145",
                                                           "kunta_1_20210101_146", "kunta_1_20210101_148", "kunta_1_20210101_149",
                                                           "kunta_1_20210101_151", "kunta_1_20210101_152", "kunta_1_20210101_153",
                                                           "kunta_1_20210101_165", "kunta_1_20210101_167", "kunta_1_20210101_169",
                                                           "kunta_1_20210101_170", "kunta_1_20210101_171", "kunta_1_20210101_172",
                                                           "kunta_1_20210101_176", "kunta_1_20210101_177", "kunta_1_20210101_178",
                                                           "kunta_1_20210101_179", "kunta_1_20210101_181", "kunta_1_20210101_182",
                                                           "kunta_1_20210101_186", "kunta_1_20210101_202", "kunta_1_20210101_204",
                                                           "kunta_1_20210101_205", "kunta_1_20210101_208", "kunta_1_20210101_211",
                                                           "kunta_1_20210101_213", "kunta_1_20210101_214", "kunta_1_20210101_216",
                                                           "kunta_1_20210101_217", "kunta_1_20210101_218", "kunta_1_20210101_224",
                                                           "kunta_1_20210101_226", "kunta_1_20210101_230", "kunta_1_20210101_231",
                                                           "kunta_1_20210101_232", "kunta_1_20210101_233", "kunta_1_20210101_235",
                                                           "kunta_1_20210101_236", "kunta_1_20210101_239", "kunta_1_20210101_240",
                                                           "kunta_1_20210101_241", "kunta_1_20210101_244", "kunta_1_20210101_245",
                                                           "kunta_1_20210101_249", "kunta_1_20210101_250", "kunta_1_20210101_256",
                                                           "kunta_1_20210101_257", "kunta_1_20210101_260", "kunta_1_20210101_261",
                                                           "kunta_1_20210101_263", "kunta_1_20210101_265", "kunta_1_20210101_271",
                                                           "kunta_1_20210101_272", "kunta_1_20210101_273", "kunta_1_20210101_275",
                                                           "kunta_1_20210101_276", "kunta_1_20210101_280", "kunta_1_20210101_284",
                                                           "kunta_1_20210101_285", "kunta_1_20210101_286", "kunta_1_20210101_287",
                                                           "kunta_1_20210101_288", "kunta_1_20210101_290", "kunta_1_20210101_291",
                                                           "kunta_1_20210101_295", "kunta_1_20210101_297", "kunta_1_20210101_300",
                                                           "kunta_1_20210101_301", "kunta_1_20210101_304", "kunta_1_20210101_305",
                                                           "kunta_1_20210101_309", "kunta_1_20210101_312", "kunta_1_20210101_316",
                                                           "kunta_1_20210101_317", "kunta_1_20210101_318", "kunta_1_20210101_320",
                                                           "kunta_1_20210101_322", "kunta_1_20210101_398", "kunta_1_20210101_399",
                                                           "kunta_1_20210101_400", "kunta_1_20210101_402", "kunta_1_20210101_403",
                                                           "kunta_1_20210101_405", "kunta_1_20210101_407", "kunta_1_20210101_408",
                                                           "kunta_1_20210101_410", "kunta_1_20210101_416", "kunta_1_20210101_417",
                                                           "kunta_1_20210101_418", "kunta_1_20210101_420", "kunta_1_20210101_421",
                                                           "kunta_1_20210101_422", "kunta_1_20210101_423", "kunta_1_20210101_425",
                                                           "kunta_1_20210101_426", "kunta_1_20210101_430", "kunta_1_20210101_433",
                                                           "kunta_1_20210101_434", "kunta_1_20210101_435", "kunta_1_20210101_436",
                                                           "kunta_1_20210101_438", "kunta_1_20210101_440", "kunta_1_20210101_441",
                                                           "kunta_1_20210101_444", "kunta_1_20210101_445", "kunta_1_20210101_475",
                                                           "kunta_1_20210101_478", "kunta_1_20210101_480", "kunta_1_20210101_481",
                                                           "kunta_1_20210101_483", "kunta_1_20210101_484", "kunta_1_20210101_489",
                                                           "kunta_1_20210101_491", "kunta_1_20210101_494", "kunta_1_20210101_495",
                                                           "kunta_1_20210101_498", "kunta_1_20210101_499", "kunta_1_20210101_500",
                                                           "kunta_1_20210101_503", "kunta_1_20210101_504", "kunta_1_20210101_505",
                                                           "kunta_1_20210101_507", "kunta_1_20210101_508", "kunta_1_20210101_529",
                                                           "kunta_1_20210101_531", "kunta_1_20210101_535", "kunta_1_20210101_536",
                                                           "kunta_1_20210101_538", "kunta_1_20210101_541", "kunta_1_20210101_543",
                                                           "kunta_1_20210101_545", "kunta_1_20210101_560", "kunta_1_20210101_561",
                                                           "kunta_1_20210101_562", "kunta_1_20210101_563", "kunta_1_20210101_564",
                                                           "kunta_1_20210101_576", "kunta_1_20210101_577", "kunta_1_20210101_578",
                                                           "kunta_1_20210101_580", "kunta_1_20210101_581", "kunta_1_20210101_583",
                                                           "kunta_1_20210101_584", "kunta_1_20210101_588", "kunta_1_20210101_592",
                                                           "kunta_1_20210101_593", "kunta_1_20210101_595", "kunta_1_20210101_598",
                                                           "kunta_1_20210101_599", "kunta_1_20210101_601", "kunta_1_20210101_604",
                                                           "kunta_1_20210101_607", "kunta_1_20210101_608", "kunta_1_20210101_609",
                                                           "kunta_1_20210101_611", "kunta_1_20210101_614", "kunta_1_20210101_615",
                                                           "kunta_1_20210101_616", "kunta_1_20210101_619", "kunta_1_20210101_620",
                                                           "kunta_1_20210101_623", "kunta_1_20210101_624", "kunta_1_20210101_625",
                                                           "kunta_1_20210101_626", "kunta_1_20210101_630", "kunta_1_20210101_631",
                                                           "kunta_1_20210101_635", "kunta_1_20210101_636", "kunta_1_20210101_638",
                                                           "kunta_1_20210101_678", "kunta_1_20210101_680", "kunta_1_20210101_681",
                                                           "kunta_1_20210101_683", "kunta_1_20210101_684", "kunta_1_20210101_686",
                                                           "kunta_1_20210101_687", "kunta_1_20210101_689", "kunta_1_20210101_691",
                                                           "kunta_1_20210101_694", "kunta_1_20210101_697", "kunta_1_20210101_698",
                                                           "kunta_1_20210101_700", "kunta_1_20210101_702", "kunta_1_20210101_704",
                                                           "kunta_1_20210101_707", "kunta_1_20210101_710", "kunta_1_20210101_729",
                                                           "kunta_1_20210101_732", "kunta_1_20210101_734", "kunta_1_20210101_736",
                                                           "kunta_1_20210101_738", "kunta_1_20210101_739", "kunta_1_20210101_740",
                                                           "kunta_1_20210101_742", "kunta_1_20210101_743", "kunta_1_20210101_746",
                                                           "kunta_1_20210101_747", "kunta_1_20210101_748", "kunta_1_20210101_749",
                                                           "kunta_1_20210101_751", "kunta_1_20210101_753", "kunta_1_20210101_755",
                                                           "kunta_1_20210101_758", "kunta_1_20210101_759", "kunta_1_20210101_761",
                                                           "kunta_1_20210101_762", "kunta_1_20210101_765", "kunta_1_20210101_766",
                                                           "kunta_1_20210101_768", "kunta_1_20210101_771", "kunta_1_20210101_777",
                                                           "kunta_1_20210101_778", "kunta_1_20210101_781", "kunta_1_20210101_783",
                                                           "kunta_1_20210101_785", "kunta_1_20210101_790", "kunta_1_20210101_791",
                                                           "kunta_1_20210101_831", "kunta_1_20210101_832", "kunta_1_20210101_833",
                                                           "kunta_1_20210101_834", "kunta_1_20210101_837", "kunta_1_20210101_844",
                                                           "kunta_1_20210101_845", "kunta_1_20210101_846", "kunta_1_20210101_848",
                                                           "kunta_1_20210101_849", "kunta_1_20210101_850", "kunta_1_20210101_851",
                                                           "kunta_1_20210101_853", "kunta_1_20210101_854", "kunta_1_20210101_857",
                                                           "kunta_1_20210101_858", "kunta_1_20210101_859", "kunta_1_20210101_886",
                                                           "kunta_1_20210101_887", "kunta_1_20210101_889", "kunta_1_20210101_890",
                                                           "kunta_1_20210101_892", "kunta_1_20210101_893", "kunta_1_20210101_895",
                                                           "kunta_1_20210101_905", "kunta_1_20210101_908", "kunta_1_20210101_915",
                                                           "kunta_1_20210101_918", "kunta_1_20210101_921", "kunta_1_20210101_922",
                                                           "kunta_1_20210101_924", "kunta_1_20210101_925", "kunta_1_20210101_927",
                                                           "kunta_1_20210101_931", "kunta_1_20210101_934", "kunta_1_20210101_935",
                                                           "kunta_1_20210101_936", "kunta_1_20210101_941", "kunta_1_20210101_946",
                                                           "kunta_1_20210101_976", "kunta_1_20210101_977", "kunta_1_20210101_980",
                                                           "kunta_1_20210101_981", "kunta_1_20210101_989", "kunta_1_20210101_992",
                                                           "maakunta_1_20210101_01", "maakunta_1_20210101_02", "maakunta_1_20210101_04",
                                                           "maakunta_1_20210101_05", "maakunta_1_20210101_06", "maakunta_1_20210101_07",
                                                           "maakunta_1_20210101_08", "maakunta_1_20210101_09", "maakunta_1_20210101_10",
                                                           "maakunta_1_20210101_11", "maakunta_1_20210101_12", "maakunta_1_20210101_13",
                                                           "maakunta_1_20210101_14", "maakunta_1_20210101_15", "maakunta_1_20210101_16",
                                                           "maakunta_1_20210101_17", "maakunta_1_20210101_18", "maakunta_1_20210101_19",
                                                           "maakunta_1_20210101_21", "seutukunta_1_20210101_011", "seutukunta_1_20210101_014",
                                                           "seutukunta_1_20210101_015", "seutukunta_1_20210101_016", "seutukunta_1_20210101_021",
                                                           "seutukunta_1_20210101_022", "seutukunta_1_20210101_023", "seutukunta_1_20210101_024",
                                                           "seutukunta_1_20210101_025", "seutukunta_1_20210101_041", "seutukunta_1_20210101_043",
                                                           "seutukunta_1_20210101_044", "seutukunta_1_20210101_051", "seutukunta_1_20210101_052",
                                                           "seutukunta_1_20210101_053", "seutukunta_1_20210101_061", "seutukunta_1_20210101_063",
                                                           "seutukunta_1_20210101_064", "seutukunta_1_20210101_068", "seutukunta_1_20210101_069",
                                                           "seutukunta_1_20210101_071", "seutukunta_1_20210101_081", "seutukunta_1_20210101_082",
                                                           "seutukunta_1_20210101_091", "seutukunta_1_20210101_093", "seutukunta_1_20210101_101",
                                                           "seutukunta_1_20210101_103", "seutukunta_1_20210101_105", "seutukunta_1_20210101_111",
                                                           "seutukunta_1_20210101_112", "seutukunta_1_20210101_113", "seutukunta_1_20210101_114",
                                                           "seutukunta_1_20210101_115", "seutukunta_1_20210101_122", "seutukunta_1_20210101_124",
                                                           "seutukunta_1_20210101_125", "seutukunta_1_20210101_131", "seutukunta_1_20210101_132",
                                                           "seutukunta_1_20210101_133", "seutukunta_1_20210101_134", "seutukunta_1_20210101_135",
                                                           "seutukunta_1_20210101_138", "seutukunta_1_20210101_141", "seutukunta_1_20210101_142",
                                                           "seutukunta_1_20210101_144", "seutukunta_1_20210101_146", "seutukunta_1_20210101_152",
                                                           "seutukunta_1_20210101_153", "seutukunta_1_20210101_154", "seutukunta_1_20210101_161",
                                                           "seutukunta_1_20210101_162", "seutukunta_1_20210101_171", "seutukunta_1_20210101_173",
                                                           "seutukunta_1_20210101_174", "seutukunta_1_20210101_175", "seutukunta_1_20210101_176",
                                                           "seutukunta_1_20210101_177", "seutukunta_1_20210101_178", "seutukunta_1_20210101_181",
                                                           "seutukunta_1_20210101_182", "seutukunta_1_20210101_191", "seutukunta_1_20210101_192",
                                                           "seutukunta_1_20210101_193", "seutukunta_1_20210101_194", "seutukunta_1_20210101_196",
                                                           "seutukunta_1_20210101_197", "seutukunta_1_20210101_211", "seutukunta_1_20210101_212",
                                                           "seutukunta_1_20210101_213", "suuralue_1_20210101_1", "suuralue_1_20210101_2",
                                                           "suuralue_1_20210101_3", "suuralue_1_20210101_4", "suuralue_1_20210101_5"
  ), tessellation = c("avi", "avi", "avi", "avi", "avi", "avi",
                      "avi", "ely", "ely", "ely", "ely", "ely", "ely", "ely", "ely",
                      "ely", "ely", "ely", "ely", "ely", "ely", "ely", "ely", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "kunta", "kunta", "kunta", "kunta", "kunta", "kunta", "kunta",
                      "maakunta", "maakunta", "maakunta", "maakunta", "maakunta", "maakunta",
                      "maakunta", "maakunta", "maakunta", "maakunta", "maakunta", "maakunta",
                      "maakunta", "maakunta", "maakunta", "maakunta", "maakunta", "maakunta",
                      "maakunta", "seutukunta", "seutukunta", "seutukunta", "seutukunta",
                      "seutukunta", "seutukunta", "seutukunta", "seutukunta", "seutukunta",
                      "seutukunta", "seutukunta", "seutukunta", "seutukunta", "seutukunta",
                      "seutukunta", "seutukunta", "seutukunta", "seutukunta", "seutukunta",
                      "seutukunta", "seutukunta", "seutukunta", "seutukunta", "seutukunta",
                      "seutukunta", "seutukunta", "seutukunta", "seutukunta", "seutukunta",
                      "seutukunta", "seutukunta", "seutukunta", "seutukunta", "seutukunta",
                      "seutukunta", "seutukunta", "seutukunta", "seutukunta", "seutukunta",
                      "seutukunta", "seutukunta", "seutukunta", "seutukunta", "seutukunta",
                      "seutukunta", "seutukunta", "seutukunta", "seutukunta", "seutukunta",
                      "seutukunta", "seutukunta", "seutukunta", "seutukunta", "seutukunta",
                      "seutukunta", "seutukunta", "seutukunta", "seutukunta", "seutukunta",
                      "seutukunta", "seutukunta", "seutukunta", "seutukunta", "seutukunta",
                      "seutukunta", "seutukunta", "seutukunta", "seutukunta", "seutukunta",
                      "suuralue", "suuralue", "suuralue", "suuralue", "suuralue")), row.names = c(NA,
                                                                                                  -425L), class = "data.frame")

  tessellation_query <- tessellation_df[tessellation_df$tessellation == tessellation,]$areaStatisticalUnit_inspireId_localId
  tessellation_query <- gsub("2021", year+1, tessellation_query)

  queries <- paste0("?f=json",
                    "&limit=",limit,
                    "&areaStatisticalUnit_inspireId_localId=",tessellation_query
                    )

  if (!is.null(bbox)){
    queries <- paste0(queries,"&bbox=",bbox)
  }
  # if (!is.null(size)){
  #   queries <- paste0(queries, "&size=", size)
  # }

  # Set the user agent
  ua <- httr::user_agent("https://github.com/rOpenGov/geofi")
  # Construct the query URL
  urls <- paste0(base_url, queries)

  query_geocode <- function(x, query_ua = ua, crs1=output_crs){
    # Get the response and check the response.
    resp <- httpcache::GET(x, query_ua)

    if (httr::http_error(resp)) {
      status_code <- httr::status_code(resp)
      stop(
        sprintf(
          "OGC API %s request failed\n[%s]",
          paste(x),
          httr::http_status(status_code)$message#,
        ),
        call. = FALSE
      )
    }
    resp_sf <- suppressMessages(sf::st_read(resp, quiet = TRUE))
    if (nrow(resp_sf) == 0){
      return()
    } else {
      # resp_sf$query <- x
      resp_sf <- resp_sf |>
        select(areaStatisticalUnit_inspireId_localId,statisticalDistribution_inspireId_localId,value) |>
        dplyr::mutate(statisticalDistribution_inspireId_localId = gsub("^.+_pd_|_[0-9]{4}$", "", statisticalDistribution_inspireId_localId)) |>
        tidyr::pivot_wider(names_from = "statisticalDistribution_inspireId_localId", values_from = "value")
      return(resp_sf)
    }
  }
  print(paste0("Requesting data from: ", urls))
  dat <- lapply(urls, query_geocode) |> do.call("bind_rows", .)
  return(dat)
}

# ff <- get_ogc_municipalities_pop(year = 2021,
#                                  tessellation = "avi",
#                                  # scale = 4500,
#                                  output_crs = 3067,
#                                  limit = 1000)
# ggplot(ff) + geom_sf(aes(fill = male_percentage))


fetch_ogc_api <- function(api_url = "https://geo.stat.fi/inspire/ogc/api/pd/collections/StatisticalValue_by_StatisticalGridCell_RES_5000m_EPSG_3067_2019/items?f=json&limit=10000"){

  next_exists <- TRUE
  i <- 1
  data_list <- list()
  while (next_exists) {
    print(paste("Requesting query nr.", i, "from:", api_url))
    req <- httr2::request(api_url)
    resp <- httr2::req_perform(req)
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
  # dim(all_features)
  return(all_features)

}




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
get_ogc_statistical_grid <- function(year = 2021,
                                     resolution = 5000,
                                     output_crs = 3067,
                                     bbox=NULL) {

  if (!output_crs %in% c(3067, 4326)){
    stop("output_crs must be one of '3067','4326'")
  }
  if (!year %in% c(2019:2021)){
    stop("output_crs must be one of '2019','2020','2021'")
  }
  if (!resolution %in% c(5000,1000)){
    stop("resolution must be one of '5000','1000'")
  }


  # if (output_crs == 3067){
    collection <- paste0("StatisticalValue_by_StatisticalGridCell_RES_",resolution,"m_EPSG_",output_crs,"_",year,"/items?f=json&limit=10000")
  # } else if (output_crs == 4326){
    # collection <- paste0("StatisticalValue_by_AreaStatisticalUnit_4500k_EPSG_4326_",year,"/items")
  # }
    if (!is.null(bbox)){
      collection <- paste0(collection,"&bbox=",bbox)
    }


  # StatisticalValue_by_StatisticalGridCell_RES_5000m_EPSG_3067_2019
  # https://geo.stat.fi/inspire/ogc/api/pd/collections/StatisticalValue_by_StatisticalGridCell_RES_5000m_EPSG_3067_2019/items?f=json

  base_url = paste0("https://geo.stat.fi/inspire/ogc/api/pd/collections/",collection)

  all_features <- fetch_ogc_api(api_url = base_url)

  resp_sf <- all_features |>
    dplyr::select(statisticalGridCell_statisticalGrid_inspireId_localId,statisticalDistribution_inspireId_localId ,value) |>
    dplyr::mutate(statisticalDistribution_inspireId_localId = gsub("^.+_pd_|_[0-9]{4}$", "", statisticalDistribution_inspireId_localId)) |>
    tidyr::pivot_wider(names_from = "statisticalDistribution_inspireId_localId", values_from = "value")


  # # Set the user agent
  # ua <- httr::user_agent("https://github.com/rOpenGov/geofi")
  # # Construct the query URL
  # urls <- paste0(base_url, queries)
  #
  # query_geocode <- function(x, query_ua = ua, crs1=output_crs){
  #   # Get the response and check the response.
  #   resp <- httpcache::GET(x, query_ua)
  #
  #   if (httr::http_error(resp)) {
  #     status_code <- httr::status_code(resp)
  #     stop(
  #       sprintf(
  #         "OGC API %s request failed\n[%s]",
  #         paste(x),
  #         httr::http_status(status_code)$message#,
  #       ),
  #       call. = FALSE
  #     )
  #   }
  #   resp_sf <- suppressMessages(sf::st_read(resp, quiet = TRUE))
  #   if (nrow(resp_sf) == 0){
  #     return()
  #   } else {
  #     # resp_sf$query <- x
  #     resp_sf <- resp_sf |>
  #       select(areaStatisticalUnit_inspireId_localId,statisticalDistribution_inspireId_localId,value) %>%
  #       dplyr::mutate(statisticalDistribution_inspireId_localId = gsub("^.+_pd_|_[0-9]{4}$", "", statisticalDistribution_inspireId_localId)) |>
  #       tidyr::pivot_wider(names_from = "statisticalDistribution_inspireId_localId", values_from = "value")
  #     return(resp_sf)
  #   }
  # }
  # print(paste0("Requesting data from: ", urls))
  # dat <- lapply(urls, query_geocode) %>% do.call("bind_rows", .)
  return(resp_sf)
}

helsinki <- geofi::get_municipalities() |>
  dplyr::filter(municipality_code == 91) |>
  sf::st_transform(4326)
helsinki_bbox <- paste0(sf::st_bbox(helsinki),collapse = ",")

lappi <- get_ogc_municipalities(tessellation = "maakunta", output_crs = 4326) |>
  dplyr::filter(geographicalName_fin == "Lappi")
lappi_bbox <- paste0(sf::st_bbox(lappi),collapse = ",")



grid5000 <- get_ogc_statistical_grid(resolution = 1000,
                                     bbox = paste0()
mapview::mapview(grid5000)

grid1000 <- get_ogc_statistical_grid(resolution = 1000)

get_ogc_municipalities_pop(bbox = lappi_bbox)




