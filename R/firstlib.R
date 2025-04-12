
.onAttach <- function(lib, pkg) {
  #   packageStartupMessage("\ngeofi R package: tools for open GIS data for Finland.\nPart of rOpenGov <ropengov.org>.\n
  # **************\n
  # Please note that the content of variables 'hyvinvointialue_name_*' and 'hyvinvointialue_code' has changed in 1.0.6 release.\nNew content follows the classification by Statistics Finland.\n
  # **************")

  # assing the modified data to global environment
  assign("municipality_central_localities", pkg_env$municipality_central_localities, envir = .GlobalEnv)
  packageStartupMessage("CRS in municipality_central_localties updated to match user PROJ-version")
}

# Create an empty environment to hold the WFS provider data
wfs_providers <- new.env()

# Environment to store the modified data
pkg_env <- new.env()
# Set the data NULL in global environment
municipality_central_localities <- NULL

#' @importFrom yaml read_yaml
#' @importFrom purrr map2
#' @importFrom sf st_transform

.onLoad <- function(lib, pkg) {

  # Read the WFS providers definition data from YAML file in inst/extdata
  wfs_data <- yaml::read_yaml(system.file("extdata", "wfs_providers.yaml",
                                          package = "geofi"))
  # Map the providers and their data (URL, WFS version) to the environment
  purrr::map2(names(wfs_data), wfs_data, assign, envir = wfs_providers)

  # Load the dataset into the package environment
  utils::data("municipality_central_localities", package = "geofi", envir = pkg_env)
  # Set CRS to 3067 that will vary whether user has PROJ < 9.6.0 or >= 9.6.0
  pkg_env$municipality_central_localities <- sf::st_transform(pkg_env$municipality_central_localities, 3067)

}
