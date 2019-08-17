context("Basic WFS functionality")

# Define a test WFS (Statistics Finland)
wfs_url <- geofi:::wfs_providers$Tilastokeskus$URL
wfs_version <- geofi:::wfs_providers$Tilastokeskus$version
wfs_layer <- paste0("tilastointialueet:kunta", 4500, "k_", 2019)


httptest::with_mock_api({
  test_that("correct data type is returned",{
    suppressWarnings(sf_obj <- wfs(url = wfs_url, layer = wfs_layer,
                                   serviceVersion = wfs_version, logger = NULL))
    expect_is(sf_obj, "sf")
  })
  test_that("CRS is coerced correctly",{
    expect_warning(sf_obj <- wfs(url = wfs_url, layer = wfs_layer,
                                 serviceVersion = wfs_version, logger = NULL),
                  "Coercing CRS to")
    suppressWarnings(sf_obj <- wfs(url = wfs_url, layer = wfs_layer,
                     serviceVersion = wfs_version, logger = NULL))
    expect_equal(sf::st_crs(sf_obj)$epsg, 3067)
  })
})


