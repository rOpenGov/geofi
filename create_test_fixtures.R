library(gisfin)
library(httptest)

.mockPaths("tests/testthat")

# Define a test WFS (Statistics Finland)
wfs_url <- gisfin:::wfs_providers$Tilastokeskus$URL
wfs_version <- gisfin:::wfs_providers$Tilastokeskus$version
wfs_layer <- paste0("tilastointialueet:kunta", 4500, "k_", 2019)

httptest::start_capturing()
wfs(url = wfs_url, layer = wfs_layer, serviceVersion = wfs_version, 
    logger = NULL)
httptest::stop_capturing()
