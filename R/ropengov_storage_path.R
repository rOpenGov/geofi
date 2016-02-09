#' @title ropengov storage path
#' @description Storage path for rOpenGov files.
#' @param ... Arguments to pass
#' @return URL for Louhos data
#' @examples url <- ropengov_storage_path()
#' @export
#' @references
#' See citation("sorvi") 
#' @author Leo Lahti \email{louhos@@googlegroups.com}
#' @keywords utilities
ropengov_storage_path <- function (...) {

  # rOpenGov data is stored in Github avoindata repo: 
  # https://github.com/avoindata/ which is 
  # mirrored on Datavaalit server
  #"http://www.datavaalit.fi/storage/avoindata/"

  # OKF Finland Server is now running daily cron jobs to
  # update the avoindata Github repository
  "http://data.okf.fi/ropengov/avoindata/"
}


