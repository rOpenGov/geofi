<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An R Markdown Vignette made with knitr}
-->




# gisfin - tutorial

This R package provides tools to access open spatial data in Finland
as part of the [rOpenGov](http://ropengov.github.io) project.

For contact information and source code, see the 
[github page](https://github.com/rOpenGov/gisfin)

## Available data sources

[Helsinki region district maps](#aluejakokartat) (Helsingin seudun 
aluejakokartat)

+ Aluejakokartat: kunta, pien-, suur-, tilastoalueet (Helsinki region district 
maps)
+ Äänestysaluejako: (Helsinki region election district maps)
+ Source: [Helsingin kaupungin Kiinteistövirasto (HKK)](http://ptp.hel.fi/avoindata/)

[Helsinki spatial data](#hel-spatial) (Helsingin seudun avoimia 
paikkatietoaineistoja)

+ Seutukartta (Helsinki Region Maps)
+ Helsingin piirijako (District Division of the City of Helsinki)
+ Seudullinen osoiteluettelo (Regional Address List)
+ Helsingin osoiteluettelo (Register of Addresses of the City of Helsinki)
+ Rakennusrekisterin ote (Helsinki building registry)
+ Source: [Helsingin kaupungin Kiinteistövirasto (HKK)](http://ptp.hel.fi/avoindata/)

[National Land Survey data](#maanmittauslaitos) (Maanmittauslaitoksen avointa 
dataa)

+ Yleiskartat: kunta-, maakuntarajat (municipality and province borders)
+ Source: [Maanmittauslaitos (MML)](http://www.maanmittauslaitos.fi/avoindata)

[Geocoding](#geocoding)

+ [OKF.fi Geocoding API Test Console](http://data.okf.fi/console/)
+ [OpenStreetMap Nominatim](http://wiki.openstreetmap.org/wiki/Nominatim_usage_policy)
+ [Google](http://code.google.com/apis/maps/documentation/geocoding/)

[IP address geographic coordinates](#ip) 

+ [Data Science Toolkit](http://www.datasciencetoolkit.org/)

[Statistics Finland geospatial data](#geostatfi) (Tilastokeskuksen paikkatietoaineistoja)

+ Väestöruutuaineisto (Population grid)
+ Tuotanto- ja teollisuuslaitokset (Production and industrial facilities)
+ Oppilaitokset (Educational institutions)
+ Tieliikenneonnettomuudet (Road accidents)
+ Source: [Statistics Finland](http://www.stat.fi/tup/rajapintapalvelut/index_en.html)

[Finnish postal code areas](#pnro) (Suomalaiset postinumero KML-muodossa)

+ Source: [Duukkis](http://www.palomaki.info/apps/pnro/)

[Examples](#examples) (Further usage examples)

List of potential data sources to be added to the package can be found 
[here](https://github.com/rOpenGov/gisfin/blob/master/vignettes/todo-datasets.md).

## Installation

### Requirements

The gisfin package uses the 
[rgdal](http://cran.r-project.org/web/packages/rgdal/index.html) package, which 
depends on [GDAL](http://www.gdal.org/) (Geospatial Data Abstraction Library).
Some rgdal installation tips for various platforms are listed below. The
gisfin package has been tested with recent versions of the dependency packages
and libraries and it is recommended to use the recent releases. The older versions
are known to cause problems in some cases. If you encounter problems, please contact
us by email: louhos@googlegroups.com.

#### Windows

Install binaries from [CRAN](http://cran.r-project.org/web/packages/rgdal/index.html)

#### OSX

Follow [these instructions](http://tlocoh.r-forge.r-project.org/mac_rgeos_rgdal.html) to install rgeos and rgdal on OSX. If these don't work, install the rgdal from [KyngChaos Wiki](http://www.kyngchaos.com/software/frameworks).This is preferred over using the [CRAN binaries](http://cran.r-project.org/web/packages/rgdal/index.html).

#### Linux 

Install the following packages through your distribution's package manager

__Ubuntu/Debian__

```
sudo apt-get -y install libgdal1-dev libproj-dev
```

__Fedora__

```
sudo yum -y install gdal-devel proj-devel
```

__openSUSE__

```
sudo zypper --non-interactive in libgdal-devel libproj-devel
```

### Additional dependencies

These may be needed:
  <a href="http://trac.osgeo.org/gdal/wiki/DownloadSource">GDAL</a>, 
  <a href="http://freeglut.sourceforge.net/">freeglut</a>, 
  <a href="http://xmlsoft.org/downloads.html">XML</a>, 
	<a href="http://trac.osgeo.org/geos">GEOS</a> and
	<a href="http://trac.osgeo.org/proj">PROJ.4</a>.

### Installing the package

Development version for developers:


```r
install.packages("devtools")
library("devtools")
install_github("ropengov/gisfin")
```

Load package.


```r
library("gisfin")
```

----

## <a name="aluejakokartat"></a>Helsinki region district maps

Helsinki region district maps (Helsingin seudun aluejakokartat) from 
[Helsingin kaupungin Kiinteistövirasto (HKK)](http://ptp.hel.fi/avoindata/).

List available maps with `get_helsinki_aluejakokartat()`.


```r
get_helsinki_aluejakokartat()
```

```
## [1] "kunta"             "pienalue"          "pienalue_piste"   
## [4] "suuralue"          "suuralue_piste"    "tilastoalue"      
## [7] "tilastoalue_piste" "aanestysalue"
```

Below the 'suuralue' districts is used for plotting examples with `spplot()` and 
[ggplot2](http://ggplot2.org/). The other district types can be plotted 
similarly.

### Plot with spplot

Retrieve 'suuralue' spatial object with `get_helsinki_aluejakokartat()` and plot 
with `spplot()`.


```r
sp.suuralue <- get_helsinki_aluejakokartat(map.specifier="suuralue")
spplot(sp.suuralue, zcol="Name")
```

![plot of chunk hkk-suuralue1](figure/hkk-suuralue1-1.png) 

Function `generate_map_colours()` allows nice region colouring separable 
adjacent regions. This is used here with the `rainbow()` colour scale to plot 
the regions with `spplot()`.


```r
sp.suuralue@data$COL <- factor(generate_map_colours(sp=sp.suuralue))
spplot(sp.suuralue, zcol="COL", 
       col.regions=rainbow(length(levels(sp.suuralue@data$COL))), 
       colorkey=FALSE)
```

![plot of chunk hkk-suuralue2](figure/hkk-suuralue2-1.png) 

### Plot with ggplot2

Use the 'sp.suuralue' retrieved above, and retrieve also the center points of 
the districts. Use `sp2df()` function to tranform the spatial objects into data 
frames. Plot with [ggplot2](http://ggplot2.org/), using blank map theme with 
`get_theme_map()`. 


```r
# Retrieve center points
sp.suuralue.piste <- get_helsinki_aluejakokartat(map.specifier="suuralue_piste")
# Get data frames
df.suuralue <- sp2df(sp.suuralue)
df.suuralue.piste <- sp2df(sp.suuralue.piste)
# Set map theme
library(ggplot2)
theme_set(get_theme_map())
# Plot regions, add labels using the points data
ggplot(df.suuralue, aes(x=long, y=lat)) + 
  geom_polygon(aes(fill=COL, group=Name)) + 
  geom_text(data=df.suuralue.piste, aes(label=Name)) + 
  theme(legend.position="none")
```

![plot of chunk hkk-suuralue3](figure/hkk-suuralue3-1.png) 

### Plot election districts

Retrieve and plot äänetysaluejako (election districts) with 
`get_helsinki_aluejakokartat()` and `spplot()`, use colours to separate 
municipalities.


```r
sp.aanestys <- get_helsinki_aluejakokartat(map.specifier="aanestysalue")
spplot(sp.aanestys, zcol="KUNTA", 
       col.regions=rainbow(length(levels(sp.aanestys@data$KUNTA))), 
       colorkey=FALSE)
```

![plot of chunk hkk-aanestysalue](figure/hkk-aanestysalue-1.png) 

----

## <a name="hel-spatial"></a>Helsinki spatial data

Other Helsinki region spatial data from 
[Helsingin Kaupungin Kiinteistövirasto (HKK)](http://ptp.hel.fi/avoindata/).

List available spatial data with `get_helsinki_spatial()`.


```r
get_helsinki_spatial()
```

Retrieve municipality map for the larger Helsinki region with 
`get_helsinki_spatial()` and transform coordinates with `sp::spTransform()`.


```r
sp.piiri <- get_helsinki_spatial(map.type="piirijako", 
                                 map.specifier="ALUEJAKO_PERUSPIIRI")
# Check current coordinates
sp.piiri@proj4string
# Transform coordinates to WGS84
sp.piiri <- sp::spTransform(sp.piiri, CRS("+proj=longlat +datum=WGS84"))
```

----

## <a name="maanmittauslaitos"></a>National Land Survey Finland

Spatial data from [National Land Survey Finland](http://www.maanmittauslaitos.fi/en/opendata) 
(Maanmittauslaitos, MML). These data are preprocessed into RData format, see 
details [here](https://github.com/avoindata/mml).

List available data sets (output not shown here): 


```
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
##  [1] "AmpumaRaja"             "HallintoAlue"          
##  [3] "HallintoAlue_DataFrame" "HallintoalueRaja"      
##  [5] "KaasuJohto"             "KarttanimiPiste500"    
##  [7] "KarttanimiPiste1000"    "KorkeusAlue"           
##  [9] "KorkeusViiva500"        "KorkeusViiva1000"      
## [11] "LentokenttaPiste"       "LiikenneAlue"          
## [13] "MaaAlue"                "Maasto1Reuna"          
## [15] "Maasto2Alue"            "MetsaRaja"             
## [17] "PeltoAlue"              "RautatieViiva"         
## [19] "SahkoLinja"             "SuojaAlue"             
## [21] "SuojametsaRaja"         "SuojeluAlue"           
## [23] "TaajamaAlue"            "TaajamaPiste"          
## [25] "TieViiva"               "VesiAlue"              
## [27] "VesiViiva"             
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
##     Kohderyhma Kohdeluokk Enklaavi AVI Maakunta Kunta
## 005         71      84200        1   4       14   005
## 009         71      84200        1   5       17   009
## 010         71      84200        1   4       14   010
## 016         71      84200        1   1       07   016
## 018         71      84200        1   1       01   018
## 019         71      84200        1   2       02   019
##                                       AVI_ni1
## 005 Länsi- ja Sisä-Suomen aluehallintovirasto
## 009        Pohjois-Suomen aluehallintovirasto
## 010 Länsi- ja Sisä-Suomen aluehallintovirasto
## 016          Etelä-Suomen aluehallintovirasto
## 018          Etelä-Suomen aluehallintovirasto
## 019        Lounais-Suomen aluehallintovirasto
##                                                AVI_ni2         Maaku_ni1
## 005 Regionförvaltningsverket i Västra och Inre Finland   Etelä-Pohjanmaa
## 009           Regionförvaltningsverket i Norra Finland Pohjois-Pohjanmaa
## 010 Regionförvaltningsverket i Västra och Inre Finland   Etelä-Pohjanmaa
## 016           Regionförvaltningsverket i Södra Finland       Päijät-Häme
## 018           Regionförvaltningsverket i Södra Finland           Uusimaa
## 019       Regionförvaltningsverket i Sydvästra Finland   Varsinais-Suomi
##               Maaku_ni2 Kunta_ni1 Kunta_ni2 Kieli_ni1 Kieli_ni2
## 005   Södra Österbotten  Alajärvi       N_A     Suomi       N_A
## 009   Norra Österbotten Alavieska       N_A     Suomi       N_A
## 010   Södra Österbotten    Alavus       N_A     Suomi       N_A
## 016 Päijänne-Tavastland  Asikkala       N_A     Suomi       N_A
## 018              Nyland    Askola       N_A     Suomi       N_A
## 019   Egentliga Finland      Aura       N_A     Suomi       N_A
##                                        AVI.FI Kieli.FI       Maakunta.FI
## 005 Länsi- ja Sisä-Suomen aluehallintovirasto    Suomi  EtelÃ¤-Pohjanmaa
## 009        Pohjois-Suomen aluehallintovirasto    Suomi Pohjois-Pohjanmaa
## 010 Länsi- ja Sisä-Suomen aluehallintovirasto    Suomi  EtelÃ¤-Pohjanmaa
## 016          Etelä-Suomen aluehallintovirasto    Suomi    PÃ¤ijÃ¤t-HÃ¤me
## 018          Etelä-Suomen aluehallintovirasto    Suomi           Uusimaa
## 019        Lounais-Suomen aluehallintovirasto    Suomi   Varsinais-Suomi
##     Kunta.FI
## 005     <NA>
## 009     <NA>
## 010     <NA>
## 016     <NA>
## 018     <NA>
## 019     <NA>
```

Plot municipalities (kunnat) with `spplot()`, using colours from 
`generate_map_colours()`.



```r
# Get region colouring for municipalities
sp.mml@data$COL <- factor(generate_map_colours(sp.mml))
# Plot the shape file, colour municipalities
spplot(sp.mml, zcol="COL", col.regions=rainbow(length(levels(sp.mml@data$COL))), 
       colorkey=FALSE)
```

![plot of chunk MML_municipality](figure/MML_municipality-1.png) 


## <a name="examples"></a>Further examples

### Visualizing Finnish municipalities with your own data

Here we show examples with the standard shape tools. For interactive maps, see [leaflet](https://rstudio.github.io/leaflet/map_widget.html) and [rMaps](http://rmaps.github.io/). Examples to be added later.


First, retrieve population data (2013) for Finnish municipalities:


```r
# Get municipality population data from Statistics Finland
# using the pxweb package
library(pxweb)
mydata <- get_pxweb_data(url = "http://pxwebapi2.stat.fi/PXWeb/api/v1/fi/Kuntien_talous_ja_toiminta/Kunnat/ktt14/080_ktt14_2013_fi.px",
             dims = list(Alue = c('*'),
                         Tunnusluku = c('30'),
                         Vuosi = c('Arvo')),
             clean = TRUE)

# Pick municipality ID from the text field
mydata$Kuntakoodi <- sapply(strsplit(as.character(mydata$Alue), " "), function (x) x[[1]])
mydata$Kunta <- sapply(strsplit(as.character(mydata$Alue), " "), function (x) x[[2]])

# Rename fields for clarity
mydata$Asukasluku <- mydata$values

# Pick only the necessary fields for clarity
mydata <- mydata[, c("Kunta", "Kuntakoodi", "Asukasluku")]
```


Visualize municipality population data with Land Survey Finland (MML) maps:


```r
# Get the municipality map for visualization
sp <- get_municipality_map(data.source = "MML")

# Merge the Finnish map shape file and the population data based on
# the 'Kunta' field. The population data contains also some other
# regions besides municipalities. These will be ignored when merged
# with the municipality map:
sp2 <- sp::merge(sp, mydata, all.x = TRUE, by.x = "kuntakoodi", by.y="Kuntakoodi")

# Plot the shape file, colour municipalities by population
spplot(sp2, zcol="Asukasluku", colorkey=TRUE, main = "Population in Finnish municipalities")
```

![plot of chunk gisfin-owndata1](figure/gisfin-owndata1-1.png) 

You can also use fast wrapper for interactive visualization. This generates ggplot2-object that can be further modified if necessary:


```r
p <- region_plot(sp2, color = "Asukasluku", region = "kuntakoodi")
print(p)
```

![plot of chunk regionplotwrapper](figure/regionplotwrapper-1.png) 


Same with GADM maps. You can select the desired maps at the [GADM service](http://gadm.org/country). Choose Finland and file format R. This will give the [link to the Finnish municipality data file](http://biogeo.ucdavis.edu/data/gadm2/R/FIN_adm4.RData). GADM contains very useful maps but the Finnish municipality map data seems a bit outdated:


```r
# Load municipality borders from GADM:
con <- url("http://biogeo.ucdavis.edu/data/gadm2/R/FIN_adm4.RData")
load(con); close(con)

# Convert NAME field into factor (needed for plots)
gadm$NAME_4 <- factor(gadm$NAME_4)

# Merge the Finnish map shape file and the population data based on
# the 'Kunta' field (see above)
gadm2 <- sp::merge(gadm, mydata, by.x = "NAME_4", by.y = "Kunta", all.x = TRUE)

# Plot the shape file, colour municipalities by population
# It turns out that not all municipality names can be matched.
# We are happy to add solutions here if you have any.
spplot(gadm2, zcol="Asukasluku", colorkey=TRUE, main = "Population in Finnish municipalities")
```

![plot of chunk gisfin-owndata2](figure/gisfin-owndata2-1.png) 




----

## <a name="geocoding"></a>Geocoding

Get geocodes for given location (address etc.) using one of the available 
services. Please read carefully the usage policies for the different services:

+ [OKF.fi Geocoding API Test Console](http://data.okf.fi/console/)
+ [OpenStreetMap Nominatim](http://wiki.openstreetmap.org/wiki/Nominatim_usage_policy)
+ [Google](http://code.google.com/apis/maps/documentation/geocoding/)

The function `get_geocode()` returns both latitude and longitude for the first 
hit, and the raw output (varies depending on the service used).

Warning! The geocode results may vary between sources, use with care!



```r
gc1 <- get_geocode("Mannerheimintie 100, Helsinki", service="okf")
unlist(gc1[1:2])
```

```
##      lat      lon 
## 60.18856 24.91736
```

```r
gc2 <- get_geocode("Mannerheimintie 100, Helsinki", service="openstreetmap")
unlist(gc2[1:2])
```

```
##      lat      lon 
## 60.18864 24.91750
```

```r
gc3 <- get_geocode("Mannerheimintie 100, Helsinki", service="google")
unlist(gc3[1:2])
```

```
##      lat      lon 
## 60.18892 24.91747
```

----

## <a name="ip"></a>IP Location

Geographic coordinates for a given IP-address from
[Data Science Toolkit](http://www.datasciencetoolkit.org/):


```r
ip_location("137.224.252.10")
```

```
## [1] "51.9667015075684" "5.66669988632202"
```

----

## <a name="geostatfi"></a>Statistics Finland geospatial data

Geospatial data provided by 
[Statistics Finland](http://www.stat.fi/tup/rajapintapalvelut/inspire_en.html).

Retrieve a list of the available data sets for population density. In case the 
service is unreachable, `character(0)` is returned.


```r
request <- gisfin::GeoStatFiWFSRequest$new()$getPopulationLayers()
client <- gisfin::GeoStatFiWFSClient$new(request)
layers <- client$listLayers()
if (length(layers) > 0) layers
```

```
##  [1] "vaestoruutu:vaki2005_1km"    "vaestoruutu:vaki2005_1km_kp"
##  [3] "vaestoruutu:vaki2010_1km"    "vaestoruutu:vaki2010_1km_kp"
##  [5] "vaestoruutu:vaki2011_1km"    "vaestoruutu:vaki2011_1km_kp"
##  [7] "vaestoruutu:vaki2012_1km"    "vaestoruutu:vaki2012_1km_kp"
##  [9] "vaestoruutu:vaki2013_1km"    "vaestoruutu:vaki2013_1km_kp"
## [11] "vaestoruutu:vaki2014_1km"    "vaestoruutu:vaki2014_1km_kp"
## [13] "vaestoruutu:vaki2005_5km"    "vaestoruutu:vaki2010_5km"   
## [15] "vaestoruutu:vaki2011_5km"    "vaestoruutu:vaki2012_5km"   
## [17] "vaestoruutu:vaki2013_5km"    "vaestoruutu:vaki2014_5km"   
## attr(,"driver")
## [1] "WFS"
## attr(,"nlayers")
## [1] 18
```

Get population density in year 2005 on a 5 km x 5 km grid, convert to 
RasterStack object and plot on log scale.


```r
library(raster)
request$getPopulation(layers[11])
client <- gisfin::GeoStatFiWFSClient$new(request)
population <- client$getLayer(layers[11])
if (length(population) > 0) {
  x <- sp::SpatialPixelsDataFrame(coordinates(population), population@data, proj4string=population@proj4string)
  population <- raster::stack(x)
  plot(log(population[["vaesto"]]))
}
```

![plot of chunk population-density-plot](figure/population-density-plot-1.png) 

## <a name="pnro"></a>Finnish postal code areas

Spatial data provided by [Duukkis](http://www.palomaki.info/apps/pnro/).

Get the postal code areas and plot them for the Helsinki region.


```r
pnro.sp <- get_postalcode_areas()
pnro.sp@data$COL <- factor(generate_map_colours(sp=pnro.sp))
pnro.pks.sp <- pnro.sp[substr(pnro.sp$pnro, 1, 2) %in% c("00", "01", "02"), ]
spplot(pnro.pks.sp, zcol="COL", 
       col.regions=rainbow(length(levels(pnro.pks.sp@data$COL))), 
       colorkey=FALSE)
```

![plot of chunk postal_code](figure/postal_code-1.png) 


----

### Citation

**Citing the data:** See `help()` to get citation information for each data 
source individually.

**Citing the R package:**


```r
citation("gisfin")
```

```

Kindly cite the gisfin R package as follows:

  (C) Joona Lehtomaki, Juuso Parkkinen, Leo Lahti, Jussi Jousimo
  and Janne Aukia 2015. gisfin R package

A BibTeX entry for LaTeX users is

  @Misc{,
    title = {gisfin R package},
    author = {Joona Lehtomaki and Juuso Parkkinen and Leo Lahti and Jussi Jousimo and Janne Aukia},
    year = {2015},
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
## R version 3.2.0 (2015-04-16)
## Platform: x86_64-unknown-linux-gnu (64-bit)
## Running under: Ubuntu 15.04
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] raster_2.3-40      pxweb_0.5.53       ggplot2_1.0.1     
##  [4] maptools_0.8-36    gisfin_0.9.25      R6_2.0.1          
##  [7] rgdal_0.9-3        sp_1.1-0           knitr_1.10.5      
## [10] scimapClient_0.2.1
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.11.6      spdep_0.5-88     formatR_1.2      plyr_1.8.2      
##  [5] bitops_1.0-6     LearnBayes_2.15  tools_3.2.0      boot_1.3-16     
##  [9] digest_0.6.8     jsonlite_0.9.16  evaluate_0.7     gtable_0.1.2    
## [13] nlme_3.1-120     lattice_0.20-31  Matrix_1.2-0     proto_0.3-10    
## [17] coda_0.17-1      httr_0.6.1       stringr_1.0.0    rgeos_0.3-8     
## [21] grid_3.2.0       data.table_1.9.4 XML_3.98-1.2     foreign_0.8-63  
## [25] RJSONIO_1.3-0    reshape2_1.4.1   deldir_0.1-9     magrittr_1.5    
## [29] scales_0.2.4     MASS_7.3-40      splines_3.2.0    colorspace_1.2-6
## [33] labeling_0.3     stringi_0.4-1    RCurl_1.95-4.6   munsell_0.4.2   
## [37] chron_2.3-45     rjson_0.2.15
```

