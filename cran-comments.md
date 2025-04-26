## Test environments
* local Ubuntu 24.04.1 install, R 4.5.0
* win-builder (devel)
* r-hub.io

## Submission note

+ PROJ 9.6.0 (announced here https://lists.osgeo.org/pipermail/proj/2025-March/011738.html) added support for EUREF-FIN in Finish transformations in their new NKG transformations. This resulted in issues with on-board `municipality_central_localities` in systems where `sf` is built with PROJ-version >= 9.6.0. This is now addressed so that `municipality_central_localities` is created using proj 9.6.0 and therefore 'EUREF-FIN / TM35FIN(E,N)' ESPG:3067. If user has PROJ version lower than 9.6.0, CRS of municipality_central_localities will be modified to `ETRS89/TM35FIN(E,N)` at package load and user is prompted accordingly.

## R CMD check results

0 errors | 0 warnings | 1 note

## Downstream dependencies

There are currently no downstream dependencies for this package.

