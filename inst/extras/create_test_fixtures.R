library(geofi)
library(httptest)

# .mockPaths("tests/testthat")
# 
# # test-01-wfs.R -------------------------------------------------------------
# 
# # Define a test WFS (Statistics Finland)
# wfs_url <- geofi:::wfs_providers$Tilastokeskus$URL
# wfs_version <- geofi:::wfs_providers$Tilastokeskus$version
# wfs_layer <- paste0("tilastointialueet:kunta", 4500, "k_", 2019)
# 
# httptest::start_capturing()
# get_wfs_layer(url = wfs_url, layer = wfs_layer, serviceVersion = wfs_version,
#               logger = NULL)
# httptest::stop_capturing()
# 
# # test-02-statfi.R --------------------------------------------------------
# 
# httptest::start_capturing()
# get_municipalities(year = 2016, scale = 4500, logger = NULL)
# get_zipcodes(year = 2017, logger = NULL)
# httptest::stop_capturing()
