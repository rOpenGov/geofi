<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An R Markdown Vignette made with knitr}
-->

Finland GIS R tools
===========

This is an [rOpenGov](http://ropengov.github.com/helsinki) R package
providing tools for Finnish GIS data.


### Installation

Release version for general users:


```r
install.packages("gisfi")
library(gisfi)
```


Development version for developers:


```r
install.packages("devtools")
library(devtools)
install_github("gisfi", "ropengov")
library(gisfi)
```


Further installation and development instructions at the [home
page](http://ropengov.github.com/gisfi).


### Election districts (Aanestysaluejako)

Aanestysaluejako data set includes the elections districts for the cities of the capital region (Helsinki, Espoo, Kauniainen and Vantaa) in MapInfo-format. CRS is Finland KKJ2 (EPSG: 2392). 


```r
# Aanestysaluejako
sp <- GetElectionDistrictsHelsinki()
```

```
## Error: could not find function "GetElectionDistrictsHelsinki"
```



### Statistics districts (Tilastoalue)


```r
id <- "tilastoalue"
res <- GetDistrictBoundariesHelsinki(id)
```

```
## Error: could not find function "GetDistrictBoundariesHelsinki"
```

```r
sp <- res$shape
```

```
## Error: object 'res' not found
```

```r
df <- res$data
```

```
## Error: object 'res' not found
```

```r
head(df)
```

```
##                                                   
## 1 function (x, df1, df2, ncp, log = FALSE)        
## 2 {                                               
## 3     if (missing(ncp))                           
## 4         .External(C_df, x, df1, df2, log)       
## 5     else .External(C_dnf, x, df1, df2, ncp, log)
## 6 }
```

```r
PlotShape(sp, "Name")
```

```
## Error: could not find function "PlotShape"
```


### Municipalities (Kunta)


```r
id <- "kunta"
res <- GetDistrictBoundariesHelsinki(id)
```

```
## Error: could not find function "GetDistrictBoundariesHelsinki"
```

```r
sp <- res$shape
```

```
## Error: object 'res' not found
```

```r
df <- res$data
```

```
## Error: object 'res' not found
```

```r
head(df)
```

```
##                                                   
## 1 function (x, df1, df2, ncp, log = FALSE)        
## 2 {                                               
## 3     if (missing(ncp))                           
## 4         .External(C_df, x, df1, df2, log)       
## 5     else .External(C_dnf, x, df1, df2, ncp, log)
## 6 }
```

```r
PlotShape(sp, "Name")
```

```
## Error: could not find function "PlotShape"
```


### Major districts (Suuralue)


```r
id <- "suuralue"
res <- GetDistrictBoundariesHelsinki(id)
```

```
## Error: could not find function "GetDistrictBoundariesHelsinki"
```

```r
sp <- res$shape
```

```
## Error: object 'res' not found
```

```r
df <- res$data
```

```
## Error: object 'res' not found
```

```r
head(df)
```

```
##                                                   
## 1 function (x, df1, df2, ncp, log = FALSE)        
## 2 {                                               
## 3     if (missing(ncp))                           
## 4         .External(C_df, x, df1, df2, log)       
## 5     else .External(C_dnf, x, df1, df2, ncp, log)
## 6 }
```

```r
PlotShape(sp, "Name")
```

```
## Error: could not find function "PlotShape"
```


### Minor districts (Pienalue)


```r
id <- "pienalue"
res <- GetDistrictBoundariesHelsinki(id)
```

```
## Error: could not find function "GetDistrictBoundariesHelsinki"
```

```r
sp <- res$shape
```

```
## Error: object 'res' not found
```

```r
df <- res$data
```

```
## Error: object 'res' not found
```

```r
head(df)
```

```
##                                                   
## 1 function (x, df1, df2, ncp, log = FALSE)        
## 2 {                                               
## 3     if (missing(ncp))                           
## 4         .External(C_df, x, df1, df2, log)       
## 5     else .External(C_dnf, x, df1, df2, ncp, log)
## 6 }
```

```r
PlotShape(sp, "Name")
```

```
## Error: could not find function "PlotShape"
```




### Licensing and Citations

This work can be freely used, modified and distributed under the
[Two-clause FreeBSD
license](http://en.wikipedia.org/wiki/BSD\_licenses). Cite this R
package and and the appropriate data provider, including a url
link. Kindly cite the R package as 'Leo Lahti, Juuso Parkkinen ja
Joona Lehtomäki (2013). gisfi R package. URL:
http://ropengov.github.io/gisfi'.


### Session info


This vignette was created with


```r
sessionInfo()
```

```
## R version 3.0.1 (2013-05-16)
## Platform: x86_64-unknown-linux-gnu (64-bit)
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=C                 LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] knitr_1.2
## 
## loaded via a namespace (and not attached):
## [1] digest_0.6.3   evaluate_0.4.3 formatR_0.7    stringr_0.6.2 
## [5] tools_3.0.1
```


