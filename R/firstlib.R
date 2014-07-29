# This file is a part of the helsinki package (http://github.com/rOpenGov/helsinki)
# in association with the rOpenGov project (ropengov.github.io)

# Copyright (C) 2010-2014 Juuso Parkkinen, Leo Lahti and Joona Lehtomäki / Louhos <louhos.github.com>. 
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

  packageStartupMessage("\ngisfin R package: tools for open GIS data for Finland.\nThis R package is part of rOpenGov <ropengov.github.io>.\nCopyright (C) 2010-2014 Juuso Parkkinen, Leo Lahti, Joona Lehtomaki, Janne Aukia and Jussi Jousimo.\nThis is free software. You are free to use, modify and redistribute it under the FreeBSD license.")

}
