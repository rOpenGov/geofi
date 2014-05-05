<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{An R Markdown Vignette made with knitr}
-->


fingis - tutorial
===========

This R package provides tools to access open spatial data in Finland
as part of the [rOpenGov](http://ropengov.github.io) project.

For contact information and source code, see the [github page](https://github.com/rOpenGov/fingis)

## Available data sources

The following data sources are currently available:
* [Helsinki region district maps](#aluejakokartat) (Helsingin seudun aluejakokartat)
 * Aluejakokartat, äänestysaluejako from [Helsingin kaupungin Kiinteistövirasto (HKK)](http://ptp.hel.fi/avoindata/)
* [Helsinki spatial data](#hel-spatial) (Helsingin seudun avoimia paikkatietoaineistoja)
 * Seutukartta, Helsingin piirijako, rakennusrekisterin ote from [Helsingin kaupungin Kiinteistövirasto](http://ptp.hel.fi/avoindata/)
* [National Land Survey data](#maanmittauslaitos) (Maanmittauslaitoksen avointa dataa)
 * Yleiskartat from [National Land Survey Finland](http://www.maanmittauslaitos.fi/en/opendata)
* [Geocoding](#geocoding)
 * Services: [OKF.fi Geocoding API Test Console](http://data.okf.fi/console/), [OpenStreetMap Nominatim](http://wiki.openstreetmap.org/wiki/Nominatim_usage_policy), [Google](http://code.google.com/apis/maps/documentation/geocoding/)

## Installation

Release version for general users:


```r
install.packages("fingis")
```


Development version for developers:


```r
install.packages("devtools")
library(devtools)
install_github("fingis", "ropengov")
```


Load package.


```r
library(fingis)
```


### Notes

The fingis package uses the [rgdal](http://cran.r-project.org/web/packages/rgdal/index.html) library, which depends on the [GDAL](http://www.gdal.org/) spatial framework. Some rgdal installation tips for various platforms lister below. If you encounter problems, please contact us by email: louhos@googlegroups.com.
* Windows: Install binaries from [CRAN](http://cran.r-project.org/web/packages/rgdal/index.html)
* OSX: Install binaries from [CRAN](http://cran.r-project.org/web/packages/rgdal/index.html). Check also [KyngChaos Wiki](http://www.kyngchaos.com/software/frameworks) 
* Linux: Try the installation scripts [here](https://github.com/louhos/takomo/tree/master/installation/) (not necessarily up-to-date!)

## <a name="aluejakokartat"></a>Helsinki region district maps

Helsinki region district maps (Helsingin seudun aluejakokartat) from [Helsingin kaupungin Kiinteistövirasto (HKK)](http://ptp.hel.fi/avoindata/).

List available maps with `get_Helsinki_aluejakokartat()`.


```r
get_Helsinki_aluejakokartat()
```

```
## [1] "kunta"             "pienalue"          "pienalue_piste"   
## [4] "suuralue"          "suuralue_piste"    "tilastoalue"      
## [7] "tilastoalue_piste" "aanestysalue"
```


Below the 'suuralue' districts is used for plotting examples with `spplot()` and [ggplot2](http://ggplot2.org/). The other district types can be plotted similarly.

### Plot with spplot

Retrieve 'suuralue' spatial object with `get_Helsinki_aluejakokartat()` and plot with `spplot()`.


```r
sp.suuralue <- get_Helsinki_aluejakokartat(map.specifier = "suuralue")
spplot(sp.suuralue, zcol = "Name")
```

![plot of chunk hkk-suuralue1](figure/hkk-suuralue1.png) 


Function `generate_map_colours()` generates nice region colours with separable adjacent regions. This is used here for plotting and colouring the regions with `spplot()`.


```r
sp.suuralue@data$COL <- factor(generate_map_colours(sp = sp.suuralue))
spplot(sp.suuralue, zcol = "COL", col.regions = rainbow(length(levels(sp.suuralue@data$COL))), 
    colorkey = FALSE)
```

![plot of chunk hkk-suuralue2](figure/hkk-suuralue2.png) 


### Plot with ggplot2

Use the 'sp.suuralue' retrieved above, and retrieve also the center points of the districts. Use `sp2df()` function to tranform the spatial objects into data frames. Plot with [ggplot2](http://ggplot2.org/), using blank map theme with `get_theme_map()`. 


```r
# Retrieve center points
sp.suuralue.piste <- get_Helsinki_aluejakokartat(map.specifier = "suuralue_piste")
```

```
## OGR data source with driver: KML 
## Source: "/var/folders/6h/s1qsd2q557nfghh2vmc77m2c0000gn/T//RtmpJN2vx9/PKS_suuralue_piste.kml", layer: "pks_suuralue_piste"
## with 23 features and 2 fields
## Feature type: wkbPoint with 3 dimensions
```

```r
# Get data frames
df.suuralue <- sp2df(sp.suuralue, "Name")
df.suuralue.piste <- sp2df(sp.suuralue.piste, "Name")
# Set map theme
library(ggplot2)
theme_set(get_theme_map())
# Plot regions, add labels using the points data
ggplot(df.suuralue, aes(x = long, y = lat)) + geom_polygon(aes(fill = COL, group = Name)) + 
    geom_text(data = df.suuralue.piste, aes(label = Name)) + theme(legend.position = "none")
```

![plot of chunk hkk-suuralue3](figure/hkk-suuralue3.png) 


Add background map from OpenStreetMap using `get_map()` from [ggmap](https://sites.google.com/site/davidkahle/ggmap) and plot again.


```r
# Add background map from OpenStreetMap using ggmap
library(ggmap)
# Get bounding box from sp.suuralue
hel.bbox <- as.vector(sp.suuralue@bbox)
# Get map using openstreetmap
hel.map <- ggmap::get_map(location = hel.bbox, source = "osm")
# Plot transparent districts on top the background map
ggmap(hel.map) + geom_polygon(data = df.suuralue, aes(x = long, y = lat, fill = COL, 
    group = Name), alpha = 0.5) + geom_text(data = df.suuralue.piste, aes(x = long, 
    y = lat, label = Name)) + theme(legend.position = "none")
```

![plot of chunk hkk-suuralue4](figure/hkk-suuralue4.png) 


### Plot elecetion districts

Retrieve and plot äänetysaluejako (election districts) with `get_Helsinki_aluejakokartat()` and `spplot()`.


```r
sp.aanestys <- get_Helsinki_aluejakokartat(map.specifier = "aanestysalue")
spplot(sp.aanestys, zcol = "KUNTA", col.regions = rainbow(length(levels(sp.aanestys@data$KUNTA))), 
    colorkey = FALSE)
```

![plot of chunk hkk-aanestysalue](figure/hkk-aanestysalue.png) 



## <a name="hel-spatial"></a>Helsinki spatial data

Other Helsinki region spatial data from [Helsingin Kaupungin Kiinteistövirasto (HKK)](http://ptp.hel.fi/avoindata/).

List available spatial data with `get_Helsinki_spatial()`.


```r
get_Helsinki_spatial()
```

```
## $seutukartta
##  [1] "A_es_pie"   "a_hy_suu"   "a_ki_pie"   "a_nu_til"   "a_tu_til"  
##  [6] "l_jrata"    " m_jarvet"  "N_MERI_R"   "A_es_suu"   "a_hy_til"  
## [11] "a_ki_suu"   "a_pkspie"   "a_va_kos"   "l_kiitor"   "m_joet"    
## [16] "N_MERI_S"   "a_es_til"   "a_ja_pie"   "a_ki_til"   "a_pkstil"  
## [21] "a_va_suu"   "l_metras"   "m_meri"     "  N_PAIK_R" "a_hk_osa"  
## [26] "a_ja_til"   "a_kunta"    " a_pksuur"  "a_vi_pie"   "l_metror"  
## [31] "m_rantav"   "N_PAIK_S"   "a_hk_per"   "a_ka_pie"   "a_ma_pie"  
## [36] "a_po_til"   "a_vi_suu"   "l_tiest2"   "m_teolal"   "a_hk_pie"  
## [41] "a_ka_til"   "a_ma_til"   "a_si_pie"   "a_vi_til"   "l_tiesto"  
## [46] "m_vihral"   "a_hk_suu"   "a_ke_pie"   "a_nu_pie"   "a_tu_pie"  
## [51] "Copyrig"    "Maankay2"   "N_KOS_R"    "a_hy_pie"   "a_ke_til"  
## [56] "a_nu_suu"   "a_tu_suu"   "l_jasema"   "m_asalue"   "N_KOS_S"   
## 
## $piirijako
## [1] "ALUEJAKO_KUNTA"             "ALUEJAKO_OSAALUE_TUNNUS"   
## [3] "ALUEJAKO_OSAALUE"           "ALUEJAKO_PERUSPIIRI_TUNNUS"
## [5] "ALUEJAKO_PERUSPIIRI"        "ALUEJAKO_PIENALUE_TUNNUS"  
## [7] "ALUEJAKO_PIENALUE"          "ALUEJAKO_SUURPIIRI_TUNNUS" 
## [9] "ALUEJAKO_SUURPIIRI"        
## 
## $rakennusrekisteri
## [1] "20m2_hkikoord" "etrsgk25"      "hkikoord"      "wgs84"
```



## <a name="maanmittauslaitos"></a>National Land Survey Finland

Spatial data from [National Land Survey Finland](http://www.maanmittauslaitos.fi/en/opendata)  (Maanmittauslaitos, MML). These data are preprocessed into RData format, see details [here](https://github.com/avoindata/mml/tree/master/rdata).

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


Retrieve regional borders for Finland with `get_MML()`.


```r
# Get a specific map
sp.mml <- get_MML(map.id = "Yleiskartta-4500", data.id = "HallintoAlue")
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
spplot(sp.mml, zcol = "COL", col.regions = rainbow(length(levels(sp.mml@data$COL))), 
    colorkey = FALSE)
```

![plot of chunk MML_province](figure/MML_province.png) 


Plot provinces (maakunnat) with `spplot()`. Note that `generate_map_colours()` works currently only for the smallest polygons in the data, here municipalities, and can not be used for the provinces!


```r
# Use factors for showing provinces names
sp.mml@data$Maakunta.FI <- factor(sp.mml@data$Maakunta.FI)
# Plot the shape file, colour provinces
spplot(sp.mml, zcol = "Maakunta.FI", col.regions = rainbow(length(levels(sp.mml@data$Maakunta.FI))))
```

![plot of chunk MML_municipality](figure/MML_municipality.png) 


## <a name="geocoding"></a>Geocoding

Get geocodes for given location (address etc.) using one of the available services. Please read carefully the usage policies for the different services:
* [OKF.fi Geocoding API Test Console](http://data.okf.fi/console/)
* [OpenStreetMap Nominatim](http://wiki.openstreetmap.org/wiki/Nominatim_usage_policy)
* [Google](http://code.google.com/apis/maps/documentation/geocoding/)

The function `get_geocode()` returns both latitude and longitude for the first hit, and the raw output (varies depending on the service used).

Warning! The geocode results may vary between sources, use with care!



```r
gc1 <- get_geocode("Mannerheimintie 100, Helsinki", service = "okf")
unlist(gc1[1:2])
```

```
##   lat   lon 
## 60.17 24.94
```

```r
gc2 <- get_geocode("Mannerheimintie 100, Helsinki", service = "openstreetmap")
unlist(gc2[1:2])
```

```
##   lat   lon 
## 60.19 24.92
```

```r
gc3 <- get_geocode("Mannerheimintie 100, Helsinki", service = "google")
unlist(gc3[1:2])
```

```
##   lat   lon 
## 60.19 24.92
```


### Citation

**Citing the data:** See `help()` to get citation information for each data source individually.

**Citing the R package:**


```r
citation("fingis")
```

```

Kindly cite the helsinki R package as follows:

  (C) Juuso Parkkinen, Leo Lahti and Joona Lehtom"{a}ki 2014.
  fingis R package

A BibTeX entry for LaTeX users is

  @Misc{,
    title = {fingis R package},
    author = {Juuso Parkkinen and Leo Lahti and Joona Lehtomaki},
    year = {2014},
  }

Many thanks for all contributors! For more info, see:
https://github.com/rOpenGov/fingis
```



### Session info


This vignette was created with


```r
sessionInfo()
```

```
## R version 3.0.3 (2014-03-06)
## Platform: x86_64-apple-darwin10.8.0 (64-bit)
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] mapproj_1.2-2      maps_2.3-6         ggmap_2.3         
##  [4] rgeos_0.3-4        maptools_0.8-29    knitr_1.5         
##  [7] fingis_0.9.10      RColorBrewer_1.0-5 XML_3.95-0.2      
## [10] ggplot2_0.9.3.1    spdep_0.5-71       Matrix_1.1-2-2    
## [13] RCurl_1.95-4.1     bitops_1.0-6       rjson_0.2.13      
## [16] rgdal_0.8-16       roxygen2_3.1.0     sp_1.0-14         
## 
## loaded via a namespace (and not attached):
##  [1] boot_1.3-10         brew_1.0-6          coda_0.16-1        
##  [4] codetools_0.2-8     colorspace_1.2-4    deldir_0.1-5       
##  [7] dichromat_2.0-0     digest_0.6.4        evaluate_0.5.1     
## [10] foreign_0.8-60      formatR_0.10        grid_3.0.3         
## [13] gtable_0.1.2        labeling_0.2        lattice_0.20-27    
## [16] LearnBayes_2.12     markdown_0.6.4      MASS_7.3-30        
## [19] munsell_0.4.2       nlme_3.1-115        plyr_1.8.1         
## [22] png_0.1-7           proto_0.3-10        Rcpp_0.11.1        
## [25] reshape2_1.2.2      RgoogleMaps_1.2.0.5 RJSONIO_1.0-3      
## [28] scales_0.2.3        splines_3.0.3       stringr_0.6.2      
## [31] tools_3.0.3
```


