# Query Geographic Names (Nimistö) from the National Land Survey of Finland

Queries the Geographic Names (Nimistö) OGC API to retrieve spatial data
on place names provided by the National Land Survey of Finland (NLS).

## Usage

``` r
ogc_get_nimisto(
  search_string = NULL,
  collection = "placenames",
  crs = 3067,
  limit = NULL,
  bbox = NULL,
  custom_params = NULL,
  api_key = getOption("geofi_mml_api_key")
)
```

## Arguments

- search_string:

  Character or NULL. A search string to filter place names (e.g.,
  `"kainu"`). The search is case-insensitive. If `NULL` (default), no
  search filter is applied, and all place names are retrieved (subject
  to the `limit` parameter).

- collection:

  Character or NULL. The name of collection for places, place names and
  map names of the Geographic Names Register provided by the National
  Land Survey of Finland where the search if performed from. Supported
  values are `placenames`, `mapnames`, and `placenames_simple`

- crs:

  Numeric or Character. The coordinate reference system (CRS) for the
  output data, specified as an EPSG code. Supported values are `3067`
  (ETRS-TM35FIN, default) and `4326` (WGS84). The returned `sf` object
  will be transformed to this CRS.

- limit:

  Numeric. The maximum number of features to retrieve in a single API
  request. Defaults to 10. Set to `NULL` to fetch all available features
  (potentially using pagination for large datasets).

- bbox:

  Character or NULL. A bounding box to filter the data, specified as a
  string in the format `"minx,miny,maxx,maxy"` (e.g.,
  `"24.5,60.1,25.5,60.5"`). Coordinates must be in the same CRS as the
  API (EPSG:4326). If `NULL` (default), no spatial filter is applied.

- custom_params:

  Character or NULL. Additional query parameters to append to the API
  URL, specified as a single string (e.g., `"attribute='value'"`). If
  `NULL` (default), no additional parameters are included.

- api_key:

  Character. API key for authenticating with the Geographic Names OGC
  API. Defaults to the value stored in `options(geofi_mml_api_key)`. You
  can obtain an API key from the National Land Survey of Finland website
  (see
  <https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje>).

## Value

An `sf` object containing the spatial features (place names) from the
Geographic Names dataset, transformed to the requested `crs`. If no
features are found, a warning is issued, and an empty `sf` object may be
returned.

## Details

This function retrieves spatial data on place names from the Geographic
Names (Nimistö) OGC API, provided by the National Land Survey of Finland
(NLS). It supports filtering by a search string (case-insensitive),
spatial filtering using a bounding box, and limiting the number of
returned features.

Key features:

- Supports pagination for large datasets when `limit=NULL`.

- Applies spatial filtering using a bounding box (`bbox`).

- Transforms the output to the specified CRS (`crs`).

- Validates inputs to prevent common errors.

## See also

<https://www.maanmittauslaitos.fi/nimiston-kyselypalvelu-ogc-api/tekninen-kuvaus>
for more information on the Geographic Names dataset.
<https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje> for
instructions on obtaining an API key.

## Author

Markus Kainu <markus.kainu@kapsi.fi>

## Examples

``` r
if (FALSE) { # \dontrun{
# Set your API key
options(geofi_mml_api_key = "your_api_key_here")

# Search for place names containing "kainu" in EPSG:3067
places <- ogc_get_nimisto(search_string = "kainu")
print(places)

# Search with a bounding box (in EPSG:4326) and transform to EPSG:4326
places_bbox <- ogc_get_nimisto(
  search_string = "kainu",
  bbox = "24.5,60.1,25.5,60.5",
  crs = 4326
)
print(places_bbox)

# Fetch all place names (no search filter) with a custom limit
all_places <- ogc_get_nimisto(
  search_string = NULL,
  limit = 100
)
print(all_places)
} # }
```
