# Get Finnish municipality (multi)polygons for different years and/or scales.

Thin wrapper around Finnish zip code areas provided by [Statistics
Finland](https://stat.fi/en/services/statistical-data-services/geographic-data/statistical-areas/municipality-based-statistical-units).

## Usage

``` r
get_municipalities(year = 2026, scale = 4500, codes_as_character = FALSE)
```

## Arguments

- year:

  A numeric for year of the administrative borders. Available are 2013,
  2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023, 2024, 2025
  and 2026.

- scale:

  A scale or resolution of the shape. Two options: `1000` equals 1:1 000
  000 and `4500` equals 1:4 500 000.

- codes_as_character:

  A logical determining if the region codes should be returned as
  strings of equal width as originally provided by Statistics Finland
  instead of integers.

## Value

sf object

## Author

Markus Kainu <markus.kainu@kela.fi>, Joona Lehtomäki
<joona.lehtomaki@iki.fi>

## Examples

``` r
 if (FALSE) { # \dontrun{
 f <- get_municipalities(year=2016, scale = 4500)
 plot(f)
 } # }
```
