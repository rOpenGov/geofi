#/home/lei/bin/R CMD BATCH document.R
~/bin/R-3.6.2/bin/R CMD build ../../ # --no-build-vignettes
~/bin/R-3.6.2/bin/R CMD check --as-cran 0.9.2800002
~/bin/R-3.6.2/bin/R CMD INSTALL 0.9.2800002
