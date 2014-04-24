/usr/bin/R CMD BATCH document.R
/usr/bin/R CMD build ../../
/usr/bin/R CMD check --as-cran fingis_0.9.1.tar.gz
/usr/bin/R CMD INSTALL fingis_0.9.1.tar.gz
