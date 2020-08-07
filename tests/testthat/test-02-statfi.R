context("Statistics Finland")

httptest::with_mock_api({

  test_that("correct data type is returned for municipalities",{
    skip_on_cran()
    suppressWarnings({sf_obj <- get_municipalities(year = 2016, scale = 4500)})
    expect_is(sf_obj, "sf")
  })
  test_that("correct data type is returned for zipcodes",{
    skip_on_cran()
    suppressWarnings({sf_obj <- get_zipcodes(year = 2017)})
    expect_is(sf_obj, "sf")
  })

})


