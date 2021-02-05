context("Basic WFS functionality1")

# Define a test WFS (Statistics Finland)
wfs_url <- geofi:::wfs_providers$Tilastokeskus$URL
wfs_version <- geofi:::wfs_providers$Tilastokeskus$version
wfs_layer <- paste0("tilastointialueet:kunta", 4500, "k_", 2020)

base_queries <- list("service" = "WFS", "version" = wfs_version)
queries <- append(base_queries, list(request = "getFeature", typename = wfs_layer))

test_that("WFS API object is correctly created", {
  expect_error(wfs_api(base_url = "foobar", queries = "foobar"),
               "^Invalid base URL")
})

httptest::with_mock_dir("wfs_responses",{
  test_that("WFS API object is correctly created", {
    skip_on_cran()
    expect_true(is(wfs_api(base_url = wfs_url, queries), "wfs_api"))
  })
})

# clearCache() might is needed when generating new mock files
# using different year to make sure mock test points to a different file

wfs_layer <- paste0("tilastointialueet:kunta", 4500, "k_", 2019)
queries <- append(base_queries, list(request = "getFeature", 
                                     typename = wfs_layer))

# Modified response with $response$status_code changed to 400L
httptest::with_mock_dir("wfs_modified_responses",{
  test_that("WFS API object is correctly created", {
    skip_on_cran()
    expect_error(wfs_api(base_url = "http://geo.stat.fi/geoserver/wfs", 
                         queries = queries))
  })
})

# httpcache::clearCache()
# unlink("./tests/testthat/wfs_modified_responses", recursive = TRUE)
# unlink("./tests/testthat/wfs_responses", recursive = TRUE)