# Check Access to Statistics Finland Geoserver APIs

Tests whether R can access resources at Statistics Finland's geoserver
APIs, specifically the WFS (Web Feature Service) or OGC API. This
internal function is used to verify connectivity before making API
requests.

## Usage

``` r
check_api_access(which_api = "statfi_wfs")
```

## Arguments

- which_api:

  Character. The API to check. Must be one of: `"statfi_wfs"` (checks
  WFS at `http://geo.stat.fi/geoserver/wfs`) or `"statfi_ogc"` (checks
  OGC API at `https://geo.stat.fi/inspire/ogc/api/su/`). Defaults to
  `"statfi_wfs"`.

## Value

Logical. Returns `TRUE` if the API is accessible (HTTP status 200),
`FALSE` otherwise. Issues a warning if the request fails due to network
issues or non-200 status codes.

## Details

This function sends a lightweight HTTP request to the specified API
endpoint to check for accessibility. It uses `httr2` for robust HTTP
handling and retries transient network failures up to 3 times. The
function is intended for internal use within the package to ensure API
connectivity before executing data retrieval operations.

## Author

Markus Kainu <markus.kainu@kapsi.fi>

## Examples

``` r
if (FALSE) { # \dontrun{
  check_api_access()  # Check WFS API
  check_api_access("statfi_ogc")  # Check OGC API
} # }
```
