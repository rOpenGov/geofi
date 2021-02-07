#' A simple feature point data containing locations of municipalities central localities
#'
#' Data is extracted from latest version (January 2021) of Topographic Database (Maastotietokanta) by National Land Survey of Finland (Maanmittauslaitos)
#'
#' @format A simple feature POINT data with 311 rows and 17 variables:
#' \describe{
#'   \item{id}{id}
#'   \item{mtk_id}{mtk_id}
#'   \item{sijaintitarkkuus}{location precision}
#'   \item{aineistolahde}{data source}
#'   \item{alkupvm}{start date}
#'   \item{teksti}{Municipality name}
#'   \item{suunta}{direction}
#'   \item{dx}{dx}
#'   \item{dy}{dy}
#'   \item{kohdeluokka}{kohdeluokka}
#'   \item{ladontatunnus}{ladontatunnus}
#'   \item{kirjasintyyppikoodi}{kirjasintyyppikoodi}
#'   \item{kirjasinkoko}{kirjasinkoko}
#'   \item{kirjasinvarikoodi}{kirjasinvarikoodi}
#'   \item{kirjasinkallistuskulma}{kirjasinkallistuskulma}
#'   \item{kirjasinvalyskerroin}{kirjasinvalyskerroin}
#'   \item{kuntatunnus}{municipality code}
#'   \item{geom}{geom}
#' }
"municipality_central_localities"



#' custom geofacet grid for health care districts as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 21 rows and 4 variables:
#' \describe{
#'   \item{name}{District name (Sairaanhoitopiiri) in Finnish}
#'   \item{code}{District code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_sairaanhoitop_2019"

#'
#' custom geofacet grid for regions as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet

#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Region name (maakunta) in Finnish}
#'   \item{code}{Region code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_maakunta_2019"

#' custom geofacet grid for Ahvenanmaa region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_ahvenanmaa_2020"

#' custom geofacet grid for Etelä-Karjala region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_etela_karjala_2020"

#' custom geofacet grid for Etelä-Pohjanmaa region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_etela_pohjanmaa_2020"

#' custom geofacet grid for Etelä-Savo region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_etela_savo_2020"

#' custom geofacet grid for Kainuu region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_kainuu_2020"

#' custom geofacet grid for Kanta-Häme region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_kanta_hame_2020"

#' custom geofacet grid for Keski-Pohjanmaa region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_keski_pohjanmaa_2020"

#' custom geofacet grid for Keski-Suomi region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_keski_suomi_2020"

#' custom geofacet grid for Kymenlaakso region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_kymenlaakso_2020"

#' custom geofacet grid for Lappi region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_lappi_2020"

#' custom geofacet grid for Päijät-Häme region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_paijat_hame_2020"

#' custom geofacet grid for Pirkanmaa region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_pirkanmaa_2020"

#' custom geofacet grid for Pohjanmaa region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_pohjanmaa_2020"

#' custom geofacet grid for Pohjois-Karjala region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 18 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_pohjois_karjala_2020"

#' custom geofacet grid for Pohjois-Pohjanmaa region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_pohjois_pohjanmaa_2020"

#' custom geofacet grid for Pohjois-Savo region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_pohjois_savo_2020"

#' custom geofacet grid for Satakunta region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_satakunta_2020"

#' custom geofacet grid for Uusimaa region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_uusimaa_2020"

#' custom geofacet grid for Varsinais-Suomi region as in 2020
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_varsinais_suomi_2020"

#' custom geofacet grid for Ahvenanmaa region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_ahvenanmaa_2019"

#' custom geofacet grid for Etelä-Karjala region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_etela_karjala_2019"

#' custom geofacet grid for Etelä-Pohjanmaa region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_etela_pohjanmaa_2019"

#' custom geofacet grid for Etelä-Savo region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_etela_savo_2019"

#' custom geofacet grid for Kainuu region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_kainuu_2019"

#' custom geofacet grid for Kanta-Häme region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_kanta_hame_2019"

#' custom geofacet grid for Keski-Pohjanmaa region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_keski_pohjanmaa_2019"

#' custom geofacet grid for Keski-Suomi region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_keski_suomi_2019"

#' custom geofacet grid for Kymenlaakso region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_kymenlaakso_2019"

#' custom geofacet grid for Lappi region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_lappi_2019"

#' custom geofacet grid for Päijät-Häme region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_paijat_hame_2019"

#' custom geofacet grid for Pirkanmaa region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_pirkanmaa_2019"

#' custom geofacet grid for Pohjanmaa region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_pohjanmaa_2019"

#' custom geofacet grid for Pohjois-Karjala region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_pohjois_karjala_2019"

#' custom geofacet grid for Pohjois-Pohjanmaa region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_pohjois_pohjanmaa_2019"

#' custom geofacet grid for Pohjois-Savo region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_pohjois_savo_2019"

#' custom geofacet grid for Satakunta region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_satakunta_2019"

#' custom geofacet grid for Uusimaa region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_uusimaa_2019"

#' custom geofacet grid for Varsinais-Suomi region as in 2019
#'
#' Grid table to be used with ggplot2 and geofacet
#'
#' @format A data frame with 19 rows and 4 variables:
#' \describe{
#'   \item{name}{Municipality name (kunta) in Finnish}
#'   \item{code}{Municipality code}
#'   \item{row}{Vertical location in grid}
#'   \item{col}{Horizontal location in grid}
#' }
"grid_varsinais_suomi_2019"

