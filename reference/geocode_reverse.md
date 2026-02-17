# Reverse Geocode Geographic Locations into Finnish Place Names or Addresses

Reverse geocodes geographic coordinates into Finnish place names or
street addresses using the National Land Survey of Finland (NLS)
geocoding REST API. This function converts spatial points into textual
location descriptions.

## Usage

``` r
geocode_reverse(
  point,
  boundary_circle_radius = NULL,
  size = NULL,
  layers = NULL,
  sources = NULL,
  return = "sf",
  api_key = getOption("geofi_mml_api_key")
)
```

## Arguments

- point:

  An `sf` object with POINT geometries, representing the locations to
  reverse geocode. The input must be in EPSG:4326 (WGS84) CRS.

- boundary_circle_radius:

  Numeric or NULL. The radius (in meters) of a circular boundary around
  each point to limit the search area. Must be a positive number. If
  `NULL` (default), no boundary radius is applied.

- size:

  Numeric or NULL. The maximum number of results to return per point.
  Must be a positive integer. If `NULL` (default), the API’s default
  size is used.

- layers:

  Character or NULL. The layers to include in the search, specified as a
  comma-separated string (e.g., `"address,poi"`). If `NULL` (default),
  the API’s default layers are used. See the NLS geocoding API
  documentation for valid layers.

- sources:

  Character or NULL. The data sources to search in, specified as a
  comma-separated string (e.g., `"geographic-names,addresses"`). Must be
  one or more of `"interpolated-road-addresses"`, `"geographic-names"`,
  `"addresses"`, `"mapsheets-tm35"`, or `"cadastral-units"`. If `NULL`
  (default), the API’s default sources are used.

- return:

  Character. The format of the returned data. Must be one of `"sf"`
  (default, returns an `sf` object) or `"json"` (returns a list of raw
  JSON responses).

- api_key:

  Character. API key for authenticating with the NLS geocoding API.
  Defaults to the value stored in `options(geofi_mml_api_key)`. You can
  obtain an API key from the National Land Survey of Finland website
  (see
  <https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje>).

## Value

If `return="sf"`, an `sf` object containing the reverse geocoded
locations as points in EPSG:4326 (WGS84) CRS. If `return="json"`, a list
of raw JSON responses from the API. If no results are found for a point,
a warning is issued, and that point may be omitted from the results.

## Details

This function uses the NLS geocoding REST API to convert geographic
coordinates into place names or street addresses. It supports multiple
points in a single call and allows filtering by search radius, layers,
sources, and country. The function includes robust error handling:

- Retries failed requests up to 3 times for transient network issues.

- Handles HTTP errors and rate limits (HTTP 429).

- Validates inputs to prevent common errors.

## See also

[`geocode`](https://ropengov.github.io/geofi/reference/geocode.md) for
forward geocoding.
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

# Create a point for Suomenlinna (in EPSG:4326)

# Reverse geocode to get place names
print(places)

# Reverse geocode with a search radius and return raw JSON
places_json <- geocode_reverse(
  point = suomenlinna,
  boundary_circle_radius = 1000,
  return = "json"
)
print(places_json)
} # }
```
