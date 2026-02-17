# Fetch Data from OGC API (Internal)

This internal function retrieves spatial data from an OGC API endpoint
with pagination support. It handles both limited and unlimited requests,
automatically paginating through results when no limit is specified. It
includes basic error handling and rate limit handling.

## Usage

``` r
fetch_ogc_api_mml(api_url, limitti = NULL, max_pages = 100)
```

## Arguments

- api_url:

  Character. The base URL of the OGC API endpoint.

- limitti:

  Numeric or NULL. The maximum number of features to retrieve per
  request. If NULL, the function first attempts to fetch all available
  features without pagination (limit=-1) for speed, falling back to
  pagination with a default limit of 10,000 per request if the no-paging
  request fails.

- max_pages:

  Numeric. The maximum number of pages to fetch during pagination when
  `limitti` is NULL. Defaults to 100. Increase this value for very large
  datasets, but be cautious of long runtimes.

## Value

An `sf` object containing the retrieved spatial features.

## Details

This function is intended for internal use within the package. It uses
the `httr2` package to make HTTP requests and `sf` to parse GeoJSON
responses into spatial data. When `limitti` is NULL, it first attempts
to fetch all features in a single request (limit=-1). If this fails
(e.g., due to R's character string size limit), it falls back to
paginating through features by following the "next" links in the API
response. It includes basic rate limit handling for status code 429.

## Note

This function is not exported and should only be called by other
functions within the package.
