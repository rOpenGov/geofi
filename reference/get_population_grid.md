# Get Finnish Population grid in two different resolutions for years 2010-2022 Thin wrapper around Finnish population grid data provided by [Statistics Finland](https://stat.fi/org/avoindata/paikkatietoaineistot/vaestoruutuaineisto_1km_en.html).

Get Finnish Population grid in two different resolutions for years
2010-2022 Thin wrapper around Finnish population grid data provided by
[Statistics
Finland](https://stat.fi/org/avoindata/paikkatietoaineistot/vaestoruutuaineisto_1km_en.html).

## Usage

``` r
get_population_grid(year = 2022, resolution = 5)
```

## Arguments

- year:

  A numeric for year of the population grid. Years available 2005 and
  2010-2022.

- resolution:

  1 (1km x 1km) or 5 (5km x 5km)

## Value

sf object

## Details

More information about the dataset from
[Paikkatietohakemisto](https://www.paikkatietohakemisto.fi/geonetwork/srv/eng/catalog.search#/metadata/a901d40a-8a6b-4678-814c-79d2e2ab130c)

## Author

Markus Kainu <markus.kainu@kela.fi>, Joona Lehtomäki
<joona.lehtomaki@iki.fi>

## Examples

``` r
 if (FALSE) { # \dontrun{
 f <- get_population_grid(year=2017)
 plot(f)
 } # }
```
