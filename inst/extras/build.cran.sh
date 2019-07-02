#/home/lei/bin/R CMD BATCH document.R
~/bin/R-3.6.0/bin/R CMD build ../../ # --no-build-vignettes
~/bin/R-3.6.0/bin/R CMD check --as-cran gisfin_0.9.27.9002.tar.gz
~/bin/R-3.6.0/bin/R CMD INSTALL gisfin_0.9.27.9002.tar.gz
