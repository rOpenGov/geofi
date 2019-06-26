#' Vuoden 2019 kunnat erilaisilla alueluokituksilla
#'
#' Data jolla kuntatason datoja voidaan aggregoida ylemmälle tasolla
#'
#' @format A data frame with 311 rows and 65 variables:
#' \describe{
#'   \item{kunta}{kunta}
#'   \item{name}{name}
#'   \item{avi_code}{avi_code}
#'   \item{avi_name}{avi_name}
#'   \item{ely_code}{ely_code}
#'   \item{ely_name}{ely_name}
#'   \item{kr_code}{kr_code}
#'   \item{kr_name}{kr_name}
#'   \item{mk_code}{mk_code}
#'   \item{mk_name}{mk_name}
#'   \item{sa_code}{sa_code}
#'   \item{sa_name}{sa_name}
#'   \item{sk_code}{sk_code}
#'   \item{sk_name}{sk_name}
#'   \item{sp_code}{sp_code}
#'   \item{sp_name}{sp_name}
#'   \item{erva_name}{erva_name}
#'   \item{erva_code}{erva_code}
#'   \item{va_code}{va_code}
#'   \item{va_name}{va_name}
#'   \item{vakuutuspiiri_name}{vakuutuspiiri_name}
#'   \item{vakuutuspiiri_code}{vakuutuspiiri_code}
#'   \item{asumistukialue_name}{asumistukialue_name}
#'   \item{asumistukialue_code}{asumistukialue_code}
#'   \item{avi_name_sv}{avi_name_sv}
#'   \item{ely_name_sv}{ely_name_sv}
#'   \item{mk_name_sv}{mk_name_sv}
#'   \item{sa_name_sv}{sa_name_sv}
#'   \item{sa_name_sk}{sa_name_sk}
#'   \item{sp_name_sv}{sp_name_sv}
#'   \item{va_name_sv}{va_name_sv}
#'   \item{vakuutuspiiri_name_sv}{vakuutuspiiri_name_sv}
#' }
#' @source \url{http://www.stat.fi/meta/luokitukset/kunta/001-2019/luokitusavaimet.html}
"municipality_key_2019"
#' Vuoden 2018 kunnat erilaisilla alueluokituksilla
#'
#' Data jolla kuntatason datoja voidaan aggregoida ylemmälle tasolla
#'
#' @format A data frame with 313 rows and 67 variables:
#' \describe{
#'   \item{kunta}{Kuntanumero}
#'   \item{name}{Kunnan nimi suomeksi}
#'   \item{avi_code}{Aluehallintoviraston koodi}
#'   \item{avi_name}{Aluehallintoviraston nimi}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen koodi}
#'   \item{ely_name}{Elinkeino-, liikenne- ja ympäristökeskuksen nimi}
#'   \item{hp_code}{Hovioikeuspiirin koodi}
#'   \item{hp_name}{Hovioikeuspiirin nimi}
#'   \item{kr_code}{Tilastokeskuksen tilastollisen kuntaluokituksen koodi}
#'   \item{kr_name}{Tilastokeskuksen tilastollisen kuntaluokituksen nimi}
#'   \item{mk_code}{Maakunnan koodi}
#'   \item{mk_name}{Maakunnan nimi}
#'   \item{sa_code}{Suuralueen koodi}
#'   \item{sa_name}{Suuralueen nimi}
#'   \item{sk_code}{Seutukunnan koodi}
#'   \item{sk_name}{Seutukunnan nimi}
#'   \item{sp_code}{Sairaanhoitopiirin koodi}
#'   \item{sp_name}{Sairaanhoitopiirin nimi}
#'   \item{tk_code}{Työssäköyntialueen koodi}
#'   \item{tk_name}{Työssäkäyntialueen nimi}
#'   \item{va_code}{Vaalipiirin koodi}
#'   \item{va_name}{Vaalipiirin nimi}
#'   \item{vakuutuspiiri_name}{Kelan vakuutuspiirin nimi}
#'   \item{vakuutuspiiri_code}{Kelan vakuutuspiirin koodi (epävirallinen)}
#'   \item{asumistukialue_name}{Kelan asumistukialueen nimi}
#'   \item{asumistukialue_code}{Kelan asumistukialueen koodi (epävirallinen)}
#'   \item{erva_name}{Erityisvastuualueen nimi}
#'   \item{erva_code}{Erityisvastuualueen koodi (epävirallinen)}
#'   \item{avi_name_sv}{avi_name_sv}
#'   \item{ely_name_sv}{ely_name_sv}
#'   \item{mk_name_sv}{mk_name_sv}
#'   \item{sa_name_sv}{sa_name_sv}
#'   \item{sa_name_sk}{sa_name_sk}
#'   \item{sp_name_sv}{sp_name_sv}
#'   \item{va_name_sv}{va_name_sv}
#'   \item{vakuutuspiiri_name_sv}{vakuutuspiiri_name_sv}
#' }
#' @source \url{http://www.stat.fi/meta/luokitukset/kunta/001-2018/luokitusavaimet.html}
"municipality_key_2018"
# names(municipality_key_2017) %>% paste0("#'   \\item{",.,"}{",.,"}\n") %>% cat(., file = "tmp.txt")
#' Vuoden 2017 kunnat erilaisilla alueluokituksilla
#'
#' Data jolla kuntatason datoja voidaan aggregoida ylemmälle tasolla
#'
#' @format A data frame with 311 rows and 28 variables:
#' \describe{
#'   \item{kunta}{Kuntanumero}
#'   \item{name}{Kunnan nimi suomeksi}
#'   \item{avi_code}{Aluehallintoviraston koodi}
#'   \item{avi_name}{Aluehallintoviraston nimi}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen koodi}
#'   \item{ely_name}{Elinkeino-, liikenne- ja ympäristökeskuksen nimi}
#'   \item{hp_code}{Hovioikeuspiirin koodi}
#'   \item{hp_name}{Hovioikeuspiirin nimi}
#'   \item{kr_code}{Tilastokeskuksen tilastollisen kuntaluokituksen koodi}
#'   \item{kr_name}{Tilastokeskuksen tilastollisen kuntaluokituksen nimi}
#'   \item{mk_code}{Maakunnan koodi}
#'   \item{mk_name}{Maakunnan nimi}
#'   \item{sa_code}{Suuralueen koodi}
#'   \item{sa_name}{Suuralueen nimi}
#'   \item{sk_code}{Seutukunnan koodi}
#'   \item{sk_name}{Seutukunnan nimi}
#'   \item{sp_code}{Sairaanhoitopiirin koodi}
#'   \item{sp_name}{Sairaanhoitopiirin nimi}
#'   \item{tk_code}{Työssäköyntialueen koodi}
#'   \item{tk_name}{Työssäkäyntialueen nimi}
#'   \item{va_code}{Vaalipiirin koodi}
#'   \item{va_name}{Vaalipiirin nimi}
#'   \item{vakuutuspiiri_name}{Kelan vakuutuspiirin nimi}
#'   \item{vakuutuspiiri_code}{Kelan vakuutuspiirin koodi (epävirallinen)}
#'   \item{asumistukialue_name}{Kelan asumistukialueen nimi}
#'   \item{asumistukialue_code}{Kelan asumistukialueen koodi (epävirallinen)}
#'   \item{erva_name}{Erityisvastuualueen nimi}
#'   \item{erva_code}{Erityisvastuualueen koodi (epävirallinen)}
#'   \item{avi_name_sv}{avi_name_sv}
#'   \item{ely_name_sv}{ely_name_sv}
#'   \item{kr_name_sv}{kr_name_sv}
#'   \item{mk_name_sv}{mk_name_sv}
#'   \item{sp_name_sv}{sp_name_sv}
#'   \item{vakuutuspiiri_name_sv}{vakuutuspiiri_name_sv}
#' }
#' @source \url{http://www.stat.fi/meta/luokitukset/kunta/001-2017/luokitusavaimet.html}
"municipality_key_2017"
#' Vuoden 2016 kunnat erilaisilla alueluokituksilla
#'
#' Data jolla kuntatason datoja voidaan aggregoida ylemmälle tasolla
#'
#' @format A data frame with 313 rows and 48 variables:
#' \describe{
#'   \item{kunta}{Kuntanumero}
#'   \item{name}{Kunnan nimi suomeksi}
#'   \item{avi_code}{Aluehallintoviraston koodi}
#'   \item{avi_name}{Aluehallintoviraston nimi}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen koodi}
#'   \item{ely_name}{Elinkeino-, liikenne- ja ympäristökeskuksen nimi}
#'   \item{kr_code}{Tilastokeskuksen tilastollisen kuntaluokituksen koodi}
#'   \item{kr_name}{Tilastokeskuksen tilastollisen kuntaluokituksen nimi}
#'   \item{mk_code}{Maakunnan koodi}
#'   \item{mk_name}{Maakunnan nimi}
#'   \item{sa_code}{Suuralueen koodi}
#'   \item{sa_name}{Suuralueen nimi}
#'   \item{sk_code}{Seutukunnan koodi}
#'   \item{sk_name}{Seutukunnan nimi}
#'   \item{va_code}{Vaalipiirin koodi}
#'   \item{va_name}{Vaalipiirin nimi}
#'   \item{avi_name_sv}{avi_name_sv}
#'   \item{ely_name_sv}{ely_name_sv}
#'   \item{kr_name_sv}{kr_name_sv}
#'   \item{mk_name_sv}{mk_name_sv}
#' }
#' @source \url{http://www.stat.fi}
"municipality_key_2016"
#' Vuoden 2015 kunnat erilaisilla alueluokituksilla
#'
#' Data jolla kuntatason datoja voidaan aggregoida ylemmälle tasolla
#'
#' @format A data frame with 317 rows and 16 variables:
#' \describe{
#'   \item{kunta}{Kuntanumero}
#'   \item{name}{Kunnan nimi suomeksi}
#'   \item{avi_code}{Aluehallintoviraston koodi}
#'   \item{avi_name}{Aluehallintoviraston nimi}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen koodi}
#'   \item{ely_name}{Elinkeino-, liikenne- ja ympäristökeskuksen nimi}
#'   \item{kr_code}{Tilastokeskuksen tilastollisen kuntaluokituksen koodi}
#'   \item{kr_name}{Tilastokeskuksen tilastollisen kuntaluokituksen nimi}
#'   \item{mk_code}{Maakunnan koodi}
#'   \item{mk_name}{Maakunnan nimi}
#'   \item{sa_code}{Suuralueen koodi}
#'   \item{sa_name}{Suuralueen nimi}
#'   \item{sk_code}{Seutukunnan koodi}
#'   \item{sk_name}{Seutukunnan nimi}
#'   \item{va_code}{Vaalipiirin koodi}
#'   \item{va_name}{Vaalipiirin nimi}
#' }
#' @source \url{http://www.stat.fi/meta/luokitukset/kunta/001-2015/luokitusavaimet.html}
"municipality_key_2015"
#' Vuoden 2014 kunnat erilaisilla alueluokituksilla
#'
#' Data jolla kuntatason datoja voidaan aggregoida ylemmälle tasolla
#'
#' @format A data frame with 320 rows and 14 variables:
#' \describe{
#'   \item{kunta}{Kuntanumero}
#'   \item{name}{Kunnan nimi suomeksi}
#'   \item{avi_code}{Aluehallintoviraston koodi}
#'   \item{avi_name}{Aluehallintoviraston nimi}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen koodi}
#'   \item{ely_name}{Elinkeino-, liikenne- ja ympäristökeskuksen nimi}
#'   \item{kr_code}{Tilastokeskuksen tilastollisen kuntaluokituksen koodi}
#'   \item{kr_name}{Tilastokeskuksen tilastollisen kuntaluokituksen nimi}
#'   \item{mk_code}{Maakunnan koodi}
#'   \item{mk_name}{Maakunnan nimi}
#'   \item{sa_code}{Suuralueen koodi}
#'   \item{sa_name}{Suuralueen nimi}
#'   \item{sp_code}{Sairaanhoitopiirin koodi}
#'   \item{sp_name}{Sairaanhoitopiirin nimi}
#' }
#' @source \url{http://www.stat.fi/meta/luokitukset/kunta/001-2014/luokitusavaimet.html}
"municipality_key_2014"
#' Vuoden 2013 kunnat erilaisilla alueluokituksilla
#'
#' Data jolla kuntatason datoja voidaan aggregoida ylemmälle tasolla
#'
#' @format A data frame with 320 rows and 20 variables:
#' \describe{
#'   \item{kunta}{Kuntanumero}
#'   \item{name}{Kunnan nimi suomeksi}
#'   \item{avi_code}{Aluehallintoviraston koodi}
#'   \item{avi_name}{Aluehallintoviraston nimi}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen koodi}
#'   \item{ely_name}{Elinkeino-, liikenne- ja ympäristökeskuksen nimi}
#'   \item{kr_code}{Tilastokeskuksen tilastollisen kuntaluokituksen koodi}
#'   \item{kr_name}{Tilastokeskuksen tilastollisen kuntaluokituksen nimi}
#'   \item{mk_code}{Maakunnan koodi}
#'   \item{mk_name}{Maakunnan nimi}
#'   \item{sa_code}{Suuralueen koodi}
#'   \item{sa_name}{Suuralueen nimi}
#'   \item{sk_code}{Seutukunnan koodi}
#'   \item{sk_name}{Seutukunnan nimi}
#'   \item{sp_code}{Sairaanhoitopiirin koodi}
#'   \item{sp_name}{Sairaanhoitopiirin nimi}
#'   \item{tk_code}{Työssäköyntialueen koodi}
#'   \item{tk_name}{Työssäkäyntialueen nimi}
#'   \item{va_code}{Vaalipiirin koodi}
#'   \item{va_name}{Vaalipiirin nimi}
#' }
#' @source \url{http://www.stat.fi/meta/luokitukset/kunta/001-2013/luokitusavaimet.html}
"municipality_key_2013"
