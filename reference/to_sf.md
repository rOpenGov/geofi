# Transform a wfs_api object into a sf object.

Statistics Finland WFS API response object's XML (GML) content is
temporarily written on disk and then immediately read back in into a sf
object.

## Usage

``` r
to_sf(api_obj)
```

## Arguments

- api_obj:

  wfs api object

## Value

sf object

## Note

For internal use, not exported.

## Author

Joona Lehtomäki <joona.lehtomaki@iki.fi>
