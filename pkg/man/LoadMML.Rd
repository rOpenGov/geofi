\name{LoadMML}
\alias{LoadMML}
\title{LoadMML}
\usage{
  LoadMML(map.id, data.id, verbose = TRUE)
}
\arguments{
  \item{map.id}{data ID. See details.}

  \item{data.id}{data ID. See details.}

  \item{verbose}{verbose

  Return:}
}
\value{
  url connection
}
\description{
  Arguments:
}
\details{
  See help(MML). To browse for RData options, see
  https://github.com/avoindata/mml/tree/master/rdata or in
  R: list_mml_datasets()
}
\examples{
# datasets <- list_mml_datasets(); map.id = names(datasets)[[1]]; data.id <- datasets[[map.id]][[1]]; sp <- LoadMML(map.id, data.id)
}
\author{
  Leo Lahti \email{louhos@googlegroups.com}
}
\references{
  See citation("sorvi")
}
\keyword{utilities}

