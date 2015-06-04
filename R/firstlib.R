.onAttach <- function(lib, pkg)
{

  # This may help with encodings in Mac/Linux
  # Sys.setlocale(locale = "UTF-8")
  # Sys.setlocale(locale = "WINDOWS-1252")

  packageStartupMessage("\ngisfin R package: tools for open GIS data for Finland.\nPart of rOpenGov <ropengov.github.io>. Kindly cite the work, see citation("gisfin").")

}
