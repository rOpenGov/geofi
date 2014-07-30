<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An R Markdown Vignette made with knitr}
-->

<!--
Joissakin esimerkeissa tarvittavat riippuvuudet 
	<a href="http://trac.osgeo.org/gdal/wiki/DownloadSource">GDAL</a>, 
	<a href="http://freeglut.sourceforge.net/">freeglut</a>, 
	<a href="http://xmlsoft.org/downloads.html">XML</a>, 
	<a href="http://trac.osgeo.org/geos">GEOS</a> ja 
	<a href="http://trac.osgeo.org/proj">PROJ.4</a>. 
-->



gisfin - tutorial
===========

This R package provides tools to access open spatial data in Finland
as part of the [rOpenGov](http://ropengov.github.io) project.

For contact information and source code, see the [github page](https://github.com/rOpenGov/gisfin)

## Available data sources

[Helsinki region district maps](#aluejakokartat) (Helsingin seudun aluejakokartat)
* Aluejakokartat: kunta, pien-, suur-, tilastoalueet (Helsinki region district maps)
* Äänestysaluejako: (Helsinki region election district maps)
* Source: [Helsingin kaupungin Kiinteistövirasto (HKK)](http://ptp.hel.fi/avoindata/)

[Helsinki spatial data](#hel-spatial) (Helsingin seudun avoimia paikkatietoaineistoja)
* Seutukartta (Helsinki Region Maps)
* Helsingin piirijako (District Division of the City of Helsinki)
* Seudullinen osoiteluettelo (Regional Address List)
* Helsingin osoiteluettelo (Register of Addresses of the City of Helsinki)
* Rakennusrekisterin ote (Helsinki building registry)
* Source: [Helsingin kaupungin Kiinteistövirasto (HKK)](http://ptp.hel.fi/avoindata/)

[National Land Survey data](#maanmittauslaitos) (Maanmittauslaitoksen avointa dataa)
* Yleiskartat: kunta-, maakuntarajat (municipality and province borders)
* Source: [Maanmittauslaitos (MML)](http://www.maanmittauslaitos.fi/avoindata)

[Geocoding](#geocoding)
* [OKF.fi Geocoding API Test Console](http://data.okf.fi/console/)
* [OpenStreetMap Nominatim](http://wiki.openstreetmap.org/wiki/Nominatim_usage_policy)
* [Google](http://code.google.com/apis/maps/documentation/geocoding/)

[IP address geographic coordinates](#ip) 
* [Data Science Toolkit](http://www.datasciencetoolkit.org/)

[Statistics Finland grid data](#geostatfi)
* Population grid data 1 km x 1 km
* Source: [Statistics Finland](http://www.stat.fi/tup/rajapintapalvelut/index_en.html)


List of potential data sources to be added to the package can be found [here](https://github.com/rOpenGov/gisfin/blob/master/vignettes/todo-datasets.md).


## Installation

Release version for general users:


```r
install.packages("gisfin")
```

Development version for developers:


```r
install.packages("devtools")
library(devtools)
install_github("gisfin", "ropengov")
```

Load package.


```r
library(gisfin)
```

### Notes

The gisfin package uses the [rgdal](http://cran.r-project.org/web/packages/rgdal/index.html) library, which depends on the [GDAL](http://www.gdal.org/) spatial framework. Some rgdal installation tips for various platforms lister below. If you encounter problems, please contact us by email: louhos@googlegroups.com.
* Windows: Install binaries from [CRAN](http://cran.r-project.org/web/packages/rgdal/index.html)
* OSX: It is preferable to NOT use the [CRAN binaries](http://cran.r-project.org/web/packages/rgdal/index.html). Instead, you should check [KyngChaos Wiki](http://www.kyngchaos.com/software/frameworks)  and install the latest GDAL Complete (v. 1.11 in July 2014) and then install the corresponding rgdal package from the same page (v. 0.8.16 in July 2014). 
* Linux: Try the installation scripts [here](https://github.com/louhos/takomo/tree/master/installation/) (not necessarily up-to-date!)

## <a name="aluejakokartat"></a>Helsinki region district maps

Helsinki region district maps (Helsingin seudun aluejakokartat) from [Helsingin kaupungin Kiinteistövirasto (HKK)](http://ptp.hel.fi/avoindata/).

List available maps with `get_helsinki_aluejakokartat()`.


```r
get_helsinki_aluejakokartat()
```

```
## [1] "kunta"             "pienalue"          "pienalue_piste"   
## [4] "suuralue"          "suuralue_piste"    "tilastoalue"      
## [7] "tilastoalue_piste" "aanestysalue"
```

Below the 'suuralue' districts is used for plotting examples with `spplot()` and [ggplot2](http://ggplot2.org/). The other district types can be plotted similarly.

### Plot with spplot

Retrieve 'suuralue' spatial object with `get_helsinki_aluejakokartat()` and plot with `spplot()`.


```r
sp.suuralue <- get_helsinki_aluejakokartat(map.specifier="suuralue")
spplot(sp.suuralue, zcol="Name")
```

![plot of chunk hkk-suuralue1](figure/hkk-suuralue1.png) 

Function `generate_map_colours()` allows nice region colouring separable adjacent regions. This is used here with the `rainbow()` colour scale to plot the regions with `spplot()`.


```r
sp.suuralue@data$COL <- factor(generate_map_colours(sp=sp.suuralue))
spplot(sp.suuralue, zcol="COL", col.regions=rainbow(length(levels(sp.suuralue@data$COL))), colorkey=FALSE)
```

![plot of chunk hkk-suuralue2](figure/hkk-suuralue2.png) 

### Plot with ggplot2

Use the 'sp.suuralue' retrieved above, and retrieve also the center points of the districts. Use `sp2df()` function to tranform the spatial objects into data frames. Plot with [ggplot2](http://ggplot2.org/), using blank map theme with `get_theme_map()`. 


```r
# Retrieve center points
sp.suuralue.piste <- get_helsinki_aluejakokartat(map.specifier="suuralue_piste")
# Get data frames
df.suuralue <- sp2df(sp.suuralue, "Name")
df.suuralue.piste <- sp2df(sp.suuralue.piste, "Name")
# Set map theme
library(ggplot2)
theme_set(get_theme_map())
# Plot regions, add labels using the points data
ggplot(df.suuralue, aes(x=long, y=lat)) + geom_polygon(aes(fill=COL, group=Name)) + geom_text(data=df.suuralue.piste, aes(label=Name)) + theme(legend.position="none")
```

![plot of chunk hkk-suuralue3](figure/hkk-suuralue3.png) 

Add background map from OpenStreetMap using `get_map()` from [ggmap](https://sites.google.com/site/davidkahle/ggmap) and plot again.


```r
# Add background map from OpenStreetMap using ggmap
library(ggmap)
```

```
## Error: there is no package called 'ggmap'
```

```r
# Get bounding box from sp.suuralue
hel.bbox <- as.vector(sp.suuralue@bbox)
# Get map using openstreetmap
hel.map <- ggmap::get_map(location=hel.bbox, source="osm")
```

```
## Error: there is no package called 'ggmap'
```

```r
# Plot transparent districts on top the background map
ggmap(hel.map) + geom_polygon(data=df.suuralue, aes(x=long, y=lat, fill=COL, group=Name), alpha=0.5) + geom_text(data=df.suuralue.piste, aes(x=long, y=lat, label=Name)) + theme(legend.position="none")
```

```
## Error: could not find function "ggmap"
```

### Plot election districts

Retrieve and plot äänetysaluejako (election districts) with `get_helsinki_aluejakokartat()` and `spplot()`, use colours to separate municipalities.


```r
sp.aanestys <- get_helsinki_aluejakokartat(map.specifier="aanestysalue")
spplot(sp.aanestys, zcol="KUNTA", col.regions=rainbow(length(levels(sp.aanestys@data$KUNTA))), colorkey=FALSE)
```

![plot of chunk hkk-aanestysalue](figure/hkk-aanestysalue.png) 


## <a name="hel-spatial"></a>Helsinki spatial data

Other Helsinki region spatial data from [Helsingin Kaupungin Kiinteistövirasto (HKK)](http://ptp.hel.fi/avoindata/).

List available spatial data with `get_helsinki_spatial()`.


```r
get_helsinki_spatial()
```

Retrieve municipality map for the larger Helsinki region with `get_helsinki_spatial()`. Transform coordinates with `sp::spTransform()` and plot with `ggmap()`.


```r
sp.piiri <- get_helsinki_spatial(map.type="piirijako", map.specifier="ALUEJAKO_PERUSPIIRI")
# Check current coordinates
sp.piiri@proj4string
# Transform coordinates to WGS84
sp.piiri <- sp::spTransform(sp.piiri, CRS("+proj=longlat +datum=WGS84"))
# Transform to data frame and plot with ggplot on top of OpenStreetMap
df.piiri <- sp2df(sp.piiri, region="NIMI")
ggmap(hel.map) + geom_polygon(data=df.piiri, aes(x=long, y=lat, fill=NIMI), alpha=0.5) + theme(legend.position="none")
```

```
## Error: could not find function "ggmap"
```

## <a name="maanmittauslaitos"></a>National Land Survey Finland

Spatial data from [National Land Survey Finland](http://www.maanmittauslaitos.fi/en/opendata)  (Maanmittauslaitos, MML). These data are preprocessed into RData format, see details [here](https://github.com/avoindata/mml).

List available data sets with `list_mml_datasets()`.


```r
list_mml_datasets()
```

```
## $`1_milj_Shape_etrs_shape`
##  [1] "AVI1_l"   "AVI1_p"   "airport"  "asemat"   "cityp"    "coast_l" 
##  [7] "coast_p"  "dcont_l"  "dcont_p"  "forest"   "hcont_l"  "hcont_p" 
## [13] "hpoint"   "kunta1_l" "kunta1_p" "lake_l"   "lake_p"   "maaku1_l"
## [19] "maaku1_p" "namep"    "pelto"    "railway"  "river"    "rivera_l"
## [25] "rivera_p" "road"     "suot"     "taajama" 
## 
## $`4_5_milj_shape_etrs-tm35fin`
##  [1] "AVI1_l"   "AVI1_p"   "AVI4_l"   "AVI4_p"   "airport"  "asemat"  
##  [7] "cityp"    "coast"    "coast_l"  "coast_p"  "dcont_l"  "dcont_p" 
## [13] "forest"   "hcont_l"  "hcont_p"  "hpoint"   "kunta1_l" "kunta1_p"
## [19] "kunta4_l" "kunta4_p" "lake"     "lake_l"   "lake_p"   "maaku1_l"
## [25] "maaku1_p" "maaku4_l" "maaku4_p" "namep"    "pelto"    "railway" 
## [31] "rajamuu"  "river"    "rivera_l" "rivera_p" "road"     "suot"    
## [37] "taajama" 
## 
## $`2012`
## character(0)
## 
## $`Maastotietokanta-tiesto1`
## [1] "N61_v"
## 
## $`Maastotietokanta-tiesto2`
## [1] "N62_p" "N62_s" "N62_t" "N62_v"
## 
## $`Yleiskartta-1000`
##  [1] "AmpumaRaja"          "HallintoAlue"        "HallintoalueRaja"   
##  [4] "KaasuJohto"          "KarttanimiPiste500"  "KarttanimiPiste1000"
##  [7] "KorkeusAlue"         "KorkeusViiva500"     "KorkeusViiva1000"   
## [10] "LentokenttaPiste"    "LiikenneAlue"        "MaaAlue"            
## [13] "Maasto1Reuna"        "Maasto2Alue"         "MetsaRaja"          
## [16] "PeltoAlue"           "RautatieViiva"       "SahkoLinja"         
## [19] "SuojaAlue"           "SuojametsaRaja"      "SuojeluAlue"        
## [22] "TaajamaAlue"         "TaajamaPiste"        "TieViiva"           
## [25] "VesiAlue"            "VesiViiva"          
## 
## $`Yleiskartta-4500`
##  [1] "HallintoAlue"        "HallintoalueRaja"    "KarttanimiPiste2000"
##  [4] "KarttanimiPiste4500" "KarttanimiPiste8000" "KorkeusAlue"        
##  [7] "KorkeusViiva"        "Maasto1Reuna"        "RautatieViiva"      
## [10] "TaajamaPiste2000"    "TaajamaPiste4500"    "TaajamaPiste8000"   
## [13] "TieViiva2000"        "TieViiva4500"        "TieViiva8000"       
## [16] "VesiAlue"            "VesiViiva2000"       "VesiViiva4500"      
## [19] "VesiViiva8000"
```

Retrieve regional borders for Finland with `get_mml()`.


```r
# Get a specific map
sp.mml <- get_mml(map.id="Yleiskartta-4500", data.id="HallintoAlue")
# Investigate available variables in this map
head(as.data.frame(sp.mml))
```

```
##   Kohderyhma Kohdeluokk Enklaavi AVI Maakunta Kunta
## 0         71      84200        1   1       01   078
## 1         71      84200        1   1       01   149
## 2         71      84200        1   7       21   318
## 3         71      84200        1   1       01   710
## 4         71      84200        1   1       01   235
## 5         71      84200        1   7       21   062
##                            AVI_ni1
## 0 Etelä-Suomen aluehallintovirasto
## 1 Etelä-Suomen aluehallintovirasto
## 2       Ahvenanmaan valtionvirasto
## 3 Etelä-Suomen aluehallintovirasto
## 4 Etelä-Suomen aluehallintovirasto
## 5       Ahvenanmaan valtionvirasto
##                                    AVI_ni2            Maaku_ni1
## 0 Regionförvaltningsverket i Södra Finland              Uusimaa
## 1 Regionförvaltningsverket i Södra Finland              Uusimaa
## 2              Statens ämbetsverk på Åland Ahvenanmaan maakunta
## 3 Regionförvaltningsverket i Södra Finland              Uusimaa
## 4 Regionförvaltningsverket i Södra Finland              Uusimaa
## 5              Statens ämbetsverk på Åland Ahvenanmaan maakunta
##          Maaku_ni2  Kunta_ni1 Kunta_ni2 Kieli_ni1 Kieli_ni2
## 0           Nyland      Hanko     Hangö     Suomi    Ruotsi
## 1           Nyland       Ingå     Inkoo    Ruotsi     Suomi
## 2 Landskapet Åland      Kökar       N_A    Ruotsi       N_A
## 3           Nyland   Raseborg Raasepori    Ruotsi     Suomi
## 4           Nyland Kauniainen Grankulla     Suomi    Ruotsi
## 5 Landskapet Åland      Föglö       N_A    Ruotsi       N_A
##                             AVI.FI Kieli.FI          Maakunta.FI
## 0 Etelä-Suomen aluehallintovirasto    Suomi              Uusimaa
## 1 Etelä-Suomen aluehallintovirasto   Ruotsi              Uusimaa
## 2       Ahvenanmaan valtionvirasto   Ruotsi Ahvenanmaan maakunta
## 3 Etelä-Suomen aluehallintovirasto   Ruotsi              Uusimaa
## 4 Etelä-Suomen aluehallintovirasto    Suomi              Uusimaa
## 5       Ahvenanmaan valtionvirasto   Ruotsi Ahvenanmaan maakunta
##     Kunta.FI
## 0      Hanko
## 1      Inkoo
## 2      Kökar
## 3  Raasepori
## 4 Kauniainen
## 5      Föglö
```

Plot municipalities (kunnat) with `spplot()`, using colours from `generate_map_colours()`.



```r
# Get region colouring for municipalities
sp.mml@data$COL <- factor(generate_map_colours(sp.mml))
# Plot the shape file, colour municipalities
spplot(sp.mml, zcol="COL", col.regions=rainbow(length(levels(sp.mml@data$COL))), colorkey=FALSE)
```

![plot of chunk MML_municipality](figure/MML_municipality.png) 

Plot provinces (maakunnat) with `spplot()`. Note that `generate_map_colours()` works currently only for the smallest polygons in the data, here municipalities, and can not be used for the provinces!


```r
# Convert municipality names to factors and fix character encoding
sp.mml@data$Maakunta.FI <- factor(iconv(sp.mml@data$Maakunta.FI, from="UTF-8", to="ISO-8859-1"))
# Plot the shape file, colour provinces 
spplot(sp.mml, zcol="Maakunta.FI", col.regions=rainbow(length(levels(sp.mml@data$Maakunta.FI))))
```

![plot of chunk MML_provinces](figure/MML_provinces.png) 

## <a name="geocoding"></a>Geocoding

Get geocodes for given location (address etc.) using one of the available services. Please read carefully the usage policies for the different services:
* [OKF.fi Geocoding API Test Console](http://data.okf.fi/console/)
* [OpenStreetMap Nominatim](http://wiki.openstreetmap.org/wiki/Nominatim_usage_policy)
* [Google](http://code.google.com/apis/maps/documentation/geocoding/)

The function `get_geocode()` returns both latitude and longitude for the first hit, and the raw output (varies depending on the service used).

Warning! The geocode results may vary between sources, use with care!



```r
gc1 <- get_geocode("Mannerheimintie 100, Helsinki", service="okf")
unlist(gc1[1:2])
```

```
##   lat   lon 
## 60.17 24.94
```

```r
gc2 <- get_geocode("Mannerheimintie 100, Helsinki", service="openstreetmap")
unlist(gc2[1:2])
```

```
##   lat   lon 
## 60.19 24.92
```

```r
gc3 <- get_geocode("Mannerheimintie 100, Helsinki", service="google")
unlist(gc3[1:2])
```

```
##   lat   lon 
## 60.19 24.92
```

## <a name="ip"></a>IP Location

Geographic coordinates for a given IP-address from
[Data Science Toolkit](http://www.datasciencetoolkit.org/):


```r
ip_location("137.224.252.10")
```

```
## [1] "51.9667015075684" "5.66669988632202"
```

## <a name="geostatfi"></a>Statistics Finland geospatial data

Geospatial data provided by [Statistics Finland](http://www.stat.fi/tup/rajapintapalvelut/inspire_en.html).

Retrieve a list of the available data sets for population density.


```r
geoStatFi <- GeoStatFi()
layers <- geoStatFi$listPopulationLayers()
layers
```

```
##  [1] "vaestoruutu:vaki2005_1km"    "vaestoruutu:vaki2005_1km_kp"
##  [3] "vaestoruutu:vaki2010_1km"    "vaestoruutu:vaki2010_1km_kp"
##  [5] "vaestoruutu:vaki2011_1km"    "vaestoruutu:vaki2011_1km_kp"
##  [7] "vaestoruutu:vaki2012_1km"    "vaestoruutu:vaki2012_1km_kp"
##  [9] "vaestoruutu:vaki2013_1km"    "vaestoruutu:vaki2013_1km_kp"
## [11] "vaestoruutu:vaki2005_5km"    "vaestoruutu:vaki2010_5km"   
## [13] "vaestoruutu:vaki2011_5km"    "vaestoruutu:vaki2012_5km"   
## [15] "vaestoruutu:vaki2013_5km"
```

Get population density in year 2005 on a 5 km x 5 km grid, convert to RasterStack object and plot.


```r
population <- geoStatFi$getPopulation(layers[11])
x <- geoStatFi$getRaster(population)
plot(x[["vaesto"]])
```

![plot of chunk population-density-plot](figure/population-density-plot.png) 

Plot road accident density in 2011.


```r
roadAccidents <- geoStatFi$getRoadAccidents("tieliikenne:tieliikenne_2011")
# Rasterize point data onto a 5 km x 5 km grid
library(raster)
template <- raster(extent(85000, 730000, 6625000, 7780000), nrows=231, ncols=129, crs=CRS("+proj=utm +zone=35 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"))
x <- geoStatFi$getRaster(roadAccidents[,1], template=template, fun="count")
plot(x[[1]])
```

![plot of chunk road-accident-density](figure/road-accident-density.png) 

### Citation

**Citing the data:** See `help()` to get citation information for each data source individually.

**Citing the R package:**


```r
citation("gisfin")
```

```

Kindly cite the gisfin R package as follows:

  (C) Juuso Parkkinen, Leo Lahti, Joona Lehtomaki, Janne Aukia and
  Jussi Jousimo 2014. gisfin R package

A BibTeX entry for LaTeX users is

  @Misc{,
    title = {gisfin R package},
    author = {Juuso Parkkinen and Leo Lahti and Joona Lehtomaki and Janne Aukia and Jussi Jousimo},
    year = {2014},
  }

Many thanks for all contributors! For more info, see:
https://github.com/rOpenGov/gisfin
```


### Session info


This vignette was created with


```r
sessionInfo()
```

```
## R version 3.1.1 (2014-07-10)
## Platform: x86_64-apple-darwin13.1.0 (64-bit)
## 
## locale:
## [1] en_GB.UTF-8/en_GB.UTF-8/en_GB.UTF-8/C/en_GB.UTF-8/en_GB.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] raster_2.2-31   ggplot2_1.0.0   rgeos_0.3-6     maptools_0.8-30
## [5] gisfin_0.9.16   rgdal_0.8-16    sp_1.0-15       knitr_1.6      
## 
## loaded via a namespace (and not attached):
##  [1] boot_1.3-11      coda_0.16-1      colorspace_1.2-4 deldir_0.1-5    
##  [5] digest_0.6.4     evaluate_0.5.5   foreign_0.8-61   formatR_0.10    
##  [9] grid_3.1.1       gtable_0.1.2     labeling_0.2     lattice_0.20-29 
## [13] LearnBayes_2.15  markdown_0.7     MASS_7.3-33      Matrix_1.1-4    
## [17] munsell_0.4.2    nlme_3.1-117     plyr_1.8.1       proto_0.3-10    
## [21] Rcpp_0.11.2      RCurl_1.95-4.1   reshape2_1.4     rjson_0.2.14    
## [25] scales_0.2.4     spdep_0.5-74     splines_3.1.1    stringr_0.6.2   
## [29] tools_3.1.1      XML_3.98-1.1
```

