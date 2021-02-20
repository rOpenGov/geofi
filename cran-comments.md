## Test environments
* local ubuntu 20.04 install, R 4.0.4
* Github Actions with 
    * windows-latest (release)
    * macOS-latest (release)
    * ubuntu-20.04 (release)
    * ubuntu-20.04 (devel)
* win-builder (devel and release)

## R CMD check results

There was 2 NOTEs:

  * checking CRAN incoming feasibility ... NOTE
  Maintainer: 'Markus Kainu <markus.kainu@kapsi.fi>'

  New submission

  Possibly mis-spelled words in DESCRIPTION:
    Geospatial (3:16)
    geospatial (32:45)
    
  * checking top-level files ... NOTE
  Non-standard file/directory found at top level:
    'cran-comments.md'  

There were no ERRORs or WARNINGs.

## Downstream dependencies

There are currently no downstream dependencies for this package.
