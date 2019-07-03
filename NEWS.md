## CHANGES IN VERSION 0.10 (2019-06-25)

+ Reboot of `gisfin`.

### New features

+ All WFSs (provider, URL, version) are now listed in 
  `inst/extdata/wfs_providers.yaml`. This separation of data and code hopefully
  makes it easier to manage the data and to use it consistently in different 
  parts of the package (e.g. actual code and tests).