#' Aggregated municipality key table for years 2013-2020
#'
#' Table for aggregating municipality level data to various regional groupings
#'
#' @format A data frame with 2519 rows and 71 variables:
#' \describe{
#'   \item{kunta}{Municipality code}
#'   \item{municipality_name_fi}{Municipality name in Finnish}
#'   \item{municipality_name_sv}{Municipality name in Swedish}
#'   \item{municipality_name_en}{Municipality name in English}
#'   \item{kuntaryhmitys_code}{Tilastollinen kuntaryhmitys (Statistical grouping) code}
#'   \item{kuntaryhmitys_name_fi}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Finnish}
#'   \item{kuntaryhmitys_name_sv}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Swedish}
#'   \item{kuntaryhmitys_name_en}{Tilastollinen kuntaryhmitys (Statistical grouping) name in English}
#'   \item{avi_code}{Aluehallintovirasto code (Regional State Administrative Agencies)}
#'   \item{avi_name_fi}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_sv}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_en}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen code (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_fi}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Finnish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_sv}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Swedish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_en}{Elinkeino-, liikenne- ja ympäristökeskuksen name in English (Centre for Economic Development, Transport and the Environment)}
#'   \item{maakunta_code}{Maakunta code (Regions of Finland)}
#'   \item{maakunta_name_fi}{Maakunta name in Finnish (Regions of Finland)}
#'   \item{maakunta_name_sv}{Maakunta name in Swedish (Regions of Finland)}
#'   \item{maakunta_name_en}{Maakunta name in English (Regions of Finland)}
#'   \item{kielisuhde_code}{Kielisuhde code (Language distribution 2020)}
#'   \item{kielisuhde_name_fi}{Kielisuhde name in Finnish (Language distribution 2020)}
#'   \item{kielisuhde_name_sv}{Kielisuhde name in Swedish (Language distribution 2020)}
#'   \item{kielisuhde_name_en}{Kielisuhde name in English (Language distribution 2020)}
#'   \item{seutukunta_code}{Seutukunta code (Sub-regions of Finland)}
#'   \item{seutukunta_name_fi}{Seutukunta name in Finnish (Sub-regions of Finland)}
#'   \item{seutukunta_name_sv}{Seutukunta name in Swedish (Sub-regions of Finland)}
#'   \item{seutukunta_name_en}{Seutukunta name in English (Sub-regions of Finland)}
#'   \item{year}{data year}
#'   \item{suuralue_code}{Suuralue code}
#'   \item{suuralue_name_fi}{Suuralueen nimi in Finnish (Large Areas)}
#'   \item{suuralue_name_sv}{Suuralueen nimi in Swedish (Large Areas)}
#'   \item{suuralue_name_en}{Suuralueen nimi in English (Large Areas)}
#'   \item{sairaanhoitop_code}{Sairaanhoitopiiri code (Health care districts)}
#'   \item{sairaanhoitop_name_fi}{Sairaanhoitopiiri name in Finnish (Health care districts)}
#'   \item{sairaanhoitop_name_sv}{Sairaanhoitopiiri name in Swedish (Health care districts)}
#'   \item{sairaanhoitop_name_en}{Sairaanhoitopiiri name in English (Health care districts)}
#'   \item{nuts1_code}{NUTS 2016 classification code (level 1)}
#'   \item{nuts1_name_fi}{NUTS 2016 classification name in Finnish (level 1)}
#'   \item{nuts1_name_sv}{NUTS 2016 classification name in Swedish (level 1)}
#'   \item{nuts1_name_en}{NUTS 2016 classification name in English (level 1)}
#'   \item{nuts2_code}{NUTS 2016 classification code (level 2)}
#'   \item{nuts2_name_fi}{NUTS 2016 classification name in Finnish (level 2)}
#'   \item{nuts2_name_sv}{NUTS 2016 classification name in Swedish (level 2)}
#'   \item{nuts2_name_en}{nuts2_name_en}
#'   \item{nuts3_code}{NUTS 2016 classification code (level 2)}
#'   \item{nuts3_name_fi}{NUTS 2016 classification name in Finnish (level 3)}
#'   \item{nuts3_name_sv}{NUTS 2016 classification name in Swedish (level 3)}
#'   \item{nuts3_name_en}{NUTS 2016 classification name in English (level 3)}
#'   \item{tyossakayntial_code}{Työssäkäyntialue code}
#'   \item{tyossakayntial_name_fi}{Työssäkäyntialue name in Finnish}
#'   \item{vaalipiiri_code}{Vaalipiiri code (Constituencies)}
#'   \item{vaalipiiri_name_fi}{Vaalipiiri name in Finnish (Constituencies)}
#'   \item{vaalipiiri_name_sv}{Vaalipiiri name in Swedish (Constituencies)}
#'   \item{vaalipiiri_name_en}{Vaalipiiri name in English (Constituencies)}
#'   \item{municipality_code}{Municipality code}
#'   \item{kunta_name}{Municipality name in Finnish}
#'   \item{name_fi}{Municipality name in Finnish}
#'   \item{name_sv}{Municipality name in Finnish}
#'   \item{erva_code}{Sairaanhoidon erityisvastuualueen code (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_fi}{Sairaanhoidon erityisvastuualueen name in Finnish (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_sv}{Sairaanhoidon erityisvastuualueen name in Swedish (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_en}{Sairaanhoidon erityisvastuualueen name in English (Catchment areas for highly specialised medical care)}
#'   \item{kela_vakuutuspiiri_name_fi}{Kelan vakuutuspiiri name in Finnish (Insurance District)}
#'   \item{kela_vakuutuspiiri_code}{Kelan vakuutuspiiri unofficial code (Insurance District)}
#'   \item{kela_vakuutuspiiri_name_sv}{Kelan vakuutuspiiri name in Swedish (Insurance District)}
#'   \item{kela_vakuutuspiiri_name_en}{Kelan vakuutuspiiri name in English (Insurance District)}
#'   \item{kela_asumistukialue_name_fi}{Kelan asumistuen kuntaryhmät name in Finnish (Municipality categories for housing allowance)}
#'   \item{kela_asumistukialue_code}{Kelan asumistuen kuntaryhmät unofficial code (Municipality categories for housing allowance)}
#'   \item{kela_asumistukialue_name_sv}{Kelan asumistuen kuntaryhmät name in Swedish (Municipality categories for housing allowance)}
#'   \item{kela_asumistukialue_name_en}{Kelan asumistuen kuntaryhmät name in English (Municipality categories for housing allowance)}
#' }
#' @source \url{https://data.stat.fi/api/classifications/v2/classifications}
"municipality_key"

