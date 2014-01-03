# This file is a part of rOpenGov (http://ropengov.github.io)

# Copyright (C) 2010-2013 Leo Lahti, Juuso Parkkinen and Joona Lehtomaki <ropengov.github.com>. 
# All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


.onAttach <- function(lib, pkg)
{

  # This may help with encodings in Mac/Linux
  # Sys.setlocale(locale = "UTF-8")
  # Sys.setlocale(locale = "WINDOWS-1252")

  packageStartupMessage("gisfi R package: tools for open GIS data for Finland. This R package is part of rOpenGov <ropengov.github.io>. Copyright (C) 2010-2013 Leo Lahti, Juuso Parkkinen and Joona Lehtomaki. This is free software. You are free to use, modify and redistribute it under the FreeBSD license.")

}
