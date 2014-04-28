\name{get_MML}
\alias{get_MML}
\title{MML (Land Survey Finland) data}
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
Retrieve data from Land Survey Finland (Maanmittauslaitos,
MML)
}
\details{
To browse for RData options, run list_mml_datasets() or see
https://github.com/avoindata/mml/tree/master/rdata.
}
\examples{
datasets <- list_mml_datasets();
          map.id = names(datasets)[[1]];
          data.id <- datasets[[map.id]][[1]];
          sp <- get_MML(map.id, data.id)
}
\author{
Leo Lahti \email{louhos@googlegroups.com}
}
\references{
See citation("fingis")
}