#' Municipality key table for 2021
#'
#' Table for aggregating municipality level data to various regional groupings
#'
#' @format A data frame with 309 rows and 71 variables:
#' \describe{
#'   \item{kunta}{Municipality code}
#'   \item{municipality_name_fi}{Municipality name in Finnish}
#'   \item{municipality_name_sv}{Municipality name in Swedish}
#'   \item{municipality_name_en}{Municipality name in English}
#'   \item{kuntaryhmitys_code}{Tilastollinen kuntaryhmitys (Statistical grouping) code}
#'   \item{kuntaryhmitys_name_fi}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Finnish}
#'   \item{kuntaryhmitys_name_sv}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Swedish}
#'   \item{kuntaryhmitys_name_en}{Tilastollinen kuntaryhmitys (Statistical grouping) name in English}
#'   \item{avi_code}{Aluehallintovirasto code (Regional State Administrative Agencies)}
#'   \item{avi_name_fi}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_sv}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_en}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen code (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_fi}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Finnish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_sv}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Swedish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_en}{Elinkeino-, liikenne- ja ympäristökeskuksen name in English (Centre for Economic Development, Transport and the Environment)}
#'   \item{maakunta_code}{Maakunta code (Regions of Finland)}
#'   \item{maakunta_name_fi}{Maakunta name in Finnish (Regions of Finland)}
#'   \item{maakunta_name_sv}{Maakunta name in Swedish (Regions of Finland)}
#'   \item{maakunta_name_en}{Maakunta name in English (Regions of Finland)}
#'   \item{kielisuhde_code}{Kielisuhde code (Language distribution 2020)}
#'   \item{kielisuhde_name_fi}{Kielisuhde name in Finnish (Language distribution 2020)}
#'   \item{kielisuhde_name_sv}{Kielisuhde name in Swedish (Language distribution 2020)}
#'   \item{kielisuhde_name_en}{Kielisuhde name in English (Language distribution 2020)}
#'   \item{seutukunta_code}{Seutukunta code (Sub-regions of Finland)}
#'   \item{seutukunta_name_fi}{Seutukunta name in Finnish (Sub-regions of Finland)}
#'   \item{seutukunta_name_sv}{Seutukunta name in Swedish (Sub-regions of Finland)}
#'   \item{seutukunta_name_en}{Seutukunta name in English (Sub-regions of Finland)}
#'   \item{year}{data year}
#'   \item{suuralue_code}{Suuralue code}
#'   \item{suuralue_name_fi}{Suuralueen nimi in Finnish (Large Areas)}
#'   \item{suuralue_name_sv}{Suuralueen nimi in Swedish (Large Areas)}
#'   \item{suuralue_name_en}{Suuralueen nimi in English (Large Areas)}
#'   \item{sairaanhoitop_code}{Sairaanhoitopiiri code (Health care districts)}
#'   \item{sairaanhoitop_name_fi}{Sairaanhoitopiiri name in Finnish (Health care districts)}
#'   \item{sairaanhoitop_name_sv}{Sairaanhoitopiiri name in Swedish (Health care districts)}
#'   \item{sairaanhoitop_name_en}{Sairaanhoitopiiri name in English (Health care districts)}
#'   \item{nuts1_code}{NUTS 2016 classification code (level 1)}
#'   \item{nuts1_name_fi}{NUTS 2016 classification name in Finnish (level 1)}
#'   \item{nuts1_name_sv}{NUTS 2016 classification name in Swedish (level 1)}
#'   \item{nuts1_name_en}{NUTS 2016 classification name in English (level 1)}
#'   \item{nuts2_code}{NUTS 2016 classification code (level 2)}
#'   \item{nuts2_name_fi}{NUTS 2016 classification name in Finnish (level 2)}
#'   \item{nuts2_name_sv}{NUTS 2016 classification name in Swedish (level 2)}
#'   \item{nuts2_name_en}{nuts2_name_en}
#'   \item{nuts3_code}{NUTS 2016 classification code (level 2)}
#'   \item{nuts3_name_fi}{NUTS 2016 classification name in Finnish (level 3)}
#'   \item{nuts3_name_sv}{NUTS 2016 classification name in Swedish (level 3)}
#'   \item{nuts3_name_en}{NUTS 2016 classification name in English (level 3)}
#'   \item{tyossakayntial_code}{Työssäkäyntialue code}
#'   \item{tyossakayntial_name_fi}{Työssäkäyntialue name in Finnish}
#'   \item{vaalipiiri_code}{Vaalipiiri code (Constituencies)}
#'   \item{vaalipiiri_name_fi}{Vaalipiiri name in Finnish (Constituencies)}
#'   \item{vaalipiiri_name_sv}{Vaalipiiri name in Swedish (Constituencies)}
#'   \item{vaalipiiri_name_en}{Vaalipiiri name in English (Constituencies)}
#'   \item{municipality_code}{Municipality code}
#'   \item{kunta_name}{Municipality name in Finnish}
#'   \item{name_fi}{Municipality name in Finnish}
#'   \item{name_sv}{Municipality name in Finnish}
#'   \item{erva_code}{Sairaanhoidon erityisvastuualueen code (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_fi}{Sairaanhoidon erityisvastuualueen name in Finnish (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_sv}{Sairaanhoidon erityisvastuualueen name in Swedish (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_en}{Sairaanhoidon erityisvastuualueen name in English (Catchment areas for highly specialised medical care)}
#'   \item{kela_vakuutuspiiri_name_fi}{Kelan vakuutuspiiri name in Finnish (Insurance District)}
#'   \item{kela_vakuutuspiiri_code}{Kelan vakuutuspiiri unofficial code (Insurance District)}
#'   \item{kela_vakuutuspiiri_name_sv}{Kelan vakuutuspiiri name in Swedish (Insurance District)}
#'   \item{kela_vakuutuspiiri_name_en}{Kelan vakuutuspiiri name in English (Insurance District)}
#'   \item{kela_asumistukialue_name_fi}{Kelan asumistuen kuntaryhmät name in Finnish (Municipality categories for housing allowance)}
#'   \item{kela_asumistukialue_code}{Kelan asumistuen kuntaryhmät unofficial code (Municipality categories for housing allowance)}
#'   \item{kela_asumistukialue_name_sv}{Kelan asumistuen kuntaryhmät name in Swedish (Municipality categories for housing allowance)}
#'   \item{kela_asumistukialue_name_en}{Kelan asumistuen kuntaryhmät name in English (Municipality categories for housing allowance)}
#' }
#' @source \url{https://data.stat.fi/api/classifications/v2/classifications}
"municipality_key_2021"
# names(municipality_key_2021) %>% paste0("#'   \\item{",.,"}{",.,"}\n") %>% cat(., file = "tmp.txt")



