# Changelog

## geofi 1.1.0

CRAN release: 2025-04-29

- Object `municipality_central_localities` is depracated and replaced
  with function
  [`municipality_central_localities()`](https://ropengov.github.io/geofi/reference/municipality_central_localities.md).
  Relates to changes in latest PROJ version 9.6.0 regarding added
  support for EUREF-FIN in Finish transformations
  <https://lists.osgeo.org/pipermail/proj/2025-March/011738.html>
- New functions for interacting both with National Land Survey and
  Statistics Finland OCG API-services. See three new vignettes for
  examples.

## geofi 1.0.18

CRAN release: 2025-02-11

- 2025 regional classifications updated to match with latest changes in
  stat.fi classification API

## geofi 1.0.17

CRAN release: 2024-11-22

- Municipality keys updated to match Kela current classification

## geofi 1.0.16

CRAN release: 2024-08-19

- Municipality keys updated to match with latest changes in stat.fi
  classification API

## geofi 1.0.15

CRAN release: 2024-03-13

- Attibute datasets previously downloaded from internet, now included
  with package

## geofi 1.0.14

CRAN release: 2024-02-05

- 2024 regional classifications updated.
- geofi_joining_attribute_data vignette fixed

## geofi 1.0.12

- pxweb removed from suggested packages list.
- WFS api url fixed in Description

## geofi 1.0.11

CRAN release: 2023-12-18

- Vignettes made more robust agains missing suggested dependencies

## geofi 1.0.10

CRAN release: 2023-11-01

- convert_municipality_key_codes-function fixed, thanks
  [@pitkant](https://github.com/pitkant)
- Examples in vignettes that use pxweb-data from Statistical Finland
  changed to use Sotkanet instead due to more stable api

## geofi 1.0.9

CRAN release: 2023-04-16

- 2023 regional classifications updated. Two classifications: University
  Hospital specific catchment area (Erva-alue) and Hospital District
  (sairaanhoitopiirit) dropped as they are no longer operation but
  replaced with wellbeing service counties (hyvinvointialueet)

## geofi 1.0.8

CRAN release: 2023-02-16

- Links in vignettes pointing to Statistics Finland database updated to
  match new naming scheme.

## geofi 1.0.7

CRAN release: 2022-10-23

- Links in vignettes pinting to Statistics Finland database that started
  with `pxnet2.stat.fi` changed to start with `pxdata.stat.fi` to match
  stat.fi new naming scheme.

## geofi 1.0.6

CRAN release: 2022-01-30

- The content of variables in municipality keys related to
  hyvinvointialue (Wellbeing Service Counties) is changed and matches
  now the classification by Statistics Finland
- New function
  [`get_municipality_pop()`](https://ropengov.github.io/geofi/reference/get_municipality_pop.md)
  added for getting population numbers with spatial data of Finnish
  municipalities from years 2010-2020
- Function
  [`get_zipcodes()`](https://ropengov.github.io/geofi/reference/get_zipcodes.md)
  has a new argument `extend_to_sea_areas` in case you need spatial data
  the extend further than the coastline

## geofi 1.0.5

CRAN release: 2021-10-30

- English names for wellbeing services counties corrected
- New ropengov template added for website

## geofi 1.0.4

CRAN release: 2021-08-18

- new regional classification: upcoming Wellbeing services counties,
  added to municipality keys files

## geofi 1.0.3

CRAN release: 2021-07-01

- new convert_municipality_key_codes-function that can be used convert
  regional codes in on-board municipality key data sets into variable
  width characters as originally provided by Statistics Finland
- new codes_as_characters argument added to get_municipalities-function
  that uses convert_municipality_key_codes-function to convert region
  codes to characters of variable widths. Defaults in FALSE
- examples in vignettes that use suggested package now conditional to
  availability of a package
- tricolore vignette removed due to complex dependencies

## geofi 1.0.2

CRAN release: 2021-06-07

- examples in vignettes that use pxweb-data from Statistical Finland
  fixed to match the changed data structure
- http -\> https changes in documentation urls

## geofi 1.0.1

CRAN release: 2021-03-29

- duplicated municipalities removed from municipality keys from year
  2016
- tricolore_tutorial.Rmd vignette now provides a proper method for
  producing the final map

## geofi 1.0.0

CRAN release: 2021-02-25

- first CRAN release
- compatibility with 2021 mucipality and zipcode divide
- new onboard dataset of municipality central locations as
  `municipality_central_localities`
- api tests compatible with httptest v4.0.0
- vignettes restructured

## geofi 0.1 (development version)

- Reboot of `gisfin`, package renamed to `geofi`.

### New features

- All WFSs (provider, URL, version) are now listed in
  `inst/extdata/wfs_providers.yaml`. This separation of data and code
  hopefully makes it easier to manage the data and to use it
  consistently in different parts of the package (e.g. actual code and
  tests). Package internally, these data are parsed to an environment
  `wfs_providers`.
- [`get_municipalities()`](https://ropengov.github.io/geofi/reference/get_municipalities.md)
  and
  [`get_zipcodes()`](https://ropengov.github.io/geofi/reference/get_zipcodes.md)
  can now pass extra-arguments (`...`) to underlying `get_wfs_layer()`.
- Basic testing harness is in place using `testthat` and `httptest`.

### Development related

- Municipal key rda files in `data` dir are now saved with
  `compress = "bzip2"` to reduce the size of the rda files.
- Decreased version number down to 0.1.0.9004 as this is a new package
  now.
- Decreased R version requirement to 3.5.0 as check was complaining
  about the previous version number (3.5.2).
- DESCRIPTION now defines `knitr` as the VignetteEngine for the package.
