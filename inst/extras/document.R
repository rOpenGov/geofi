library(devtools)
document("../../")

library(knitr)
knit(input = "../../README.Rmd", output = "../../README.md")

# build the ../../docs directory as a pkg website
library(pkgdown)
setwd("../../")
build_site()