#' Municipality key table for 2020
#'
#' Table for aggregating municipality level data to various regional groupings
#'
#' @format A data frame with 310 rows and 71 variables:
#' \describe{
#'   \item{kunta}{Municipality code}
#'   \item{municipality_name_fi}{Municipality name in Finnish}
#'   \item{municipality_name_sv}{Municipality name in Swedish}
#'   \item{municipality_name_en}{Municipality name in English}
#'   \item{kuntaryhmitys_code}{Tilastollinen kuntaryhmitys (Statistical grouping) code}
#'   \item{kuntaryhmitys_name_fi}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Finnish}
#'   \item{kuntaryhmitys_name_sv}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Swedish}
#'   \item{kuntaryhmitys_name_en}{Tilastollinen kuntaryhmitys (Statistical grouping) name in English}
#'   \item{avi_code}{Aluehallintovirasto code (Regional State Administrative Agencies)}
#'   \item{avi_name_fi}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_sv}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_en}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen code (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_fi}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Finnish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_sv}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Swedish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_en}{Elinkeino-, liikenne- ja ympäristökeskuksen name in English (Centre for Economic Development, Transport and the Environment)}
#'   \item{maakunta_code}{Maakunta code (Regions of Finland)}
#'   \item{maakunta_name_fi}{Maakunta name in Finnish (Regions of Finland)}
#'   \item{maakunta_name_sv}{Maakunta name in Swedish (Regions of Finland)}
#'   \item{maakunta_name_en}{Maakunta name in English (Regions of Finland)}
#'   \item{kielisuhde_code}{Kielisuhde code (Language distribution 2020)}
#'   \item{kielisuhde_name_fi}{Kielisuhde name in Finnish (Language distribution 2020)}
#'   \item{kielisuhde_name_sv}{Kielisuhde name in Swedish (Language distribution 2020)}
#'   \item{kielisuhde_name_en}{Kielisuhde name in English (Language distribution 2020)}
#'   \item{seutukunta_code}{Seutukunta code (Sub-regions of Finland)}
#'   \item{seutukunta_name_fi}{Seutukunta name in Finnish (Sub-regions of Finland)}
#'   \item{seutukunta_name_sv}{Seutukunta name in Swedish (Sub-regions of Finland)}
#'   \item{seutukunta_name_en}{Seutukunta name in English (Sub-regions of Finland)}
#'   \item{year}{data year}
#'   \item{suuralue_code}{Suuralue code}
#'   \item{suuralue_name_fi}{Suuralueen nimi in Finnish (Large Areas)}
#'   \item{suuralue_name_sv}{Suuralueen nimi in Swedish (Large Areas)}
#'   \item{suuralue_name_en}{Suuralueen nimi in English (Large Areas)}
#'   \item{sairaanhoitop_code}{Sairaanhoitopiiri code (Health care districts)}
#'   \item{sairaanhoitop_name_fi}{Sairaanhoitopiiri name in Finnish (Health care districts)}
#'   \item{sairaanhoitop_name_sv}{Sairaanhoitopiiri name in Swedish (Health care districts)}
#'   \item{sairaanhoitop_name_en}{Sairaanhoitopiiri name in English (Health care districts)}
#'   \item{nuts1_code}{NUTS 2016 classification code (level 1)}
#'   \item{nuts1_name_fi}{NUTS 2016 classification name in Finnish (level 1)}
#'   \item{nuts1_name_sv}{NUTS 2016 classification name in Swedish (level 1)}
#'   \item{nuts1_name_en}{NUTS 2016 classification name in English (level 1)}
#'   \item{nuts2_code}{NUTS 2016 classification code (level 2)}
#'   \item{nuts2_name_fi}{NUTS 2016 classification name in Finnish (level 2)}
#'   \item{nuts2_name_sv}{NUTS 2016 classification name in Swedish (level 2)}
#'   \item{nuts2_name_en}{nuts2_name_en}
#'   \item{nuts3_code}{NUTS 2016 classification code (level 2)}
#'   \item{nuts3_name_fi}{NUTS 2016 classification name in Finnish (level 3)}
#'   \item{nuts3_name_sv}{NUTS 2016 classification name in Swedish (level 3)}
#'   \item{nuts3_name_en}{NUTS 2016 classification name in English (level 3)}
#'   \item{tyossakayntial_code}{Työssäkäyntialue code}
#'   \item{tyossakayntial_name_fi}{Työssäkäyntialue name in Finnish}
#'   \item{vaalipiiri_code}{Vaalipiiri code (Constituencies)}
#'   \item{vaalipiiri_name_fi}{Vaalipiiri name in Finnish (Constituencies)}
#'   \item{vaalipiiri_name_sv}{Vaalipiiri name in Swedish (Constituencies)}
#'   \item{vaalipiiri_name_en}{Vaalipiiri name in English (Constituencies)}
#'   \item{municipality_code}{Municipality code}
#'   \item{kunta_name}{Municipality name in Finnish}
#'   \item{name_fi}{Municipality name in Finnish}
#'   \item{name_sv}{Municipality name in Finnish}
#'   \item{erva_code}{Sairaanhoidon erityisvastuualueen code (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_fi}{Sairaanhoidon erityisvastuualueen name in Finnish (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_sv}{Sairaanhoidon erityisvastuualueen name in Swedish (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_en}{Sairaanhoidon erityisvastuualueen name in English (Catchment areas for highly specialised medical care)}
#' }
#' @source \url{https://data.stat.fi/api/classifications/v2/classifications}
"municipality_key_2020"
# names(municipality_key_2020) %>% paste0("#'   \\item{",.,"}{",.,"}\n") %>% cat(., file = "tmp.txt")

