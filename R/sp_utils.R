#' Merge a list of Spatial*DataFrame objects into one Spatial*DataFrame
#'
#' Several independent Spatatial*DataFrame objects held in a list can be merged
#' into one object as long as all are of the same class. CRS 
#' projections will be performed if target CRS is provided. If CRS is not 
#' provided, the CRS of the first object will be used. If even one object is 
#' missing a CRS, no projections are performed and there is no guarantee that
#' merge will produce desired outcome.
#'
#' All schemas must match, a schema is checked on the basis of column names. An
#' optional FID string can be give to name for a field (column) in table schema
#' that will be used as FIDs. It's up to the user to check that FID values are
#' unique.
#'
#' @param sp.list  A list of Spatial*DataFrame objects to be merged
#' @param CRS A proj4string definign target CRS for the target Spatial*DataFrame object
#' @param FID A string that names the column used as FID
#'
#' @return a list of Shape objects (from SpatialPolygonsDataFrame class)
#' @export
#' @seealso spChFIDs, spRbind
#' @references
#' See citation("sorvi") 
#' @author Joona Lehtomaki \email{louhos@@googlegroups.com}
#' @note Not tested (at all)

merge_spatial <- function(sp.list, CRS=NA, FID=NA) {
  
  allowed.classes <- c("SpatialPolygonsDataFrame", "SpatialPointsDataFrame",
                       "SpatialLinesDataFrame")
  
  # Test that all the objects in the list are of the same class
  # FIXME: what's the smartest way of testing whether an object is of a 
  # particular class?
  
  # Get the class of the first sp object in the list
  class.type <- class(sp.list[[1]])[[1]]
  
  # Only particular Spatial*DataFrame classes are allowed, here we check that the
  # class of the 1st object is allowed
  if (!class.type %in% allowed.classes) {
    stop(paste("All objects must be instances of one of the following classes: ",
               paste(allowed.classes, collapse=", ")))
  }
  
  # Check that all objects have the same class
  if(all(sapply(sp.list, function(x) is(x, class.type)))) {
    
    # Check that all objects have the same schema
    ref.schema <- sp.list[[1]]
    
    # Compare the schema of all the other objects
    # FIXME: now the first object is compared against itself, this is a bit 
    # stupid
    if(all(sapply(sp.list, function(x) .check.schema(ref.schema, x)))) {
      if (is.na(FID)) {
        # No FID field is provided, so create FID fields for all attribute
        # tables (data frames). FID values must be unique over all tables.
        row.fids <- 1:sum(sapply(sp.list, function(x) nrow(x)))
        for (sp.object in sp.list) {
          rows <- nrow(sp.object)
          FID <- row.fids[1:rows]
          sp.object@data <- spChFIDs(sp.object@data, FID)
          # Remove the used FIDs
          row.fids <- row.fids[rows:length(row.fids)]
        }
        return(do.call("spRbind", sp.list))
        
      } else {
        NULL
      }
    }
    
  } else {
    stop(paste("All objects must be instances of one of the following class: ",
               class.type))
  }
}


#' Split a Spatial*DataFrame object into a list of Spatial*DataFrames
#'
#' Subregions of a Spatial*DataFrame are splitted into a list based on a field
#' containing a identifier which must be a factor.
#'
#' No schema or CRS checking is performed as all the spatial information and 
#' geometries are coming from a common source.
#'
#' @param sp.object  A Spatial*DataFrame object to be splitted
#' @param split.field A string describing the identifier field for the subregions
#'
#' @return a list of Shape objects (from SpatialPolygonsDataFrame class)
#' @export
#' 
#' @references
#' See citation("sorvi") 
#' @author Joona Lehtomaki \email{louhos@@googlegroups.com}
#' @examples #

split_spatial <- function(sp.object, split.field) {
  
  allowed.classes <- c("SpatialPolygonsDataFrame", "SpatialPointsDataFrame",
                       "SpatialLinesDataFrame")
  
  # Only particular Spatial*DataFrame classes are allowed, here we check that the
  # class of the spatial object is allowed
  if (!class(sp.object) %in% allowed.classes) {
    stop(paste("Spatial object must be instances of one of the following classes: ",
               paste(allowed.classes, collapse=", ")))
  }
  
  # Check that the identifier field exists in the spatial object
  if (!split.field %in% names(sp.object)) {
    stop(paste("Identifier field", split.field, "not found in sp.object names."))
  }
  
  # Convert identifier field into a factor if it isn't one already
  sp.object[[split.field]] <- factor(sp.object[[split.field]])
  # Make sure that there are no dangling levels in the splitter field
  sp.object[[split.field]] <- droplevels(sp.object[[split.field]], 
                                         reorder=FALSE)
  # Get all the levels for the subregions
  sub.region.levels <- levels(sp.object[[split.field]])
  
  # Divide the spatial object into subregions
  sub.regions <- list()
  for (level in sub.region.levels) {
    sub.regions[level] <- sp.object[which(sp.object[[split.field]] == level),]
  }
  
  # Drop the unused levels in all the fields
  for (i in 1:length(sub.regions)) {
    sub.regions[[i]]@data <- droplevels(sub.regions[[i]]@data)
  }
  return(sub.regions)
}

.check.schema <- function(sp.object1, sp.object2) {
  
  # Check that both objects derive from Spatial
  if (!is(sp.object1) || !is(sp.object2)) {
    warning("Objects must derive from Spatial class")
    return(FALSE)
  }
  
  # First check that the attribute tables (data frames) have same number of cols
  if (length(sp.object1@data) != sp.object2@data) {
    warning("Spatial objects' data frames are different length")
    return(FALSE)
  } else {
    # Check the attribute tables have the same colnames
    if (names(sp.object1@data) == names(sp.object2@data)) {
      return(TRUE)
    } else {
      return(FALSE)
    }
  }
}

