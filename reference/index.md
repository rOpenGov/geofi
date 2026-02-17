# Package index

## Statistics Finland API functions

Functions for using Statistics Finland WFS and OGC API features services

- [`get_municipalities()`](https://ropengov.github.io/geofi/reference/get_municipalities.md)
  : Get Finnish municipality (multi)polygons for different years and/or
  scales.

- [`get_zipcodes()`](https://ropengov.github.io/geofi/reference/get_zipcodes.md)
  : Get Finnish zip code (multi)polygons for different years.

- [`get_population_grid()`](https://ropengov.github.io/geofi/reference/get_population_grid.md)
  :

  Get Finnish Population grid in two different resolutions for years
  2010-2022 Thin wrapper around Finnish population grid data provided by
  [Statistics
  Finland](https://stat.fi/org/avoindata/paikkatietoaineistot/vaestoruutuaineisto_1km_en.html).

- [`get_statistical_grid()`](https://ropengov.github.io/geofi/reference/get_statistical_grid.md)
  : Get Statistical grid data polygons at two different resolution

- [`get_municipality_pop()`](https://ropengov.github.io/geofi/reference/get_municipality_pop.md)
  : Get Number of population by Finnish municipality (multi)polygons for
  different years.

- [`ogc_get_statfi_area()`](https://ropengov.github.io/geofi/reference/ogc_get_statfi_area.md)
  : Retrieve Finnish Administrative Area Polygons

- [`ogc_get_statfi_area_pop()`](https://ropengov.github.io/geofi/reference/ogc_get_statfi_area_pop.md)
  : Retrieve Finnish Administrative Area Polygons with Population Data

- [`ogc_get_statfi_statistical_grid()`](https://ropengov.github.io/geofi/reference/ogc_get_statfi_statistical_grid.md)
  : Retrieve Finnish Statistical Grid with Population Data

## National Land Survey API functions

Functions for using National Land survey OGC API features services

- [`municipality_central_localities()`](https://ropengov.github.io/geofi/reference/municipality_central_localities.md)
  : Get up-to-date municipality central locations
- [`ogc_get_maastotietokanta_collections()`](https://ropengov.github.io/geofi/reference/ogc_get_maastotietokanta_collections.md)
  : Fetch Maastotietokanta Collections
- [`ogc_get_maastotietokanta()`](https://ropengov.github.io/geofi/reference/ogc_get_maastotietokanta.md)
  : Download a Collection from the Maastotietokanta (Topographic
  Database)
- [`ogc_get_nimisto()`](https://ropengov.github.io/geofi/reference/ogc_get_nimisto.md)
  : Query Geographic Names (Nimistö) from the National Land Survey of
  Finland
- [`geocode()`](https://ropengov.github.io/geofi/reference/geocode.md) :
  Geocode Finnish Place Names or Street Addresses
- [`geocode_reverse()`](https://ropengov.github.io/geofi/reference/geocode_reverse.md)
  : Reverse Geocode Geographic Locations into Finnish Place Names or
  Addresses

## Data

geofi comes with a timeseries of built-in municipality keys that can be
used to aggregate municipality level data (`municipality_key_*`) and
`municipality_central_localities` data containing point locations for
cental locality of each municipality

- [`municipality_key`](https://ropengov.github.io/geofi/reference/municipality_key.md)
  : Aggregated municipality key table for years 2013-2025
- [`municipality_key_2025`](https://ropengov.github.io/geofi/reference/municipality_key_2025.md)
  : Municipality key table for 2025
- [`municipality_key_2024`](https://ropengov.github.io/geofi/reference/municipality_key_2024.md)
  : Municipality key table for 2024
- [`municipality_key_2023`](https://ropengov.github.io/geofi/reference/municipality_key_2023.md)
  : Municipality key table for 2023
- [`municipality_key_2022`](https://ropengov.github.io/geofi/reference/municipality_key_2022.md)
  : Municipality key table for 2022
- [`municipality_key_2021`](https://ropengov.github.io/geofi/reference/municipality_key_2021.md)
  : Municipality key table for 2021
- [`municipality_key_2020`](https://ropengov.github.io/geofi/reference/municipality_key_2020.md)
  : Municipality key table for 2020
- [`municipality_key_2019`](https://ropengov.github.io/geofi/reference/municipality_key_2019.md)
  : Municipality key table for 2019
- [`municipality_key_2018`](https://ropengov.github.io/geofi/reference/municipality_key_2018.md)
  : Municipality key table for 2018
- [`municipality_key_2017`](https://ropengov.github.io/geofi/reference/municipality_key_2017.md)
  : municipality_key_2017
- [`municipality_key_2016`](https://ropengov.github.io/geofi/reference/municipality_key_2016.md)
  : municipality_key_2016
- [`municipality_key_2015`](https://ropengov.github.io/geofi/reference/municipality_key_2015.md)
  : municipality_key_2015
- [`municipality_key_2014`](https://ropengov.github.io/geofi/reference/municipality_key_2014.md)
  : municipality_key_2014
- [`municipality_key_2013`](https://ropengov.github.io/geofi/reference/municipality_key_2013.md)
  : municipality_key_2013

## Geofacet grids

geofi comes with a selection of built-in grids to used with
geofacet-packages, a ggplot2 extension. All grids are based on the
latest municipality breakdown

- [`grid_ahvenanmaa`](https://ropengov.github.io/geofi/reference/grid_ahvenanmaa.md)
  : custom geofacet grid for Ahvenanmaa region
- [`grid_etela_karjala`](https://ropengov.github.io/geofi/reference/grid_etela_karjala.md)
  : custom geofacet grid for Etelä-Karjala region as in 2020
- [`grid_etela_pohjanmaa`](https://ropengov.github.io/geofi/reference/grid_etela_pohjanmaa.md)
  : custom geofacet grid for Etelä-Pohjanmaa
- [`grid_etela_savo`](https://ropengov.github.io/geofi/reference/grid_etela_savo.md)
  : custom geofacet grid for Etelä-Savo
- [`grid_hyvinvointialue`](https://ropengov.github.io/geofi/reference/grid_hyvinvointialue.md)
  : custom geofacet grid for Wellbeing services counties
- [`grid_kainuu`](https://ropengov.github.io/geofi/reference/grid_kainuu.md)
  : custom geofacet grid for Kainuu region
- [`grid_kanta_hame`](https://ropengov.github.io/geofi/reference/grid_kanta_hame.md)
  : custom geofacet grid for Kanta-Häme region
- [`grid_keski_pohjanmaa`](https://ropengov.github.io/geofi/reference/grid_keski_pohjanmaa.md)
  : custom geofacet grid for Keski-Pohjanmaa region
- [`grid_keski_suomi`](https://ropengov.github.io/geofi/reference/grid_keski_suomi.md)
  : custom geofacet grid for Keski-Suomi region as in 2020
- [`grid_kymenlaakso`](https://ropengov.github.io/geofi/reference/grid_kymenlaakso.md)
  : custom geofacet grid for Kymenlaakso region
- [`grid_lappi`](https://ropengov.github.io/geofi/reference/grid_lappi.md)
  : custom geofacet grid for Lappi region as in 2020
- [`grid_maakunta`](https://ropengov.github.io/geofi/reference/grid_maakunta.md)
  : custom geofacet grid for regions
- [`grid_paijat_hame`](https://ropengov.github.io/geofi/reference/grid_paijat_hame.md)
  : custom geofacet grid for Päijät-Häme region
- [`grid_pirkanmaa`](https://ropengov.github.io/geofi/reference/grid_pirkanmaa.md)
  : custom geofacet grid for Pirkanmaa region
- [`grid_pohjanmaa`](https://ropengov.github.io/geofi/reference/grid_pohjanmaa.md)
  : custom geofacet grid for Pohjanmaa region
- [`grid_pohjois_karjala`](https://ropengov.github.io/geofi/reference/grid_pohjois_karjala.md)
  : custom geofacet grid for Pohjois-Karjala region
- [`grid_pohjois_pohjanmaa`](https://ropengov.github.io/geofi/reference/grid_pohjois_pohjanmaa.md)
  : custom geofacet grid for Pohjois-Pohjanmaa region
- [`grid_pohjois_savo`](https://ropengov.github.io/geofi/reference/grid_pohjois_savo.md)
  : custom geofacet grid for Pohjois-Savo region
- [`grid_sairaanhoitop`](https://ropengov.github.io/geofi/reference/grid_sairaanhoitop.md)
  : custom geofacet grid for health care districts
- [`grid_satakunta`](https://ropengov.github.io/geofi/reference/grid_satakunta.md)
  : custom geofacet grid for Satakunta region
- [`grid_uusimaa`](https://ropengov.github.io/geofi/reference/grid_uusimaa.md)
  : custom geofacet grid for Uusimaa region
- [`grid_varsinais_suomi`](https://ropengov.github.io/geofi/reference/grid_varsinais_suomi.md)
  : custom geofacet grid for Varsinais-Suomi region

## Attribute data

geofi comes with a three statistical datasets that are used in vignettes

- [`sotkadata_population`](https://ropengov.github.io/geofi/reference/sotkadata_population.md)
  : Municipality level population data from Sotkanet
- [`sotkadata_swedish_speaking_pop`](https://ropengov.github.io/geofi/reference/sotkadata_swedish_speaking_pop.md)
  : Municipality level Swedish speaking population numbers from Sotkanet
- [`statfi_zipcode_population`](https://ropengov.github.io/geofi/reference/statfi_zipcode_population.md)
  : Zipcode level population data from Statistics Finland
- [`municipality_central_localities_df`](https://ropengov.github.io/geofi/reference/municipality_central_localities_df.md)
  : A data frame containing locations of municipalities central
  localities

## Miscellaneous

Support functions for API functions and spatial data transformations

- [`convert_municipality_key_codes()`](https://ropengov.github.io/geofi/reference/convert_municipality_key_codes.md)
  : Convert regional codes in on-board municipality key data sets into
  variable length characters
- [`check_api_access()`](https://ropengov.github.io/geofi/reference/check_api_access.md)
  : Check Access to Statistics Finland Geoserver APIs
- [`wfs_api()`](https://ropengov.github.io/geofi/reference/wfs_api.md) :
  WFS API
- [`to_sf()`](https://ropengov.github.io/geofi/reference/to_sf.md) :
  Transform a wfs_api object into a sf object.
