context("Statistics Finland")

httptest::with_mock_dir("statfi_responses",{
  
  test_that("correct data type is returned for municipalities",{
    skip_on_cran()
    suppressWarnings({sf_obj <- get_municipalities(year = 2016, scale = 4500)})
    expect_true(is(sf_obj, "sf"))
  })
  test_that("correct data type is returned for zipcodes",{
    skip_on_cran()
    suppressWarnings({sf_obj <- get_zipcodes(year = 2017)})
    expect_true(is(sf_obj, "sf"))
  })

  test_that("correct data type is returned for population grids", {
    skip_on_cran()
    suppressWarnings(sf_obj <- get_population_grid(year = 2017, resolution = 5))
    expect_true(is(sf_obj, "sf"))
  })
  
  test_that("correct data type is returned for statistical grids", {
    skip_on_cran()
    suppressWarnings(sf_obj <- get_statistical_grid(resolution = 5, auxiliary_data = TRUE))
    expect_true(is(sf_obj, "sf"))
  })
})

# httpcache::clearCache()
# remember to also remove subfolder from testthat
# unlink("./tests/testthat/statfi_responses", recursive = TRUE)

