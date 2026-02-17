# Download a Collection from the Maastotietokanta (Topographic Database)

Downloads a specific collection of spatial data from the
Maastotietokanta (Topographic Database) using the OGC API provided by
the National Land Survey of Finland (NLS).

## Usage

``` r
ogc_get_maastotietokanta(
  collection = "hautausmaa",
  crs = 3067,
  limit = NULL,
  max_pages = 100,
  bbox = NULL,
  api_key = getOption("geofi_mml_api_key")
)
```

## Arguments

- collection:

  Character. The name of the collection to download (e.g.,
  `"hautausmaa"` for cemeteries). Use
  [`ogc_get_maastotietokanta_collections`](https://ropengov.github.io/geofi/reference/ogc_get_maastotietokanta_collections.md)
  to see available collections.

- crs:

  Numeric or Character. The coordinate reference system (CRS) for the
  output data, specified as an EPSG code. Supported values are `3067`
  (ETRS-TM35FIN, default) and `4326` (WGS84). The returned `sf` object
  will be transformed to this CRS.

- limit:

  Numeric or NULL. The maximum number of features to retrieve in a
  single API request. If `NULL` (default), all available features are
  fetched, potentially using pagination for large collections.

- max_pages:

  Numeric. The maximum number of pages to fetch during pagination when
  `limit=NULL`. Defaults to 100. Increase this value for very large
  collections (e.g., `"suo"`), but be cautious of long runtimes.

- bbox:

  Character or NULL. A bounding box to filter the data, specified as a
  string in the format `"minx,miny,maxx,maxy"` (e.g.,
  `"24.5,60.1,25.5,60.5"`). Coordinates must be in the same CRS as the
  API (EPSG:4326). If `NULL` (default), no spatial filter is applied.

- api_key:

  Character. API key for authenticating with the Maastotietokanta OGC
  API. Defaults to the value stored in `options(geofi_mml_api_key)`. You
  can obtain an API key from the National Land Survey of Finland website
  (see
  <https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje>).

## Value

An `sf` object containing the spatial features from the specified
collection, transformed to the requested `crs`.

## Details

This function retrieves spatial data from the Maastotietokanta
(Topographic Database) OGC API, provided by the National Land Survey of
Finland (NLS). It acts as a wrapper around a lower-level API request
function, adding user-friendly features like CRS transformation and
spatial filtering.

Key features:

- Supports pagination for large collections when `limit=NULL`.

- Limits the number of pages fetched during pagination using
  `max_pages`.

- Applies spatial filtering using a bounding box (`bbox`).

- Transforms the output to the specified CRS (`crs`).

- Validates inputs to prevent common errors.

To see the list of available collections, use
[`ogc_get_maastotietokanta_collections`](https://ropengov.github.io/geofi/reference/ogc_get_maastotietokanta_collections.md).

For very large collections (e.g., `"suo"`), the function may fetch data
in pages of 10,000 features each. If the number of pages exceeds
`max_pages`, a warning is issued, and only the features from the first
`max_pages` pages are returned. Increase `max_pages` to retrieve more
features, but be aware that this may significantly increase runtime.

## See also

[`ogc_get_maastotietokanta_collections`](https://ropengov.github.io/geofi/reference/ogc_get_maastotietokanta_collections.md)
to list available collections.
<https://www.maanmittauslaitos.fi/en/maps-and-spatial-data/datasets-and-interfaces/product-descriptions/topographic-database>
for more information on the Maastotietokanta.
<https://www.maanmittauslaitos.fi/en/rajapinnat/api-avaimen-ohje> for
instructions on obtaining an API key.

## Author

Markus Kainu <markus.kainu@kapsi.fi>

## Examples

``` r
if (FALSE) { # \dontrun{
# Set your API key
options(geofi_mml_api_key = "your_api_key_here")

# Download the "hautausmaa" (cemeteries) collection in EPSG:3067
cemeteries <- ogc_get_maastotietokanta(collection = "hautausmaa")
print(cemeteries)

# Download the "suo" (bogs/marshes) collection with a higher page limit
bogs <- ogc_get_maastotietokanta(
  collection = "suo",
  max_pages = 500
)
print(bogs)

# Download with a bounding box (in EPSG:4326) and transform to EPSG:4326
cemeteries_bbox <- ogc_get_maastotietokanta(
  collection = "hautausmaa",
  bbox = "24.5,60.1,25.5,60.5",
  crs = 4326
)
print(cemeteries_bbox)

} # }
```
