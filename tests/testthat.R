check_namespaces <- function(pkgs){
  return(all(unlist(sapply(pkgs, requireNamespace,quietly = TRUE))))
}
pkginst <- check_namespaces(c("httptest","httptest"))
if (pkginst){
  library(httptest)
  library(testthat)
  library(geofi)
  test_check("geofi")
}


