# Convert regional codes in on-board municipality key data sets into variable length characters

Statistics Finland provides numerical codes of regions as two or three
digit characters. By default, those are converted to integers by geofi
for convenience, but can be converted back using this function.

## Usage

``` r
convert_municipality_key_codes(muni_key = geofi::municipality_key)
```

## Arguments

- muni_key:

  a municipality key from geofi-package

## Value

tibble with codes converted to variable length characters as provided by
Statistics Finland

## Author

Markus Kainu <markus.kainu@kapsi.fi>, Pyry Kantanen

## Examples

``` r
 if (FALSE) { # \dontrun{
 convert_municipality_key_codes(muni_key = geofi::municipality_key)
 } # }
```
