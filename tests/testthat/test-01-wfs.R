context("Basic WFS functionality")

# Define a test WFS (Statistics Finland)
wfs_url <- gisfin:::wfs_providers$Tilastokeskus$URL
wfs_version <- gisfin:::wfs_providers$Tilastokeskus$version
wfs_layer <- paste0("tilastointialueet:kunta", 4500, "k_", 2019)


httptest::with_mock_api({
  test_that("correct data type is returned",{
    sf_obj <- wfs(url = wfs_url, layer = wfs_layer, 
                  serviceVersion = wfs_version, logger = NULL)
    expect_is(sf_obj, "sf")
  })
})


