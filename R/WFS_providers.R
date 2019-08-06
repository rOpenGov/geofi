# Create an empty environment to hold the WFS provider data
wfs_providers <- new.env()
# Read the WFS providers definition data from YAML file in inst/extdata
wfs_data <- yaml::read_yaml(system.file("extdata", "wfs_providers.yaml",
                            package = "geofi"))
# Map the providers and their data (URL, WFS version) to the environment
purrr::map2(names(wfs_data), wfs_data, assign, envir = wfs_providers)
