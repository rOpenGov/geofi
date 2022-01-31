## Test environments
* local ubuntu 20.04 install, R 4.1.2
* win-builder (devel)
* Github Actions with 
    * windows-latest (release)
    * macOS-latest (release)
    * ubuntu-20.04 (release)
    * ubuntu-20.04 (devel)

## Submission note

* The content of variables in municipality keys related to hyvinvointialue (Wellbeing Service Counties) is changed and matches now the classification by Statistics Finland
* New function `get_municipality_pop()` added for getting population numbers with spatial data of Finnish municipalities from years 2010-2020
* Function `get_zipcodes()` has a new argument `extend_to_sea_areas` in case you need spatial data the extend further than the coastline

## R CMD check results

0 errors | 0 warnings | 0 note

## Downstream dependencies

There are currently no downstream dependencies for this package.