#' Municipality key table for 2019
#'
#' Table for aggregating municipality level data to various regional groupings
#'
#' @format A data frame with 311 rows and 63 variables:
#' \describe{
#'   \item{kunta}{Municipality code}
#'   \item{municipality_name_fi}{Municipality name in Finnish}
#'   \item{municipality_name_sv}{Municipality name in Swedish}
#'   \item{municipality_name_en}{Municipality name in English}
#'   \item{kuntaryhmitys_code}{Tilastollinen kuntaryhmitys (Statistical grouping) code}
#'   \item{kuntaryhmitys_name_fi}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Finnish}
#'   \item{kuntaryhmitys_name_sv}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Swedish}
#'   \item{kuntaryhmitys_name_en}{Tilastollinen kuntaryhmitys (Statistical grouping) name in English}
#'   \item{avi_code}{Aluehallintovirasto code (Regional State Administrative Agencies)}
#'   \item{avi_name_fi}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_sv}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_en}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen code (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_fi}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Finnish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_sv}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Swedish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_en}{Elinkeino-, liikenne- ja ympäristökeskuksen name in English (Centre for Economic Development, Transport and the Environment)}
#'   \item{maakunta_code}{Maakunta code (Regions of Finland)}
#'   \item{maakunta_name_fi}{Maakunta name in Finnish (Regions of Finland)}
#'   \item{maakunta_name_sv}{Maakunta name in Swedish (Regions of Finland)}
#'   \item{maakunta_name_en}{Maakunta name in English (Regions of Finland)}
#'   \item{kielisuhde_code}{Kielisuhde code (Language distribution 2020)}
#'   \item{kielisuhde_name_fi}{Kielisuhde name in Finnish (Language distribution 2020)}
#'   \item{kielisuhde_name_sv}{Kielisuhde name in Swedish (Language distribution 2020)}
#'   \item{kielisuhde_name_en}{Kielisuhde name in English (Language distribution 2020)}
#'   \item{seutukunta_code}{Seutukunta code (Sub-regions of Finland)}
#'   \item{seutukunta_name_fi}{Seutukunta name in Finnish (Sub-regions of Finland)}
#'   \item{seutukunta_name_sv}{Seutukunta name in Swedish (Sub-regions of Finland)}
#'   \item{seutukunta_name_en}{Seutukunta name in English (Sub-regions of Finland)}
#'   \item{year}{data year}
#'   \item{suuralue_code}{Suuralue code}
#'   \item{suuralue_name_fi}{Suuralueen nimi in Finnish (Large Areas)}
#'   \item{suuralue_name_sv}{Suuralueen nimi in Swedish (Large Areas)}
#'   \item{suuralue_name_en}{Suuralueen nimi in English (Large Areas)}
#'   \item{sairaanhoitop_code}{Sairaanhoitopiiri code (Health care districts)}
#'   \item{sairaanhoitop_name_fi}{Sairaanhoitopiiri name in Finnish (Health care districts)}
#'   \item{sairaanhoitop_name_sv}{Sairaanhoitopiiri name in Swedish (Health care districts)}
#'   \item{sairaanhoitop_name_en}{Sairaanhoitopiiri name in English (Health care districts)}
#'   \item{nuts1_code}{NUTS 2016 classification code (level 1)}
#'   \item{nuts1_name_fi}{NUTS 2016 classification name in Finnish (level 1)}
#'   \item{nuts1_name_sv}{NUTS 2016 classification name in Swedish (level 1)}
#'   \item{nuts1_name_en}{NUTS 2016 classification name in English (level 1)}
#'   \item{nuts2_code}{NUTS 2016 classification code (level 2)}
#'   \item{nuts2_name_fi}{NUTS 2016 classification name in Finnish (level 2)}
#'   \item{nuts2_name_sv}{NUTS 2016 classification name in Swedish (level 2)}
#'   \item{nuts2_name_en}{nuts2_name_en}
#'   \item{nuts3_code}{NUTS 2016 classification code (level 2)}
#'   \item{nuts3_name_fi}{NUTS 2016 classification name in Finnish (level 3)}
#'   \item{nuts3_name_sv}{NUTS 2016 classification name in Swedish (level 3)}
#'   \item{nuts3_name_en}{NUTS 2016 classification name in English (level 3)}
#'   \item{tyossakayntial_code}{Työssäkäyntialue code}
#'   \item{tyossakayntial_name_fi}{Työssäkäyntialue name in Finnish}
#'   \item{vaalipiiri_code}{Vaalipiiri code (Constituencies)}
#'   \item{vaalipiiri_name_fi}{Vaalipiiri name in Finnish (Constituencies)}
#'   \item{vaalipiiri_name_sv}{Vaalipiiri name in Swedish (Constituencies)}
#'   \item{vaalipiiri_name_en}{Vaalipiiri name in English (Constituencies)}
#'   \item{municipality_code}{Municipality code}
#'   \item{kunta_name}{Municipality name in Finnish}
#'   \item{name_fi}{Municipality name in Finnish}
#'   \item{name_sv}{Municipality name in Finnish}
#'   \item{erva_code}{Sairaanhoidon erityisvastuualueen code (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_fi}{Sairaanhoidon erityisvastuualueen name in Finnish (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_sv}{Sairaanhoidon erityisvastuualueen name in Swedish (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_en}{Sairaanhoidon erityisvastuualueen name in English (Catchment areas for highly specialised medical care)}
#' }
#' @source \url{https://data.stat.fi/api/classifications/v2/classifications}
"municipality_key_2019"

