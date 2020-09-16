#/home/lei/bin/R CMD BATCH document.R
~/bin/R-4.0.0/bin/R CMD build ../../ # --no-build-vignettes
~/bin/R-4.0.0/bin/R CMD check --as-cran geofi_0.9.2900006.tar.gz
~/bin/R-4.0.0/bin/R CMD INSTALL geofi_0.9.2900006.tar.gz
