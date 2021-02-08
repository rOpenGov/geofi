library(devtools)
document("../../")

library(knitr)
knit(input = "../../README.Rmd", output = "../../README.md")

# build the ../../docs directory as a pkg website
library(pkgdown)
setwd("../../")
devtools::build_vignettes()
build_site()


