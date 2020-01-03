#' @title WFS API
#'
#' @description Requests to various WFS API.
#'
#' @details Make a request to the WFS API. The base url is
#' opendata.fmi.fi/wfs?service=WFS&version=2.0.0 to which other
#' components defined by the arguments are appended.
#'
#' This is a low-level function intended to be used by other higher level
#' functions in the package.
#'
#' Note that GET requests are used using `httpcache` meaning that requests
#' are cached. If you want clear cache, use [httpcache::clearCache()]. To turn
#' the cache off completely, use [httpcache::cacheOff()]
#'
#' @param request character request type of either `DescribeStoredQueries` or
#'        `getFeature`.
#' @param storedquery_id character id of the stored query id. If `request` is
#'        `getFeature`, then `storedquery_id` must be provided and otherwise
#'        it's ignored.
#' @param ... stored query specific parameters. NOTE: it's up to the high-level
#'        functions to check the validity of the parameters.
#'
#' @importFrom httr content http_error http_type modify_url status_code user_agent
#' @importFrom httpcache GET
#' @importFrom xml2 read_xml xml_find_all xml_text
#'
#' @return wfs_api (S3) object with the following attributes:
#'        \describe{
#'           \item{content}{XML payload.}
#'           \item{path}{path provided to get the resonse.}
#'           \item{response}{the original response object.}
#'         }
#'
#' @export
#'
#' @author Joona Lehtomäki <joona.lehtomaki@@iki.fi>
#'
#' @examples
#'   # List stored queries
#'   wfs_api(request = "DescribeStoredQueries")
#'
wfs_api <- function(base_url, request, queries, storedquery_id = NULL, ...) {
  
  if (!request %in% c("DescribeStoredQueries", "getFeature")) {
    stop("Invalid request type: ", request)
  }
  
  # Set the user agent
  ua <- httr::user_agent("https://github.com/rOpenGov/geofi")

  # All arguments contained in ... are used to construct the final URL.
  if (request == "DescribeStoredQueries") {
    if (!is.null(storedquery_id)) {
      warning("storedquery_id ignored as request type is DescribeStoredQueries",
              call. = FALSE)
    }
  } else if (request == "getFeature") {
    # TODO: raise error if storedquery_id is missing
    queries <- append(queries, list(storedquery_id = storedquery_id, ...))
  }
  
  # Construct the query URL
  url <- httr::modify_url(base_url, query = queries)
  
  # Get the response and check the response.
  resp <- httpcache::GET(url, ua)
  
  # Parse the response XML content
  content <- xml2::read_xml(resp$content)
  
  # Strip the namespace as it will be only trouble
  # xml2::xml_ns_strip(content)
  
  if (httr::http_error(resp)) {
    status_code <- httr::status_code(resp)
    # If status code is 400, there might be more information available
    exception_texts <- ""
    if (status_code == 400) {
      exception_texts <- xml2::xml_text(xml2::xml_find_all(content, "//ExceptionText"))
      # Remove URI since full URL is going to be displayed
      exception_texts <- exception_texts[!grepl("^(URI)", exception_texts)]
      exception_texts <- c(exception_texts, paste("URL: ", url))
    }
    stop(
      sprintf(
        "WFS API %s request failed [%s]\n %s",
        paste(url),
        httr::http_status(status_code)$message,
        paste0(exception_texts, collapse = "\n ")
      ),
      call. = FALSE
    )
  }

  api_obj <- structure(
    list(
      url = url,
      response = resp
    ),
    class = "wfs_api"
  )
  
  api_obj$content <- content
  
  if (request == "DescribeStoredQueries") {
    # Get all the child nodes
    nodes <- xml2::xml_children(content)
    # Attach the nodes to the API object
    api_obj$content <- nodes
    # getFeature is used for getting actual data
  } else if (request == "getFeature") {
    # Attach the nodes to the API object
    api_obj$content <- content
  }
  
  return(api_obj)
}
