\name{get_MML}
\alias{get_MML}
\title{get_MML}
\usage{
get_MML(map.id, data.id, verbose = TRUE)
}
\arguments{
  \item{map.id}{data ID. See details.}

  \item{data.id}{data ID. See details.}

  \item{verbose}{verbose}
}
\value{
url connection
}
\description{
get_MML
}
\details{
See help(MML). To browse for RData options, see
https://github.com/avoindata/mml/tree/master/rdata or in R:
list_mml_datasets()
}
\examples{
# datasets <- list_mml_datasets();
          # map.id = names(datasets)[[1]];
          # data.id <- datasets[[map.id]][[1]];
          # sp <- get_MML(map.id, data.id)
}
\author{
Leo Lahti \email{louhos@googlegroups.com}
}
\references{
See citation("sorvi")
}
\keyword{utilities}

