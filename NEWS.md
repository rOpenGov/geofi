## CHANGES IN VERSION 0.1 (2019-08-XX)

+ Reboot of `gisfin`, package renamed to `geofi`.

### New features

+ All WFSs (provider, URL, version) are now listed in 
  `inst/extdata/wfs_providers.yaml`. This separation of data and code hopefully
  makes it easier to manage the data and to use it consistently in different 
  parts of the package (e.g. actual code and tests). Package internally, these
  data are parsed to an environment `wfs_providers`.
+ `get_municipalities()` and `get_zipcodes()` can now pass extra-arguments 
  (`...`) to underlying `get_wfs_layer()`. 
+ Basic testing harness is in place using `testthat` and `httptest`.

### Development related

+ Municipal key rda files in `data` dir are now saved with `compress = "bzip2"`
  to reduce the size of the rda files.
+ Decreased version number down to 0.1.0.9004 as this is a new package now.
+ Decreased R version requirement to 3.5.0 as check was complaining about the
  previous version number (3.5.2).
+ DESCRIPTION now defines `knitr` as the VignetteEngine for the package.
