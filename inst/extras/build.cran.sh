/usr/bin/R CMD BATCH document.R
/usr/bin/R CMD build ../../
/usr/bin/R CMD check --as-cran gisfin_0.9.18.tar.gz
/usr/bin/R CMD INSTALL gisfin_0.9.18.tar.gz