#' Municipality key table for 2018
#'
#' Table for aggregating municipality level data to various regional groupings
#'
#' @format A data frame with 311 rows and 59 variables:
#' \describe{
#'   \item{kunta}{Municipality code}
#'   \item{municipality_name_fi}{Municipality name in Finnish}
#'   \item{municipality_name_sv}{Municipality name in Swedish}
#'   \item{municipality_name_en}{Municipality name in English}
#'   \item{kuntaryhmitys_code}{Tilastollinen kuntaryhmitys (Statistical grouping) code}
#'   \item{kuntaryhmitys_name_fi}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Finnish}
#'   \item{kuntaryhmitys_name_sv}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Swedish}
#'   \item{kuntaryhmitys_name_en}{Tilastollinen kuntaryhmitys (Statistical grouping) name in English}
#'   \item{avi_code}{Aluehallintovirasto code (Regional State Administrative Agencies)}
#'   \item{avi_name_fi}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_sv}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_en}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen code (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_fi}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Finnish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_sv}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Swedish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_en}{Elinkeino-, liikenne- ja ympäristökeskuksen name in English (Centre for Economic Development, Transport and the Environment)}
#'   \item{maakunta_code}{Maakunta code (Regions of Finland)}
#'   \item{maakunta_name_fi}{Maakunta name in Finnish (Regions of Finland)}
#'   \item{maakunta_name_sv}{Maakunta name in Swedish (Regions of Finland)}
#'   \item{maakunta_name_en}{Maakunta name in English (Regions of Finland)}
#'   \item{kielisuhde_code}{Kielisuhde code (Language distribution 2020)}
#'   \item{kielisuhde_name_fi}{Kielisuhde name in Finnish (Language distribution 2020)}
#'   \item{kielisuhde_name_sv}{Kielisuhde name in Swedish (Language distribution 2020)}
#'   \item{kielisuhde_name_en}{Kielisuhde name in English (Language distribution 2020)}
#'   \item{seutukunta_code}{Seutukunta code (Sub-regions of Finland)}
#'   \item{seutukunta_name_fi}{Seutukunta name in Finnish (Sub-regions of Finland)}
#'   \item{seutukunta_name_sv}{Seutukunta name in Swedish (Sub-regions of Finland)}
#'   \item{seutukunta_name_en}{Seutukunta name in English (Sub-regions of Finland)}
#'   \item{year}{data year}
#'   \item{suuralue_code}{Suuralue code}
#'   \item{suuralue_name_fi}{Suuralueen nimi in Finnish (Large Areas)}
#'   \item{suuralue_name_sv}{Suuralueen nimi in Swedish (Large Areas)}
#'   \item{suuralue_name_en}{Suuralueen nimi in English (Large Areas)}
#'   \item{sairaanhoitop_code}{Sairaanhoitopiiri code (Health care districts)}
#'   \item{sairaanhoitop_name_fi}{Sairaanhoitopiiri name in Finnish (Health care districts)}
#'   \item{sairaanhoitop_name_sv}{Sairaanhoitopiiri name in Swedish (Health care districts)}
#'   \item{sairaanhoitop_name_en}{Sairaanhoitopiiri name in English (Health care districts)}
#'   \item{nuts1_code}{NUTS 2016 classification code (level 1)}
#'   \item{nuts1_name_fi}{NUTS 2016 classification name in Finnish (level 1)}
#'   \item{nuts1_name_sv}{NUTS 2016 classification name in Swedish (level 1)}
#'   \item{nuts1_name_en}{NUTS 2016 classification name in English (level 1)}
#'   \item{nuts2_code}{NUTS 2016 classification code (level 2)}
#'   \item{nuts2_name_fi}{NUTS 2016 classification name in Finnish (level 2)}
#'   \item{nuts2_name_sv}{NUTS 2016 classification name in Swedish (level 2)}
#'   \item{nuts2_name_en}{nuts2_name_en}
#'   \item{nuts3_code}{NUTS 2016 classification code (level 2)}
#'   \item{nuts3_name_fi}{NUTS 2016 classification name in Finnish (level 3)}
#'   \item{nuts3_name_sv}{NUTS 2016 classification name in Swedish (level 3)}
#'   \item{nuts3_name_en}{NUTS 2016 classification name in English (level 3)}
#'   \item{tyossakayntial_code}{Työssäkäyntialue code}
#'   \item{tyossakayntial_name_fi}{Työssäkäyntialue name in Finnish}
#'   \item{municipality_code}{Municipality code}
#'   \item{kunta_name}{Municipality name in Finnish}
#'   \item{name_fi}{Municipality name in Finnish}
#'   \item{name_sv}{Municipality name in Finnish}
#'   \item{erva_code}{Sairaanhoidon erityisvastuualueen code (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_fi}{Sairaanhoidon erityisvastuualueen name in Finnish (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_sv}{Sairaanhoidon erityisvastuualueen name in Swedish (Catchment areas for highly specialised medical care)}
#'   \item{erva_name_en}{Sairaanhoidon erityisvastuualueen name in English (Catchment areas for highly specialised medical care)}
#' }
#' @source \url{https://data.stat.fi/api/classifications/v2/classifications}
"municipality_key_2018"
# names(municipality_key_2017) %>% paste0("#'   \\item{",.,"}{",.,"}\n") %>% cat(., file = "tmp.txt")

#' Municipality key table for 2017
#'
#' Table for aggregating municipality level data to various regional groupings
#'
#' @format A data frame with 311 rows and 53 variables:
#' \describe{
#'   \item{kunta}{Municipality code}
#'   \item{municipality_name_fi}{Municipality name in Finnish}
#'   \item{municipality_name_sv}{Municipality name in Swedish}
#'   \item{municipality_name_en}{Municipality name in English}
#'   \item{kuntaryhmitys_code}{Tilastollinen kuntaryhmitys (Statistical grouping) code}
#'   \item{kuntaryhmitys_name_fi}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Finnish}
#'   \item{kuntaryhmitys_name_sv}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Swedish}
#'   \item{kuntaryhmitys_name_en}{Tilastollinen kuntaryhmitys (Statistical grouping) name in English}
#'   \item{avi_code}{Aluehallintovirasto code (Regional State Administrative Agencies)}
#'   \item{avi_name_fi}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_sv}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_en}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen code (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_fi}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Finnish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_sv}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Swedish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_en}{Elinkeino-, liikenne- ja ympäristökeskuksen name in English (Centre for Economic Development, Transport and the Environment)}
#'   \item{maakunta_code}{Maakunta code (Regions of Finland)}
#'   \item{maakunta_name_fi}{Maakunta name in Finnish (Regions of Finland)}
#'   \item{maakunta_name_sv}{Maakunta name in Swedish (Regions of Finland)}
#'   \item{maakunta_name_en}{Maakunta name in English (Regions of Finland)}
#'   \item{kielisuhde_code}{Kielisuhde code (Language distribution 2020)}
#'   \item{kielisuhde_name_fi}{Kielisuhde name in Finnish (Language distribution 2020)}
#'   \item{kielisuhde_name_sv}{Kielisuhde name in Swedish (Language distribution 2020)}
#'   \item{kielisuhde_name_en}{Kielisuhde name in English (Language distribution 2020)}
#'   \item{seutukunta_code}{Seutukunta code (Sub-regions of Finland)}
#'   \item{seutukunta_name_fi}{Seutukunta name in Finnish (Sub-regions of Finland)}
#'   \item{seutukunta_name_sv}{Seutukunta name in Swedish (Sub-regions of Finland)}
#'   \item{seutukunta_name_en}{Seutukunta name in English (Sub-regions of Finland)}
#'   \item{year}{data year}
#'   \item{suuralue_code}{Suuralue code}
#'   \item{suuralue_name_fi}{Suuralueen nimi in Finnish (Large Areas)}
#'   \item{suuralue_name_sv}{Suuralueen nimi in Swedish (Large Areas)}
#'   \item{suuralue_name_en}{Suuralueen nimi in English (Large Areas)}
#'   \item{sairaanhoitop_code}{Sairaanhoitopiiri code (Health care districts)}
#'   \item{sairaanhoitop_name_fi}{Sairaanhoitopiiri name in Finnish (Health care districts)}
#'   \item{sairaanhoitop_name_sv}{Sairaanhoitopiiri name in Swedish (Health care districts)}
#'   \item{sairaanhoitop_name_en}{Sairaanhoitopiiri name in English (Health care districts)}
#'   \item{nuts1_code}{NUTS 2016 classification code (level 1)}
#'   \item{nuts1_name_fi}{NUTS 2016 classification name in Finnish (level 1)}
#'   \item{nuts1_name_sv}{NUTS 2016 classification name in Swedish (level 1)}
#'   \item{nuts1_name_en}{NUTS 2016 classification name in English (level 1)}
#'   \item{nuts2_code}{NUTS 2016 classification code (level 2)}
#'   \item{nuts2_name_fi}{NUTS 2016 classification name in Finnish (level 2)}
#'   \item{nuts2_name_sv}{NUTS 2016 classification name in Swedish (level 2)}
#'   \item{nuts2_name_en}{nuts2_name_en}
#'   \item{nuts3_code}{NUTS 2016 classification code (level 2)}
#'   \item{nuts3_name_fi}{NUTS 2016 classification name in Finnish (level 3)}
#'   \item{nuts3_name_sv}{NUTS 2016 classification name in Swedish (level 3)}
#'   \item{nuts3_name_en}{NUTS 2016 classification name in English (level 3)}
#'   \item{municipality_code}{Municipality code}
#'   \item{kunta_name}{Municipality name in Finnish}
#'   \item{name_fi}{Municipality name in Finnish}
#'   \item{name_sv}{Municipality name in Finnish}
#' }
#' @source \url{https://data.stat.fi/api/classifications/v2/classifications}
"municipality_key_2017"

