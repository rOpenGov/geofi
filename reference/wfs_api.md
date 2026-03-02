# WFS API

Requests to various WFS API.

## Usage

``` r
wfs_api(base_url = "https://geo.stat.fi/geoserver/wfs", queries)
```

## Arguments

- base_url:

  string Api base url

- queries:

  list List of query parameters

## Value

wfs_api (S3) object with the following attributes:

- content:

  XML payload.

- path:

  path provided to get the resonse.

- response:

  the original response object.

## Details

Make a request to the spesific WFS API. The base url is
http://geo.stat.fi/geoserver/wfs to which other components defined by
the arguments are appended.

This is a low-level function intended to be used by other higher level
functions in the package.

Note that GET requests are used using `httpcache` meaning that requests
are cached. If you want clear cache, use
[`httpcache::clearCache()`](https://enpiar.com/r/httpcache/reference/cache-management.html).
To turn the cache off completely, use
[`httpcache::cacheOff()`](https://enpiar.com/r/httpcache/reference/cache-management.html)

## Author

Joona Lehtomäki <joona.lehtomaki@iki.fi>

## Examples

``` r
  wfs_api(base_url = "http://geo.stat.fi/geoserver/wfs",
          queries = append(list("service" = "WFS", "version" = "1.0.0"),
                list(request = "getFeature",
                     layer = "tilastointialueet:kunta4500k_2017")))
#> Requesting response from: http://geo.stat.fi/geoserver/wfs?service=WFS&version=1.0.0&request=getFeature&layer=tilastointialueet%3Akunta4500k_2017
#> $url
#> [1] "http://geo.stat.fi/geoserver/wfs?service=WFS&version=1.0.0&request=getFeature&layer=tilastointialueet%3Akunta4500k_2017"
#> 
#> $response
#> Response [https://geo.stat.fi/geoserver/wfs?service=WFS&version=1.0.0&request=getFeature&layer=tilastointialueet%3Akunta4500k_2017]
#>   Date: 2026-03-02 16:51
#>   Status: 200
#>   Content-Type: text/xml;charset=UTF-8
#>   Size: 450 B
#> <?xml version="1.0" ?>
#> <ServiceExceptionReport
#>    version="1.2.0"
#>    xmlns="http://www.opengis.net/ogc"
#>    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
#>    xsi:schemaLocation="http://www.opengis.net/ogc http://schemas.opengis.net/...
#>    <ServiceException code="MissingParameterValue">
#>       The query should specify either typeName, featureId filter, or a stored...
#> 
#> $content
#> {xml_document}
#> <ServiceExceptionReport version="1.2.0" schemaLocation="http://www.opengis.net/ogc http://schemas.opengis.net/wfs/1.0.0/OGC-exception.xsd" xmlns="http://www.opengis.net/ogc" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
#> [1] <ServiceException code="MissingParameterValue">\n      The query should s ...
#> 
#> attr(,"class")
#> [1] "wfs_api"
```
