#/home/lei/bin/R CMD BATCH document.R
~/bin/R-3.6.0/bin/R CMD build ../../ # --no-build-vignettes
~/bin/R-3.6.0/bin/R CMD check --as-cran geofi_0.9.27.9004.tar.gz
~/bin/R-3.6.0/bin/R CMD INSTALL geofi_0.9.27.9004.tar.gz
