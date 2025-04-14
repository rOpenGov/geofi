
# check if PROJ-version is lower than 9.6.0 and assign a logical value
proj_lower_than_960 <- package_version(sf::sf_extSoftVersion()["PROJ"]) < as.package_version("9.6.0")

.onAttach <- function(lib, pkg) {
  #   packageStartupMessage("\ngeofi R package: tools for open GIS data for Finland.\nPart of rOpenGov <ropengov.org>.\n
  # **************\n
  # Please note that the content of variables 'hyvinvointialue_name_*' and 'hyvinvointialue_code' has changed in 1.0.6 release.\nNew content follows the classification by Statistics Finland.\n
  # **************")
  
  
  if (proj_lower_than_960){
    # assign("municipality_central_localities", pkg_env$municipality_central_localities, envir = .GlobalEnv)
    packageStartupMessage("**************\nPROJ-version < 9.6.0 detected.\nCRS of municipality_central_localities changed to ETRS89/TM35FIN(E,N) ESPG:3067 to match user PROJ-version\nPlease look https://github.com/rOpenGov/geofi/blob/master/NEWS.md for more information\n**************")
  }
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
  
  if (!proj_lower_than_960){
    # Load the dataset into the package environment
    utils::data("municipality_central_localities", package = "geofi", envir = pkg_env)
    # Set CRS to 3067 that will vary whether user has PROJ < 9.6.0 or >= 9.6.0
    suppressWarnings(sf::st_crs(pkg_env$municipality_central_localities) <- sf::st_crs("EPSG:3067"))
    # assing the modified data to global environment
    assign("municipality_central_localities", pkg_env$municipality_central_localities, envir = .GlobalEnv)
  }
}
