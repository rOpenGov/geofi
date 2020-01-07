# create regions (maakunta) grid for 2019
mygrid <- data.frame(
  mk_name = c("Lappi", "Kainuu", "Pohjois-Pohjanmaa", "Keski-Pohjanmaa", "Pohjanmaa", "Etelä-Pohjanmaa", "Pohjois-Savo", "Keski-Suomi", "Pohjois-Karjala", "Pirkanmaa", "Satakunta", "Etelä-Savo", "Päijät-Häme", "Kanta-Häme", "Etelä-Karjala", "Kymenlaakso", "Varsinais-Suomi", "Ahvenanmaa", "Uusimaa"),
  mk_code = c("19", "18", "17", "16", "15", "14", "11", "13", "12", "6", "4", "10", "7", "5", "9", "8", "2", "21", "1"),
  row = c(1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6),
  col = c(5, 6, 5, 4, 3, 3, 5, 4, 6, 4, 3, 6, 5, 4, 6, 5, 3, 3, 4),
  stringsAsFactors = FALSE
)
names(mygrid)[1:2] <- c("name","code")
mygrid$col <- mygrid$col-2
geofacet::grid_preview(mygrid)

grid_mk_2019 <- mygrid

save(grid_mk_2019, file = "./data/grid_mk_2019.rda",
     compress = "bzip2")

