# Get Statistical grid data polygons at two different resolution

Thin wrapper around Finnish statistical grid data provided by
[Statistics
Finland](https://stat.fi/org/avoindata/paikkatietoaineistot/vaestoruutuaineisto_1km_en.html).

## Usage

``` r
get_statistical_grid(resolution = 5, auxiliary_data = FALSE)
```

## Arguments

- resolution:

  integer 1 (1km x 1km) or 5 (5km x 5km)

- auxiliary_data:

  logical Whether to include auxiliary data containing municipality
  membership data. Default `FALSE`

## Value

sf object

## Author

Markus Kainu <markus.kainu@kela.fi>, Joona Lehtomäki
<joona.lehtomaki@iki.fi>

## Examples

``` r
 if (FALSE) { # \dontrun{
 f <- get_statistical_grid(resolution = 5, auxiliary_data = FALSE)
 plot(f)
 } # }
```
