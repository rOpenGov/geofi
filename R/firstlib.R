
.onAttach <- function(lib, pkg) {
     packageStartupMessage("\ngeofi R package: tools for open GIS data for Finland.\nPart of rOpenGov <ropengov.org>.\n
**************
Changes in version 1.1.0:
- Object `municipality_central_localities` is depracated and replaced with function `municipality_central_localities()`. More at https://github.com/rOpenGov/geofi/blob/master/NEWS.md
- New functions for interacting with both National Land Survey and Statistics Finland OCG API-services. See three new vignettes for examples.
**************")
}

# Create an empty environment to hold the WFS provider data
wfs_providers <- new.env()


#' @importFrom yaml read_yaml
#' @importFrom purrr map2
#' @importFrom sf st_transform

.onLoad <- function(lib, pkg) {

  # Read the WFS providers definition data from YAML file in inst/extdata
  wfs_data <- yaml::read_yaml(system.file("extdata", "wfs_providers.yaml",
                                          package = "geofi"))
  # Map the providers and their data (URL, WFS version) to the environment
  purrr::map2(names(wfs_data), wfs_data, assign, envir = wfs_providers)

}
