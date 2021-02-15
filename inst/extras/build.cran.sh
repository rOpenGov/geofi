#/home/lei/bin/R CMD BATCH document.R
~/bin/R-beta/bin/R CMD build ../../ --no-build-vignettes
~/bin/R-beta/bin/R CMD check --as-cran geofi_1.0.0.tar.gz
~/bin/R-beta/bin/R CMD INSTALL geofi_1.0.0.tar.gz

