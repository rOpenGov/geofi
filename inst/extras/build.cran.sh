/home/lei/bin/R CMD BATCH document.R
/home/lei/bin/R CMD build ../../ # --no-build-vignettes
/home/lei/bin/R CMD check --as-cran gisfin_0.10.9000.tar.gz
/home/lei/bin/R CMD INSTALL gisfin_0.10.9000.tar.gz
