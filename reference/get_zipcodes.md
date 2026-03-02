# Get Finnish zip code (multi)polygons for different years.

Thin wrapper around Finnish zip code areas provided by [Statistics
Finland](https://stat.fi/fi/palvelut/tilastodatapalvelut/paikkatietoaineistot/tilastointialueet/tilastolliset-postinumeroalueet).

## Usage

``` r
get_zipcodes(year = 2025, extend_to_sea_areas = FALSE)
```

## Arguments

- year:

  A numeric for year of the zipcodes. Years available 2015-2025.

- extend_to_sea_areas:

  A logical. Extend the data to show also the sea areas.

## Value

sf object

## Author

Markus Kainu <markus.kainu@kela.fi>, Joona Lehtomäki
<joona.lehtomaki@iki.fi>

## Examples

``` r
 if (FALSE) { # \dontrun{
 f <- get_zipcodes(year=2022)
 plot(f)
 } # }
```
