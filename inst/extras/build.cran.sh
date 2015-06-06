/usr/local/bin/R CMD BATCH document.R
/usr/local/bin/R CMD build ../../
/usr/local/bin/R CMD check --as-cran gisfin_0.9.25.tar.gz
/usr/local/bin/R CMD INSTALL gisfin_0.9.25.tar.gz