#' Municipality key table for 2016
#'
#' Table for aggregating municipality level data to various regional groupings
#'
#' @format A data frame with 319 rows and 37 variables:
#' \describe{
#'   \item{kunta}{Municipality code}
#'   \item{municipality_name_fi}{Municipality name in Finnish}
#'   \item{municipality_name_sv}{Municipality name in Swedish}
#'   \item{municipality_name_en}{Municipality name in English}
#'   \item{kuntaryhmitys_code}{Tilastollinen kuntaryhmitys (Statistical grouping) code}
#'   \item{kuntaryhmitys_name_fi}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Finnish}
#'   \item{kuntaryhmitys_name_sv}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Swedish}
#'   \item{kuntaryhmitys_name_en}{Tilastollinen kuntaryhmitys (Statistical grouping) name in English}
#'   \item{avi_code}{Aluehallintovirasto code (Regional State Administrative Agencies)}
#'   \item{avi_name_fi}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_sv}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_en}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen code (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_fi}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Finnish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_sv}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Swedish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_en}{Elinkeino-, liikenne- ja ympäristökeskuksen name in English (Centre for Economic Development, Transport and the Environment)}
#'   \item{maakunta_code}{Maakunta code (Regions of Finland)}
#'   \item{maakunta_name_fi}{Maakunta name in Finnish (Regions of Finland)}
#'   \item{maakunta_name_sv}{Maakunta name in Swedish (Regions of Finland)}
#'   \item{maakunta_name_en}{Maakunta name in English (Regions of Finland)}
#'   \item{kielisuhde_code}{Kielisuhde code (Language distribution 2020)}
#'   \item{kielisuhde_name_fi}{Kielisuhde name in Finnish (Language distribution 2020)}
#'   \item{kielisuhde_name_sv}{Kielisuhde name in Swedish (Language distribution 2020)}
#'   \item{kielisuhde_name_en}{Kielisuhde name in English (Language distribution 2020)}
#'   \item{seutukunta_code}{Seutukunta code (Sub-regions of Finland)}
#'   \item{seutukunta_name_fi}{Seutukunta name in Finnish (Sub-regions of Finland)}
#'   \item{seutukunta_name_sv}{Seutukunta name in Swedish (Sub-regions of Finland)}
#'   \item{seutukunta_name_en}{Seutukunta name in English (Sub-regions of Finland)}
#'   \item{year}{data year}
#'   \item{suuralue_code}{Suuralue code}
#'   \item{suuralue_name_fi}{Suuralueen nimi in Finnish (Large Areas)}
#'   \item{suuralue_name_sv}{Suuralueen nimi in Swedish (Large Areas)}
#'   \item{suuralue_name_en}{Suuralueen nimi in English (Large Areas)}
#'   \item{municipality_code}{Municipality code}
#'   \item{kunta_name}{Municipality name in Finnish}
#'   \item{name_fi}{Municipality name in Finnish}
#'   \item{name_sv}{Municipality name in Finnish}
#' }
#' @source \url{https://data.stat.fi/api/classifications/v2/classifications}
"municipality_key_2016"

#' Municipality key table for 2015
#'
#' Table for aggregating municipality level data to various regional groupings
#'
#' @format A data frame with 317 rows and 37 variables:
#' \describe{
#'   \item{kunta}{Municipality code}
#'   \item{municipality_name_fi}{Municipality name in Finnish}
#'   \item{municipality_name_sv}{Municipality name in Swedish}
#'   \item{municipality_name_en}{Municipality name in English}
#'   \item{kuntaryhmitys_code}{Tilastollinen kuntaryhmitys (Statistical grouping) code}
#'   \item{kuntaryhmitys_name_fi}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Finnish}
#'   \item{kuntaryhmitys_name_sv}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Swedish}
#'   \item{kuntaryhmitys_name_en}{Tilastollinen kuntaryhmitys (Statistical grouping) name in English}
#'   \item{avi_code}{Aluehallintovirasto code (Regional State Administrative Agencies)}
#'   \item{avi_name_fi}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_sv}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_en}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen code (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_fi}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Finnish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_sv}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Swedish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_en}{Elinkeino-, liikenne- ja ympäristökeskuksen name in English (Centre for Economic Development, Transport and the Environment)}
#'   \item{maakunta_code}{Maakunta code (Regions of Finland)}
#'   \item{maakunta_name_fi}{Maakunta name in Finnish (Regions of Finland)}
#'   \item{maakunta_name_sv}{Maakunta name in Swedish (Regions of Finland)}
#'   \item{maakunta_name_en}{Maakunta name in English (Regions of Finland)}
#'   \item{kielisuhde_code}{Kielisuhde code (Language distribution 2020)}
#'   \item{kielisuhde_name_fi}{Kielisuhde name in Finnish (Language distribution 2020)}
#'   \item{kielisuhde_name_sv}{Kielisuhde name in Swedish (Language distribution 2020)}
#'   \item{kielisuhde_name_en}{Kielisuhde name in English (Language distribution 2020)}
#'   \item{seutukunta_code}{Seutukunta code (Sub-regions of Finland)}
#'   \item{seutukunta_name_fi}{Seutukunta name in Finnish (Sub-regions of Finland)}
#'   \item{seutukunta_name_sv}{Seutukunta name in Swedish (Sub-regions of Finland)}
#'   \item{seutukunta_name_en}{Seutukunta name in English (Sub-regions of Finland)}
#'   \item{year}{data year}
#'   \item{suuralue_code}{Suuralue code}
#'   \item{suuralue_name_fi}{Suuralueen nimi in Finnish (Large Areas)}
#'   \item{suuralue_name_sv}{Suuralueen nimi in Swedish (Large Areas)}
#'   \item{suuralue_name_en}{Suuralueen nimi in English (Large Areas)}
#'   \item{municipality_code}{Municipality code}
#'   \item{kunta_name}{Municipality name in Finnish}
#'   \item{name_fi}{Municipality name in Finnish}
#'   \item{name_sv}{Municipality name in Finnish}
#' }
#' @source \url{https://data.stat.fi/api/classifications/v2/classifications}
"municipality_key_2015"

