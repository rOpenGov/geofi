context("Basic WFS functionality")

# Define a test WFS (Statistics Finland)
wfs_url <- geofi:::wfs_providers$Tilastokeskus$URL
wfs_version <- geofi:::wfs_providers$Tilastokeskus$version
wfs_layer <- paste0("tilastointialueet:kunta", 4500, "k_", 2019)


httptest::with_mock_api({
  test_that("WFS API object is correctly created", {
    expect_error(wfs_api(base_url = "foobar", queries = "foobar"),
                 "^Invalid base URL")
    expect_is(wfs_api(base_url = "http://geo.stat.fi/geoserver/wfs", 
                      queries = append(list("service" = "WFS", "version" = "1.0.0"), 
                                       list(request = "getFeature", 
                                            typename = "tilastointialueet:kunta4500k_2019"))), 
              "wfs_api")
    # This should work
    expect_is(wfs_api(base_url = "http://geo.stat.fi/geoserver/wfs", 
                      queries = append(list("service" = "WFS", "version" = "1.0.0"), 
                                       list(request = "getFeature", 
                                            typename = "tilastointialueet:kunta4500k_2019"))), 
              "wfs_api")
  })
  
  # test_that("CRS is coerced correctly",{
  #   expect_warning(sf_obj <- get_wfs_layer(url = wfs_url, layer = wfs_layer,
  #                                          serviceVersion = wfs_version,
  #                                          logger = NULL),
  #                 "Coercing CRS to")
  #   suppressWarnings(sf_obj <- get_wfs_layer(url = wfs_url, layer = wfs_layer,
  #                                            serviceVersion = wfs_version,
  #                                            logger = NULL))
  #   expect_equal(sf::st_crs(sf_obj)$epsg, 3067)
  # })
})


