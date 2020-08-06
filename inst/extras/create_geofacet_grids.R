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

grid_mk_2020 <- grid_mk_2019
save(grid_mk_2020, file = "./data/grid_mk_2020.rda",
     compress = "bzip2")

# Municipalities per region


# Lappi ------------------------------------------------
mygrid <- data.frame(
  code = c("47", "890", "148", "498", "742", "758", "261", "273", "583", "698", "854", "320", "732", "976", "845", "241", "614", "683", "751", "240", "851"),
  name = c("Enontekiö", "Utsjoki", "Inari", "Muonio", "Savukoski", "Sodankylä", "Kittilä", "Kolari", "Pelkosenniemi", "Rovaniemi", "Pello", "Kemijärvi", "Salla", "Ylitornio", "Tervola", "Keminmaa", "Posio", "Ranua", "Simo", "Kemi", "Tornio"),
  row = c(1, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6),
  col = c(1, 3, 4, 1, 5, 3, 2, 1, 4, 3, 1, 4, 5, 2, 2, 1, 4, 3, 3, 2, 1),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_lappi_2019 <- mygrid
save(grid_lappi_2019, file = "./data/grid_lappi_2019.rda",
     compress = "bzip2")

grid_lappi_2020 <- grid_lappi_2019
save(grid_lappi_2020, file = "./data/grid_lappi_2020.rda",
     compress = "bzip2")


# Pohjois-Pohjanmaa -------------------------------------------- |
mygrid <- data.frame(
  code = c("305", "832", "615", "139", "564", "889", "72", "494", "244", "436", "859", "425", "785", "748", "678", "630", "625", "791", "483", "208", "317", "563", "71", "535", "9", "626", "69", "977", "746", "691"),
  name = c("Kuusamo", "Taivalkoski", "Pudasjärvi", "Ii", "Oulu", "Utajärvi", "Hailuoto", "Muhos", "Kempele", "Lumijoki", "Tyrnävä", "Liminka", "Vaala", "Siikajoki", "Raahe", "Pyhäntä", "Pyhäjoki", "Siikalatva", "Merijärvi", "Kalajoki", "Kärsämäki", "Oulainen", "Haapavesi", "Nivala", "Alavieska", "Pyhäjärvi", "Haapajärvi", "Ylivieska", "Sievi", "Reisjärvi"),
  row = c(1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 2, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 7, 7),
  col = c(4, 3, 2, 1, 2, 4, 1, 3, 4, 2, 5, 3, 5, 1, 2, 4, 1, 3, 2, 1, 5, 3, 4, 4, 2, 6, 5, 3, 3, 4),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_pohjois_pohjanmaa_2019 <- mygrid
save(grid_pohjois_pohjanmaa_2019, file = "./data/grid_pohjois_pohjanmaa_2019.rda",
     compress = "bzip2")

grid_pohjois_pohjanmaa_2020 <- grid_pohjois_pohjanmaa_2019
save(grid_pohjois_pohjanmaa_2020, file = "./data/grid_pohjois_pohjanmaa_2020.rda",
     compress = "bzip2")


# Kainuu -------------------------------------------- |
mygrid <- data.frame(
  code = c("105", "620", "578", "697", "777", "290", "765", "205"),
  name = c("Hyrynsalmi", "Puolanka", "Paltamo", "Ristijärvi", "Suomussalmi", "Kuhmo", "Sotkamo", "Kajaani"),
  row = c(1, 1, 2, 2, 1, 3, 3, 3),
  col = c(2, 1, 1, 2, 3, 3, 2, 1),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_kainuu_2019 <- mygrid
save(grid_kainuu_2019, file = "./data/grid_kainuu_2019.rda",
     compress = "bzip2")

grid_kainuu_2020 <- grid_kainuu_2019
save(grid_kainuu_2020, file = "./data/grid_kainuu_2020.rda",
     compress = "bzip2")


# Keski-Pohjanmaa -------------------------------------------- |
mygrid <- data.frame(
  code = c("217", "272", "849", "236", "74", "924", "421", "584"),
  name = c("Kannus", "Kokkola", "Toholampi", "Kaustinen", "Halsua", "Veteli", "Lestijärvi", "Perho"),
  row = c(1, 1, 2, 2, 3, 3, 3, 4),
  col = c(2, 1, 2, 1, 2, 1, 3, 2),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_keski_pohjanmaa_2019 <- mygrid
save(grid_keski_pohjanmaa_2019, file = "./data/grid_keski_pohjanmaa_2019.rda",
     compress = "bzip2")

grid_keski_pohjanmaa_2020 <- grid_keski_pohjanmaa_2019
save(grid_keski_pohjanmaa_2020, file = "./data/grid_keski_pohjanmaa_2020.rda",
     compress = "bzip2")

# Pohjanmaa ---------------------------------------------- |
mygrid <- data.frame(
  code = c("440", "598", "288", "599", "893", "946", "905", "499", "152", "399", "475", "280", "545", "231", "287"),
  name = c("Luoto", "Pietarsaari", "Kruunupyy", "Pedersören kunta", "Uusikaarlepyy", "Vöyri", "Vaasa", "Mustasaari", "Isokyrö", "Laihia", "Maalahti", "Korsnäs", "Närpiö", "Kaskinen", "Kristiinankaupunki"),
  row = c(1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4, 5, 5, 6),
  col = c(3, 2, 4, 3, 2, 3, 2, 1, 4, 3, 2, 1, 2, 1, 2),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_pohjanmaa_2019 <- mygrid
save(grid_pohjanmaa_2019, file = "./data/grid_pohjanmaa_2019.rda",
     compress = "bzip2")

grid_pohjanmaa_2020 <- grid_pohjanmaa_2019
save(grid_pohjanmaa_2020, file = "./data/grid_pohjanmaa_2020.rda",
     compress = "bzip2")


# Etelä-Pohjanmaa ---------------------------------------------- |
mygrid <- data.frame(
  code = c("233", "52", "403", "934", "759", "5", "408", "846", "145", "300", "743", "218", "10", "989", "301", "232", "151"),
  name = c("Kauhava", "Evijärvi", "Lappajärvi", "Vimpeli", "Soini", "Alajärvi", "Lapua", "Teuva", "Ilmajoki", "Kuortane", "Seinäjoki", "Karijoki", "Alavus", "Ähtäri", "Kurikka", "Kauhajoki", "Isojoki"),
  row = c(2, 2, 2, 2, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5),
  col = c(3, 4, 5, 6, 6, 5, 4, 2, 3, 5, 4, 1, 5, 6, 3, 2, 1),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)
mygrid$row <- mygrid$row - 1

grid_etela_pohjanmaa_2019 <- mygrid
save(grid_etela_pohjanmaa_2019, file = "./data/grid_etela_pohjanmaa_2019.rda",
     compress = "bzip2")

grid_etela_pohjanmaa_2020 <- grid_etela_pohjanmaa_2019
save(grid_etela_pohjanmaa_2020, file = "./data/grid_etela_pohjanmaa_2020.rda",
     compress = "bzip2")


# Keski-Suomi ---------------------------------------------- |
mygrid <- data.frame(
  code = c("265", "256", "312", "601", "931", "216", "226", "275", "495", "729", "992", "77", "410", "592", "249", "892", "850", "182", "500", "179", "172", "291", "435"),
  name = c("Kivijärvi", "Kinnula", "Kyyjärvi", "Pihtipudas", "Viitasaari", "Kannonkoski", "Karstula", "Konnevesi", "Multia", "Saarijärvi", "Äänekoski", "Hankasalmi", "Laukaa", "Petäjävesi", "Keuruu", "Uurainen", "Toivakka", "Jämsä", "Muurame", "Jyväskylä", "Joutsa", "Kuhmoinen", "Luhanka"),
  row = c(1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6),
  col = c(3, 4, 2, 5, 4, 3, 2, 5, 2, 3, 4, 5, 4, 2, 1, 3, 4, 1, 2, 3, 4, 2, 3),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_keski_suomi_2019 <- mygrid
save(grid_keski_suomi_2019, file = "./data/grid_keski_suomi_2019.rda",
     compress = "bzip2")

grid_keski_suomi_2020 <- grid_keski_suomi_2019
save(grid_keski_suomi_2020, file = "./data/grid_keski_suomi_2020.rda",
     compress = "bzip2")

# Pohjois-Savo ---------------------------------------------- |
mygrid <- data.frame(
  code = c("263", "925", "762", "140", "402", "687", "595", "239", "749", "921", "844", "204", "297", "857", "686", "778", "420", "915"),
  name = c("Kiuruvesi", "Vieremä", "Sonkajärvi", "Iisalmi", "Lapinlahti", "Rautavaara", "Pielavesi", "Keitele", "Siilinjärvi", "Vesanto", "Tervo", "Kaavi", "Kuopio", "Tuusniemi", "Rautalampi", "Suonenjoki", "Leppävirta", "Varkaus"),
  row = c(2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 6),
  col = c(1, 2, 4, 3, 4, 5, 2, 1, 3, 1, 2, 5, 3, 4, 2, 3, 4, 4),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)
mygrid$row <- mygrid$row - 1

grid_pohjois_savo_2019 <- mygrid
save(grid_pohjois_savo_2019, file = "./data/grid_pohjois_savo_2019.rda",
     compress = "bzip2")

grid_pohjois_savo_2020 <- grid_pohjois_savo_2019
save(grid_pohjois_savo_2020, file = "./data/grid_pohjois_savo_2020.rda",
     compress = "bzip2")



# Pohjois-Karjala ---------------------------------------------- |
mygrid <- data.frame(
  code = c("422", "911", "541", "176", "309", "607", "276", "146", "426", "167", "707", "848", "260"),
  name = c("Lieksa", "Valtimo", "Nurmes", "Juuka", "Outokumpu", "Polvijärvi", "Kontiolahti", "Ilomantsi", "Liperi", "Joensuu", "Rääkkylä", "Tohmajärvi", "Kitee"),
  row = c(2, 1, 1, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6),
  col = c(3, 1, 2, 2, 1, 2, 3, 4, 2, 3, 2, 3, 3),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_pohjois_karjala_2019 <- mygrid
save(grid_pohjois_karjala_2019, file = "./data/grid_pohjois_karjala_2019.rda",
     compress = "bzip2")

# Valtimo was merged with Nurmes in 2020
mygrid <- data.frame(
  code = c("422", "541", "176", "309", "607", "276", "146", "426", "167", "707", "848", "260"),
  name = c("Lieksa", "Nurmes", "Juuka", "Outokumpu", "Polvijärvi", "Kontiolahti", "Ilomantsi", "Liperi", "Joensuu", "Rääkkylä", "Tohmajärvi", "Kitee"),
  row = c(2, 1, 2, 3, 3, 3, 4, 4, 4, 5, 5, 6),
  col = c(3, 2, 2, 1, 2, 3, 4, 2, 3, 2, 3, 3),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_pohjois_karjala_2020 <- mygrid
save(grid_pohjois_karjala_2020, file = "./data/grid_pohjois_karjala_2020.rda",
     compress = "bzip2")

# Satakunta ---------------------------------------------- |
mygrid <- data.frame(
  code = c("99", "484", "747", "230", "181", "214", "608", "609", "886", "271", "79", "531", "51", "102", "783", "50", "684"),
  name = c("Honkajoki", "Merikarvia", "Siikainen", "Karvia", "Jämijärvi", "Kankaanpää", "Pomarkku", "Pori", "Ulvila", "Kokemäki", "Harjavalta", "Nakkila", "Eurajoki", "Huittinen", "Säkylä", "Eura", "Rauma"),
  row = c(1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4),
  col = c(3, 1, 2, 4, 4, 3, 2, 1, 3, 5, 4, 2, 1, 4, 3, 2, 1),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_satakunta_2019 <- mygrid
save(grid_satakunta_2019, file = "./data/grid_satakunta_2019.rda",
     compress = "bzip2")

grid_satakunta_2020 <- grid_satakunta_2019
save(grid_satakunta_2020, file = "./data/grid_satakunta_2020.rda",
     compress = "bzip2")


# Pirkanmaa ---------------------------------------------- |
mygrid <- data.frame(
  code = c("250", "581", "936", "508", "108", "143", "702", "980", "177", "562", "604", "837", "536", "211", "635", "418", "922", "790", "908", "20", "887", "619"),
  name = c("Kihniö", "Parkano", "Virrat", "Mänttä-Vilppula", "Hämeenkyrö", "Ikaalinen", "Ruovesi", "Ylöjärvi", "Juupajoki", "Orivesi", "Pirkkala", "Tampere", "Nokia", "Kangasala", "Pälkäne", "Lempäälä", "Vesilahti", "Sastamala", "Valkeakoski", "Akaa", "Urjala", "Punkalaidun"),
  row = c(1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5),
  col = c(3, 2, 4, 5, 2, 1, 4, 3, 5, 4, 2, 3, 1, 4, 5, 3, 2, 1, 5, 4, 3, 2),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_pirkanmaa_2019 <- mygrid
save(grid_pirkanmaa_2019, file = "./data/grid_pirkanmaa_2019.rda",
     compress = "bzip2")

grid_pirkanmaa_2020 <- grid_pirkanmaa_2019
save(grid_pirkanmaa_2020, file = "./data/grid_pirkanmaa_2020.rda",
     compress = "bzip2")


# Päijät-Häme ---------------------------------------------- |
mygrid <- data.frame(
  code = c("81", "781", "576", "111", "16", "398", "98", "560", "316"),
  name = c("Hartola", "Sysmä", "Padasjoki", "Heinola", "Asikkala", "Lahti", "Hollola", "Orimattila", "Kärkölä"),
  row = c(1, 1, 1, 2, 2, 3, 3, 4, 4),
  col = c(3, 2, 1, 3, 2, 3, 2, 3, 2),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_paijat_hame_2019 <- mygrid
save(grid_paijat_hame_2019, file = "./data/grid_paijat_hame_2019.rda",
     compress = "bzip2")

grid_paijat_hame_2020 <- grid_paijat_hame_2019
save(grid_paijat_hame_2020, file = "./data/grid_paijat_hame_2020.rda",
     compress = "bzip2")

# Etelä-Savo ---------------------------------------------- |
mygrid <- data.frame(
  code = c("90", "46", "171", "213", "593", "681", "740", "178", "491", "97", "768", "623", "507", "588"),
  name = c("Heinävesi", "Enonkoski", "Joroinen", "Kangasniemi", "Pieksämäki", "Rantasalmi", "Savonlinna", "Juva", "Mikkeli", "Hirvensalmi", "Sulkava", "Puumala", "Mäntyharju", "Pertunmaa"),
  row = c(1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4),
  col = c(5, 5, 3, 1, 2, 4, 5, 3, 2, 1, 4, 3, 2, 1),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_etela_savo_2019 <- mygrid
save(grid_etela_savo_2019, file = "./data/grid_etela_savo_2019.rda",
     compress = "bzip2")

grid_etela_savo_2020 <- grid_etela_savo_2019
save(grid_etela_savo_2020, file = "./data/grid_etela_savo_2020.rda",
     compress = "bzip2")

# Varsinais-Suomi ---------------------------------------------- |
mygrid <- data.frame(
  code = c("400", "631", "503", "430", "561", "636", "284", "19", "538", "895", "918", "761", "480", "704", "423", "481", "304", "833", "680", "577", "202", "529", "853", "734", "445", "738", "322"),
  name = c("Laitila", "Pyhäranta", "Mynämäki", "Loimaa", "Oripää", "Pöytyä", "Koski Tl", "Aura", "Nousiainen", "Uusikaupunki", "Vehmaa", "Somero", "Marttila", "Rusko", "Lieto", "Masku", "Kustavi", "Taivassalo", "Raisio", "Paimio", "Kaarina", "Naantali", "Turku", "Salo", "Parainen", "Sauvo", "Kemiönsaari"),
  row = c(1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 5, 5, 6),
  col = c(2, 1, 3, 6, 5, 4, 6, 4, 3, 1, 2, 7, 5, 4, 5, 3, 1, 2, 2, 5, 4, 1, 3, 6, 3, 4, 4),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_varsinais_suomi_2019 <- mygrid
save(grid_varsinais_suomi_2019, file = "./data/grid_varsinais_suomi_2019.rda",
     compress = "bzip2")

grid_varsinais_suomi_2020 <- grid_varsinais_suomi_2019
save(grid_varsinais_suomi_2020, file = "./data/grid_varsinais_suomi_2020.rda",
     compress = "bzip2")

# Kanta-Häme ---------------------------------------------- |
mygrid <- data.frame(
  code = c("82", "103", "109", "61", "86", "165", "169", "694", "433", "834", "981"),
  name = c("Hattula", "Humppila", "Hämeenlinna", "Forssa", "Hausjärvi", "Janakkala", "Jokioinen", "Riihimäki", "Loppi", "Tammela", "Ypäjä"),
  row = c(1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3),
  col = c(3, 1, 4, 2, 4, 3, 1, 4, 3, 2, 1),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_kanta_hame_2019 <- mygrid
save(grid_kanta_hame_2019, file = "./data/grid_kanta_hame_2019.rda",
     compress = "bzip2")

grid_kanta_hame_2020 <- grid_kanta_hame_2019
save(grid_kanta_hame_2020, file = "./data/grid_kanta_hame_2020.rda",
     compress = "bzip2")


# Kymenlaakso ---------------------------------------------- |
mygrid <- data.frame(
  code = c("142", "286", "489", "624", "285", "75", "935"),
  name = c("Iitti", "Kouvola", "Miehikkälä", "Pyhtää", "Kotka", "Hamina", "Virolahti"),
  row = c(1, 1, 1, 2, 2, 2, 2),
  col = c(1, 2, 4, 1, 2, 3, 4),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_kymenlaakso_2019 <- mygrid
save(grid_kymenlaakso_2019, file = "./data/grid_kymenlaakso_2019.rda",
     compress = "bzip2")

grid_kymenlaakso_2020 <- grid_kymenlaakso_2019
save(grid_kymenlaakso_2020, file = "./data/grid_kymenlaakso_2020.rda",
     compress = "bzip2")


# Etelä-Karjala ---------------------------------------------- |
mygrid <- data.frame(
  code = c("580", "700", "689", "739", "153", "831", "416", "441", "405"),
  name = c("Parikkala", "Ruokolahti", "Rautjärvi", "Savitaipale", "Imatra", "Taipalsaari", "Lemi", "Luumäki", "Lappeenranta"),
  row = c(1, 2, 2, 3, 3, 2, 3, 4, 4),
  col = c(3, 2, 3, 1, 3, 1, 2, 1, 2),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_etela_karjala_2019 <- mygrid
save(grid_etela_karjala_2019, file = "./data/grid_etela_karjala_2019.rda",
     compress = "bzip2")

grid_etela_karjala_2020 <- grid_etela_karjala_2019
save(grid_etela_karjala_2020, file = "./data/grid_etela_karjala_2020.rda",
     compress = "bzip2")


# Ahvenanmaa ---------------------------------------------- |
mygrid <- data.frame(
  code = c("35", "43", "736", "65", "941", "60", "76", "771", "295", "170", "438", "478", "766", "417", "62", "318"),
  name = c("Brändö", "Eckerö", "Saltvik", "Geta", "Vårdö", "Finström", "Hammarland", "Sund", "Kumlinge", "Jomala", "Lumparland", "Maarianhamina", "Sottunga", "Lemland", "Föglö", "Kökar"),
  row = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4),
  col = c(5, 1, 3, 2, 4, 2, 1, 3, 4, 2, 3, 1, 4, 2, 3, 4),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)

grid_ahvenanmaa_2019 <- mygrid
save(grid_ahvenanmaa_2019, file = "./data/grid_ahvenanmaa_2019.rda",
     compress = "bzip2")

grid_ahvenanmaa_2020 <- grid_ahvenanmaa_2019
save(grid_ahvenanmaa_2020, file = "./data/grid_ahvenanmaa_2020.rda",
     compress = "bzip2")

# Uusimaa ---------------------------------------------- |
mygrid <- data.frame(
  code = c("616", "505", "504", "106", "224", "186", "407", "18", "611", "245", "858", "543", "444", "927", "235", "434", "638", "753", "92", "257", "755", "149", "710", "49", "91", "78"),
  name = c("Pukkila", "Mäntsälä", "Myrskylä", "Hyvinkää", "Karkkila", "Järvenpää", "Lapinjärvi", "Askola", "Pornainen", "Kerava", "Tuusula", "Nurmijärvi", "Lohja", "Vihti", "Kauniainen", "Loviisa", "Porvoo", "Sipoo", "Vantaa", "Kirkkonummi", "Siuntio", "Inkoo", "Raasepori", "Espoo", "Helsinki", "Hanko"),
  row = c(2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6),
  col = c(8, 7, 8, 5, 3, 7, 9, 9, 8, 7, 6, 5, 3, 4, 5, 9, 8, 7, 6, 4, 3, 2, 1, 5, 6, 1),
  stringsAsFactors = FALSE
)
geofacet::grid_preview(mygrid)
mygrid$row <- mygrid$row - 1

grid_uusimaa_2019 <- mygrid
save(grid_uusimaa_2019, file = "./data/grid_uusimaa_2019.rda",
     compress = "bzip2")

grid_uusimaa_2020 <- grid_uusimaa_2019
save(grid_uusimaa_2020, file = "./data/grid_uusimaa_2020.rda",
     compress = "bzip2")


# use the code below as geograhical reference map
geofi::municipality_key_2019 %>%
  filter(grepl("^Pohjois-Sa", mk_name)) %>%
  count(kunta,kunta_name) %>%
  select(-n) %>%
  setNames(c("code","name")) -> tmp
write.csv(tmp, "tmp.csv", row.names = FALSE)
file.edit("./tmp.csv")
grid_design()

muni <- get_municipalities()
muni %>%
  mutate(kunta = as.integer(sub("^0+", "", kunta))) %>%
  filter(kunta %in% tmp$code) %>%
  ggplot() +
  geom_sf() +
  geom_sf_text(aes(label = name))