#' Municipality key table for 2014
#'
#' Table for aggregating municipality level data to various regional groupings
#'
#' @format A data frame with 320 rows and 37 variables:
#' \describe{
#'   \item{kunta}{Municipality code}
#'   \item{municipality_name_fi}{Municipality name in Finnish}
#'   \item{municipality_name_sv}{Municipality name in Swedish}
#'   \item{municipality_name_en}{Municipality name in English}
#'   \item{kuntaryhmitys_code}{Tilastollinen kuntaryhmitys (Statistical grouping) code}
#'   \item{kuntaryhmitys_name_fi}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Finnish}
#'   \item{kuntaryhmitys_name_sv}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Swedish}
#'   \item{kuntaryhmitys_name_en}{Tilastollinen kuntaryhmitys (Statistical grouping) name in English}
#'   \item{avi_code}{Aluehallintovirasto code (Regional State Administrative Agencies)}
#'   \item{avi_name_fi}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_sv}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_en}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen code (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_fi}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Finnish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_sv}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Swedish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_en}{Elinkeino-, liikenne- ja ympäristökeskuksen name in English (Centre for Economic Development, Transport and the Environment)}
#'   \item{maakunta_code}{Maakunta code (Regions of Finland)}
#'   \item{maakunta_name_fi}{Maakunta name in Finnish (Regions of Finland)}
#'   \item{maakunta_name_sv}{Maakunta name in Swedish (Regions of Finland)}
#'   \item{maakunta_name_en}{Maakunta name in English (Regions of Finland)}
#'   \item{kielisuhde_code}{Kielisuhde code (Language distribution 2020)}
#'   \item{kielisuhde_name_fi}{Kielisuhde name in Finnish (Language distribution 2020)}
#'   \item{kielisuhde_name_sv}{Kielisuhde name in Swedish (Language distribution 2020)}
#'   \item{kielisuhde_name_en}{Kielisuhde name in English (Language distribution 2020)}
#'   \item{seutukunta_code}{Seutukunta code (Sub-regions of Finland)}
#'   \item{seutukunta_name_fi}{Seutukunta name in Finnish (Sub-regions of Finland)}
#'   \item{seutukunta_name_sv}{Seutukunta name in Swedish (Sub-regions of Finland)}
#'   \item{seutukunta_name_en}{Seutukunta name in English (Sub-regions of Finland)}
#'   \item{year}{data year}
#'   \item{suuralue_code}{Suuralue code}
#'   \item{suuralue_name_fi}{Suuralueen nimi in Finnish (Large Areas)}
#'   \item{suuralue_name_sv}{Suuralueen nimi in Swedish (Large Areas)}
#'   \item{suuralue_name_en}{Suuralueen nimi in English (Large Areas)}
#'   \item{municipality_code}{Municipality code}
#'   \item{kunta_name}{Municipality name in Finnish}
#'   \item{name_fi}{Municipality name in Finnish}
#'   \item{name_sv}{Municipality name in Finnish}
#' }
#' @source \url{https://data.stat.fi/api/classifications/v2/classifications}
"municipality_key_2014"

#' Municipality key table for 2013
#'
#' Table for aggregating municipality level data to various regional groupings
#'
#' @format A data frame with 320 rows and 33 variables:
#' \describe{
#'   \item{kunta}{Municipality code}
#'   \item{municipality_name_fi}{Municipality name in Finnish}
#'   \item{municipality_name_sv}{Municipality name in Swedish}
#'   \item{municipality_name_en}{Municipality name in English}
#'   \item{kuntaryhmitys_code}{Tilastollinen kuntaryhmitys (Statistical grouping) code}
#'   \item{kuntaryhmitys_name_fi}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Finnish}
#'   \item{kuntaryhmitys_name_sv}{Tilastollinen kuntaryhmitys (Statistical grouping) name in Swedish}
#'   \item{kuntaryhmitys_name_en}{Tilastollinen kuntaryhmitys (Statistical grouping) name in English}
#'   \item{avi_code}{Aluehallintovirasto code (Regional State Administrative Agencies)}
#'   \item{avi_name_fi}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_sv}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{avi_name_en}{Aluehallintovirasto name in Finnish (Regional State Administrative Agencies)}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen code (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_fi}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Finnish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_sv}{Elinkeino-, liikenne- ja ympäristökeskuksen name in Swedish (Centre for Economic Development, Transport and the Environment)}
#'   \item{ely_name_en}{Elinkeino-, liikenne- ja ympäristökeskuksen name in English (Centre for Economic Development, Transport and the Environment)}
#'   \item{maakunta_code}{Maakunta code (Regions of Finland)}
#'   \item{maakunta_name_fi}{Maakunta name in Finnish (Regions of Finland)}
#'   \item{maakunta_name_sv}{Maakunta name in Swedish (Regions of Finland)}
#'   \item{maakunta_name_en}{Maakunta name in English (Regions of Finland)}
#'   \item{kielisuhde_code}{Kielisuhde code (Language distribution 2020)}
#'   \item{kielisuhde_name_fi}{Kielisuhde name in Finnish (Language distribution 2020)}
#'   \item{kielisuhde_name_sv}{Kielisuhde name in Swedish (Language distribution 2020)}
#'   \item{kielisuhde_name_en}{Kielisuhde name in English (Language distribution 2020)}
#'   \item{seutukunta_code}{Seutukunta code (Sub-regions of Finland)}
#'   \item{seutukunta_name_fi}{Seutukunta name in Finnish (Sub-regions of Finland)}
#'   \item{seutukunta_name_sv}{Seutukunta name in Swedish (Sub-regions of Finland)}
#'   \item{seutukunta_name_en}{Seutukunta name in English (Sub-regions of Finland)}
#'   \item{year}{data year}
#'   \item{municipality_code}{Municipality code}
#'   \item{kunta_name}{Municipality name in Finnish}
#'   \item{name_fi}{Municipality name in Finnish}
#'   \item{name_sv}{Municipality name in Finnish}
#' }
#' @source \url{https://data.stat.fi/api/classifications/v2/classifications}
"municipality_key_2013"
