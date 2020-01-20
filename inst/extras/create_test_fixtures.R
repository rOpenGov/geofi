library(geofi)
library(httptest)

.mockPaths("tests/testthat")
# 
# # test-01-wfs.R -------------------------------------------------------------

# Define a test WFS (Statistics Finland)
wfs_url <- geofi:::wfs_providers$Tilastokeskus$URL
wfs_version <- geofi:::wfs_providers$Tilastokeskus$version
wfs_layer <- paste0("tilastointialueet:kunta", 4500, "k_", 2019)

base_queries <- list("service" = "WFS", "version" = wfs_version)
queries <- append(base_queries, list(request = "getFeature", typename = wfs_layer))

httptest::start_capturing()
wfs_api(base_url = wfs_url, queries)
httptest::stop_capturing()
# 
# # test-02-statfi.R --------------------------------------------------------
# 
httptest::start_capturing()
get_municipalities(year = 2016, scale = 4500)
get_zipcodes(year = 2017)
httptest::stop_capturing()
