## Test environments
* local ubuntu 20.04 install, R 4.0.4
* Github Actions with 
    * windows-latest (release)
    * macOS-latest (release)
    * ubuntu-20.04 (release)
    * ubuntu-20.04 (devel)
* win-builder (devel and release)

## R CMD check results

There was 1 ERROR in windows-devel. https://win-builder.r-project.org/ZgBifjnyEvrj/00check.log

* checking whether package 'geofi' can be installed ... ERROR

  Error in library.dynam(lib, package, package.lib) : 
    DLL 'vctrs' not found: maybe not installed for this architecture?
  Calls: <Anonymous> ... loadNamespace -> namespaceImport -> loadNamespace -> library.dynam
  Execution halted

There was 1 NOTE:

  * checking CRAN incoming feasibility ... NOTE
  Maintainer: 'Markus Kainu <markus.kainu@kapsi.fi>'

  New submission

  Possibly mis-spelled words in DESCRIPTION:
    Geospatial (3:16)
    geospatial (32:45)


There were no WARNINGs.


## Downstream dependencies

There are currently no downstream dependencies for this package.
