# Geocode Finnish Place Names or Street Addresses

Geocodes Finnish place names or street addresses using the National Land
Survey of Finland (NLS) geocoding REST API. This function converts
textual location descriptions into spatial coordinates.

## Usage

``` r
geocode(
  search_string,
  source = "interpolated-road-addresses",
  crs = 3067,
  lang = "fi",
  size = NULL,
  options = NULL,
  api_key = getOption("geofi_mml_api_key")
)
```

## Arguments

- search_string:

  Character. The place name or street address to geocode (e.g.,
  `"Suomenlinna"` or `"Mannerheimintie 100, Helsinki"`).

- source:

  Character. The data source to search in. Must be one of:
  `"interpolated-road-addresses"` (default), `"geographic-names"`,
  `"addresses"`, `"mapsheets-tm35"`, or `"cadastral-units"`.

- crs:

  Character. The coordinate reference system (CRS) for the output data,
  specified as an EPSG code. Must be one of `"EPSG:3067"` (ETRS-TM35FIN,
  default) or `"EPSG:4326"` (WGS84).

- lang:

  Character. The language for the API response labels. Must be one of
  `"fi"` (Finnish, default), `"sv"` (Swedish), or `"en"` (English).

- size:

  Numeric or NULL. The maximum number of results to return. Must be a
  positive integer. If `NULL` (default), the API’s default size is used.

- options:

  Character or NULL. Additional options to pass to the API, specified as
  a single string (e.g.,
  `"focus.point.lat=60.1699&focus.point.lon=24.9384"`). If `NULL`
  (default), no additional options are included. See the NLS geocoding
  API documentation for valid options.

- api_key:

  Character. API key for authenticating with the NLS geocoding API.
  Defaults to the value stored in `options(geofi_mml_api_key)`. You can
  obtain an API key from the National Land Survey of Finland website
  (see
  <https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje>).

## Value

An `sf` object containing the geocoded locations as points in the
specified `crs`. If no results are found, a warning is issued, and an
empty `sf` object is returned.

## Details

This function uses the NLS geocoding REST API to convert place names or
street addresses into spatial coordinates. It supports multiple data
sources, including interpolated road addresses, geographic names, and
cadastral units. The function includes robust error handling:

- Retries failed requests up to 3 times for transient network issues.

- Handles HTTP errors and rate limits (HTTP 429).

- Validates inputs to prevent common errors.

## See also

[`geocode_reverse`](https://ropengov.github.io/geofi/reference/geocode_reverse.md)
for reverse geocoding.
<https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje> for
instructions on obtaining an API key.
<https://www.maanmittauslaitos.fi/kartat-ja-paikkatieto/aineistot-ja-rajapinnat/paikkatietojen-rajapintapalvelut/geokoodauspalvelu>
for more information on the NLS geocoding API.

## Author

Markus Kainu <markus.kainu@kapsi.fi>

## Examples

``` r
if (FALSE) { # \dontrun{
# Set your API key
options(geofi_mml_api_key = "your_api_key_here")

# Geocode a place name
locations <- geocode(search_string = "Suomenlinna", source = "geographic-names")
print(locations)

# Geocode a street address with a custom size and output CRS
addresses <- geocode(
  search_string = "Mannerheimintie 100, Helsinki",
  source = "addresses",
  crs = "EPSG:4326",
  size = 5
)
print(addresses)
} # }
```
