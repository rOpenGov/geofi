
WMS/WFS-rajapinta R-kielelle on työn alla. Alla työlistan kuvaus. Lisäämme tänne tarkempaa tietoa tuonnempana.

## API:

  1. Setting the data source and querying it
    Public (see "Design decisions" for discussion)  
      * createWMS(url, cache="~")  
        -> information on the data source is retrieved by querying server's
           GetCapabilities and parsed into a data structure in a custom 
           object WMS which is then returned  
        -> creates an error if WMS cannot be reached or doesn't support some
           subset of capabilities (what subset?)  
      * getInfo(WMS, layer=NULL, ...)  
        -> provide standard information on the WMS object or one of data layers
           provided by the WMS  
    Private (should .functionName convention be used?)
      * buildServiceDescription(data.source, layer, extent, resolution)  
        -> build a GDAL compliant WMS service description string (XML) 
           on-the-fly to fetch data from the WMS  
      * getCapabilities(url)  
        -> query WMS capabilities straight from the server
  2. Getting the data
      * getWMSraster(WMS, layer, extent, resolution)  
        -> get the WMS raster data from the server using the function 
           buildServiceDescription  
      * getWFSlayer(WFS, layer, extent, ??)  
        -> get the WMS feature data from the server using the function 
           buildServiceDescription  

***

## Design decisions:

  1. What is the structure of the API?
      * Generic approach: WMS connection is defined as a generic class, data
        is fetched through querying the WMS capabilities. Data sources and sets
        defined separately -> separation of metadata and implementation  
      * Fixed: specific functions for each data source / data set, the 
        required information is mostly hard coded into the functions. Each 
        function will return a specific piece (can be influenced) of a sepcific
        data set (can't be influenced)  
      Example:  
      Fixed:   
      > oiva.corine.data.helsinki <- get.oiva.corine.raster(extent, ...)  
        * layer hard coded, extent deduced from argument, resolution  
          defaulting to something and can be overriden
        * PROS: simpler API calls
          CONS: more magic going on under the hood
      Generic:
      > oiva.wms <- WMS(URL, ...)  
      > oiva.corine.data.helsinki <- getWMSraster(oiva.wms, layer, extent, resolution)  
        * WMS connection explicitly established, raster fetching more verbose  
        * PROS: "explicit is better than implicit", less magic and more 
                flexibility  
          CONS: more complex API and more verbose code  
  2. How should the well-known service information (such as URLs) be stored?
      * In the code -> probably the easiest, clear separation between code and
                       data is kinda nice though  
      * As serialized .Rd-files -> opaque, should be avoided unless intentional 
                                   to hide the data from the user  
      * Flat files (XML or JSON) -> separate from the code, THE BEST? 
      * Database (SQLite) -> a little overkill...  
  3. How is the data represented locally?  
      * WMS is mostly meant for displaying background maps (in e.g. RGB color 
        space) and thus the raster cell values may not correspond to anything
        analytically interesting except colors  
      * GetFeatureInfo will return cell value in the right context (given that
        sufficient metadata is part of the WMS), but it works on coordinate 
        xy-locations and thus e.g. area stats probably don't scale up so well in
        terms of requests  
      * It may be possible to query the WMS for the whole value 
        description (i.e. the legend for specific style) which would enable the 
        free interpretation and reclassification of the raster data -> full 
        analysis capabilities. At least ESRI MapServers might support this.  

***

## Examples:

  E1. Establishing WMS connection and fetching several different rasters using
      the different data sets in OIVA (Corine, Natura2000 etc.)  
  E2. 

***

Milestones:  

  1. Implement GetCapabilities (WMS 1.1.1)  
        * GetCapabilities will return *all* the information available about 
          the content of a wms server  
	        1. XML -> parse directly from URL to a XML doc object (xmlTreeParse)  
	        2. XMLTree will be mapped to a custom S4 object (WMS?) through  
	           makeClassTemplate and/or xmlToS4  
        * GDAL 1.9.0 will probably implement this through gdalinfo
  2. Implement data structures for WMS data sources  
        * Custom classes WMS and WMSlayer  
        * Slots will be populated from a GetCapabilities query  
  3. Implement GetFeatureInfo (WMS 1.1.1)  
        * GetFeatureInfo will return attribute information for a specific 
          feature that is queryable  
        * Another option is to query raster cell values locally (faster), but 
          this would require sufficient metadata on data classification)  
  4. Implement GetLegendGraphic  
        * Mostly for visualization purposess

***

## Random nice features:

  1. Wrap known URLs into data structures
  2. Implement drawExtent() {raster} option to interactively select an extent
  3. Multilayer plotting -> rasters can be drawn on top of each others (not
     sure if possible)

<script src="https://gist.github.com/2292662.js?file=test_crs.R"></script>
