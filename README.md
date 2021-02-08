<br> <!-- badges: start --> [![R build
status](https://github.com/rOpenGov/geofi//workflows/R-CMD-check/badge.svg)](https://github.com/rOpenGov/geofi//actions)
[![Project Status: Active - The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build
Status](https://api.travis-ci.org/rOpenGov/geofi.png)](https://travis-ci.org/rOpenGov/geofi)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/rOpenGov/geofi?branch=master&svg=true)](https://ci.appveyor.com/project/rOpenGov/geofi)
[![codecov.io](https://codecov.io/github/rOpenGov/geofi/coverage.svg?branch=master)](https://codecov.io/github/rOpenGov/geofi?branch=master)
[![Gitter](https://badges.gitter.im/rOpenGov/geofi.svg)](https://gitter.im/rOpenGov/geofi?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![Watch on
GitHub](https://img.shields.io/github/watchers/ropengov/eurostat.svg?style=social)](https://github.com/ropengov/eurostat/watchers)
[![Star on
GitHub](https://img.shields.io/github/stars/ropengov/eurostat.svg?style=social)](https://github.com/ropengov/eurostat/stargazers)
[![Follow](https://img.shields.io/twitter/follow/ropengov.svg?style=social)](https://twitter.com/intent/follow?screen_name=ropengov)

<!--[![CRAN published](http://www.r-pkg.org/badges/version/geofi)](http://www.r-pkg.org/pkg/geofi)-->
<!--[![Downloads](http://cranlogs.r-pkg.org/badges/grand-total/geofi)](https://cran.r-project.org/package=geofi)-->
<!--[![Downloads](http://cranlogs.r-pkg.org/badges/geofi)](https://cran.r-project.org/package=geofi)-->
<!-- badges: end -->

<br>

# geofi - Finland GIS data for R

<!-- README.md is generated from README.Rmd. Please edit that file -->

Geospatial data from Finland for R.

### Installation and use

    # Install development version from GitHub
    remotes::install_github("ropengov/geofi")

With `geofi`-package you can download geospatial data on municipalities,
zipcodes and population and statistical grids from Statistics Finland
WFS-api. In addition, you have on-board municipality keys for
aggregating municipality-level data into higher level regional
distributions based Statistics Finland classification API.

    library(geofi)
    d1 <- get_municipalities(year = 2021)
    d2 <- get_zipcodes(year = 2021)
    d3 <- get_statistical_grid(resolution = 5)
    d4 <- get_population_grid(resolution = 5)

    library(ggplot2)
    theme_set(
      theme_minimal() +
      theme(legend.position= "none",
            axis.text = element_blank(),
            axis.title = element_blank(),
            panel.grid = element_blank()
            )
    )
    p1 <- ggplot(d1, aes(fill = kunta)) + geom_sf(colour = alpha("white", 1/3)) + labs(subtitle = "municipalities")
    p2 <- ggplot(d2, aes(fill = as.integer(posti_alue))) + geom_sf(colour = alpha("white", 1/3)) + labs(subtitle = "zipcodes")
    p3 <- ggplot(d3, aes(fill = nro)) + geom_sf(colour = alpha("white", 1/3)) + labs(subtitle = "statistical grid")
    p4 <- ggplot(d4, aes(fill = id_nro)) + geom_sf(colour = alpha("white", 1/3)) + labs(subtitle = "population grid")

    library(patchwork)
    wrap_plots(list(p1,p2,p3,p4), ncol = 2) + 
      patchwork::plot_annotation(title = "Spatial data in geofi-package")

![](README-readme_map-1.png)

For installation and usage, check the [tutorial
page](https://ropengov.github.io/geofi/articles/geofi_datasets.html).

### Contribute

Contributions are very welcome:

-   [Use issue tracker](https://github.com/ropengov/geofi/issues) for
    feedback and bug reports.
-   [Send pull requests](https://github.com/ropengov/geofi/)
-   [Star us on the Github page](https://github.com/ropengov/geofi)
-   [Join the discussion in Gitter](https://gitter.im/rOpenGov/geofi)

### Acknowledgements

**Kindly cite this work** as follows: [Markus
Kainu](https://github.com/muuankarski), [Joona
Lehtomäki](https://github.com/jlehtoma), Juuso Parkkinen, Jani
Miettinen, [Leo Lahti](https://github.com/antagomir) Retrieval and
analysis of open geospatial data from Finland with the geofi R package.
R package version 0.9.2900011. URL: <http://ropengov.github.io/geofi>

We are grateful to all
[contributors](https://github.com/rOpenGov/geofi/graphs/contributors),
including Juusi Parkkinen, Jussi Jousimo, Janne Aukia, Aaro Salosensaari
and Jani Miettinen. This project is part of
[rOpenGov](http://ropengov.github.io).
