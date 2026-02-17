# Fetch data from Statistics Finland OGC API

Internal helper function to retrieve spatial data from Statistics
Finland's OGC API. Handles pagination for large datasets and single
requests with specified limits.

## Usage

``` r
fetch_ogc_api_statfi(api_url, limit = NULL, crs)
```

## Arguments

- api_url:

  Character. The API URL to query.

- limit:

  Integer or NULL. Number of features to retrieve. If NULL, fetches all
  available features (max 10000 per request).

- crs:

  Integer. Coordinate Reference System (EPSG code). Options: 3067
  (ETRS89 / TM35FIN), 4326 (WGS84).

## Value

An `sf` object containing the requested spatial data, or NULL if no data
is retrieved.

## Author

Markus Kainu <markus.kainu@kapsi.fi>
