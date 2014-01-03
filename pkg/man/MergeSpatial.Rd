\name{MergeSpatial}
\alias{MergeSpatial}
\title{Merge a list of Spatial*DataFrame objects into one Spatial*DataFrame}
\usage{
  MergeSpatial(sp.list, CRS = NA, FID = NA)
}
\arguments{
  \item{sp.list}{A list of Spatial*DataFrame objects to be
  merged}

  \item{CRS}{A proj4string definign target CRS for the
  target Spatial*DataFrame object}

  \item{FID}{A string that names the column used as FID}
}
\value{
  a list of Shape objects (from SpatialPolygonsDataFrame
  class)
}
\description{
  Several independent Spatatial*DataFrame objects held in a
  list can be merged into one object as long as all are of
  the same class. CRS projections will be performed if
  target CRS is provided. If CRS is not provided, the CRS
  of the first object will be used. If even one object is
  missing a CRS, no projections are performed and there is
  no guarantee that merge will produce desired outcome.
}
\details{
  All schemas must match, a schema is checked on the basis
  of column names. An optional FID string can be give to
  name for a field (column) in table schema that will be
  used as FIDs. It's up to the user to check that FID
  values are unique.
}
\note{
  Not tested (at all)
}
\author{
  Joona Lehtomaki \email{louhos@googlegroups.com}
}
\references{
  See citation("sorvi")
}
\seealso{
  spChFIDs, spRbind
}

