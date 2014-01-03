~/bin/R-3.0.1/bin/R CMD BATCH document.R
~/bin/R-3.0.1/bin/R CMD check pkg --as-cran
~/bin/R-3.0.1/bin/R CMD build pkg
~/bin/R-3.0.1/bin/R CMD INSTALL gisfi_0.9.02.tar.gz
