# geofi (development version)

# CHANGES IN VERSION 1.0.2 (2021-07-06)

- examples in vignettes that use pxweb-data from Statistical Finland fixed to match the changed data structure
- http -> https changes in documentation urls


# CHANGES IN VERSION 1.0.1 (2021-03-29)

- duplicated municipalities removed from municipality keys from year 2016
- tricolore_tutorial.Rmd vignette now provides a proper method for producing the final map


## CHANGES IN VERSION 1.0.0 (2021-02-18)

- first CRAN release
- compatibility with 2021 mucipality and zipcode divide
- new onboard dataset of municipality central locations as `municipality_central_localities`
- api tests compatible with httptest v4.0.0
- vignettes restructured

# CHANGES IN VERSION 0.1 (2019-08-08)

- Reboot of `gisfin`, package renamed to `geofi`.

## New features

- All WFSs (provider, URL, version) are now listed in 
  `inst/extdata/wfs_providers.yaml`. This separation of data and code hopefully
  makes it easier to manage the data and to use it consistently in different 
  parts of the package (e.g. actual code and tests). Package internally, these
  data are parsed to an environment `wfs_providers`.
- `get_municipalities()` and `get_zipcodes()` can now pass extra-arguments 
  (`...`) to underlying `get_wfs_layer()`. 
- Basic testing harness is in place using `testthat` and `httptest`.

## Development related

- Municipal key rda files in `data` dir are now saved with `compress = "bzip2"`
  to reduce the size of the rda files.
- Decreased version number down to 0.1.0.9004 as this is a new package now.
- Decreased R version requirement to 3.5.0 as check was complaining about the
  previous version number (3.5.2).
- DESCRIPTION now defines `knitr` as the VignetteEngine for the package.
