#' Vuoden 2019 kunnat erilaisilla alueluokituksilla
#'
#' Data jolla kuntatason datoja voidaan aggregoida ylemmälle tasolla
#'
#' @format A data frame with 311 rows and 65 variables:
#' \describe{
#'   \item{kunta}{kunta}
#'   \item{name}{name}
#'   \item{avi_code}{avi_code}
#'   \item{avi_nimi}{avi_nimi}
#'   \item{ely_code}{ely_code}
#'   \item{ely_nimi}{ely_nimi}
#'   \item{kr_code}{kr_code}
#'   \item{kr_nimi}{kr_nimi}
#'   \item{mk_code}{mk_code}
#'   \item{mk_nimi}{mk_nimi}
#'   \item{sa_code}{sa_code}
#'   \item{sa_nimi}{sa_nimi}
#'   \item{sk_code}{sk_code}
#'   \item{sk_nimi}{sk_nimi}
#'   \item{sp_code}{sp_code}
#'   \item{sp_nimi}{sp_nimi}
#'   \item{erva_nimi}{erva_nimi}
#'   \item{erva_code}{erva_code}
#'   \item{va_code}{va_code}
#'   \item{va_nimi}{va_nimi}
#'   \item{vakuutuspiiri_nimi}{vakuutuspiiri_nimi}
#'   \item{vakuutuspiiri_code}{vakuutuspiiri_code}
#'   \item{asumistukialue_nimi}{asumistukialue_nimi}
#'   \item{asumistukialue_code}{asumistukialue_code}
#'   \item{15_64_vuotiaiden_osuus_vaestosta_prosenttia_2017}{15_64_vuotiaiden_osuus_vaestosta_prosenttia_2017}
#'   \item{alkutuotannon_tyopaikkojen_osuus_prosenttia_2016}{alkutuotannon_tyopaikkojen_osuus_prosenttia_2016}
#'   \item{alle_15_vuotiaiden_osuus_vaestosta_prosenttia_2017}{alle_15_vuotiaiden_osuus_vaestosta_prosenttia_2017}
#'   \item{alueella_asuvan_tyollisen_tyovoiman_maara_2016}{alueella_asuvan_tyollisen_tyovoiman_maara_2016}
#'   \item{alueella_olevien_tyopaikkojen_lukumaara_2016}{alueella_olevien_tyopaikkojen_lukumaara_2016}
#'   \item{asuinkunnassaan_tyossakayvien_osuus_prosenttia_2016}{asuinkunnassaan_tyossakayvien_osuus_prosenttia_2016}
#'   \item{asuntokuntien_lukumaara_2017}{asuntokuntien_lukumaara_2017}
#'   \item{elakelaisten_osuus_vaestosta_prosenttia_2016}{elakelaisten_osuus_vaestosta_prosenttia_2016}
#'   \item{jalostuksen_tyopaikkojen_osuus_prosenttia_2016}{jalostuksen_tyopaikkojen_osuus_prosenttia_2016}
#'   \item{konsernin_lainakanta_euroa_asukas_2017}{konsernin_lainakanta_euroa_asukas_2017}
#'   \item{korkea_asteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2017}{korkea_asteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2017}
#'   \item{kuntien_valinen_muuttovoitto_tappio_henkiloa_2017}{kuntien_valinen_muuttovoitto_tappio_henkiloa_2017}
#'   \item{lainakanta_euroa_asukas_2017}{lainakanta_euroa_asukas_2017}
#'   \item{opetus_ja_kulttuuritoiminta_yhteensa_nettokayttokustannukset_euroa_asukas_2017}{opetus_ja_kulttuuritoiminta_yhteensa_nettokayttokustannukset_euroa_asukas_2017}
#'   \item{palvelujen_tyopaikkojen_osuus_prosenttia_2016}{palvelujen_tyopaikkojen_osuus_prosenttia_2016}
#'   \item{perheiden_lukumaara_2017}{perheiden_lukumaara_2017}
#'   \item{rivi_ja_pientaloissa_asuvien_asuntokuntien_osuus_prosenttia_2017}{rivi_ja_pientaloissa_asuvien_asuntokuntien_osuus_prosenttia_2017}
#'   \item{ruotsinkielisten_osuus_vaestosta_prosenttia_2017}{ruotsinkielisten_osuus_vaestosta_prosenttia_2017}
#'   \item{sosiaali_ja_terveystoiminta_yhteensa_nettokayttokustannukset_euroa_asukas_2017}{sosiaali_ja_terveystoiminta_yhteensa_nettokayttokustannukset_euroa_asukas_2017}
#'   \item{syntyneiden_enemmyys_henkiloa_2017}{syntyneiden_enemmyys_henkiloa_2017}
#'   \item{taajama_aste_prosenttia_2017}{taajama_aste_prosenttia_2017}
#'   \item{taloudellinen_huoltosuhde_2016}{taloudellinen_huoltosuhde_2016}
#'   \item{tyollisyysaste_prosenttia_2016}{tyollisyysaste_prosenttia_2016}
#'   \item{tyottomien_osuus_tyovoimasta_prosenttia_2016}{tyottomien_osuus_tyovoimasta_prosenttia_2016}
#'   \item{ulkomaan_kansalaisten_osuus_vaestosta_prosenttia_2017}{ulkomaan_kansalaisten_osuus_vaestosta_prosenttia_2017}
#'   \item{vahintaan_toisen_asteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2017}{vahintaan_toisen_asteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2017}
#'   \item{vakiluku_2017}{vakiluku_2017}
#'   \item{vakiluvun_muutos_edellisesta_vuodesta_prosenttia_2017}{vakiluvun_muutos_edellisesta_vuodesta_prosenttia_2017}
#'   \item{vuokra_asunnoissa_asuvien_asuntokuntien_osuus_prosenttia_2017}{vuokra_asunnoissa_asuvien_asuntokuntien_osuus_prosenttia_2017}
#'   \item{vuosikate_euroa_asukas_2017}{vuosikate_euroa_asukas_2017}
#'   \item{yli_64_vuotiaiden_osuus_vaestosta_prosenttia_2017}{yli_64_vuotiaiden_osuus_vaestosta_prosenttia_2017}
#'   \item{avi_nimi_sv}{avi_nimi_sv}
#'   \item{ely_nimi_sv}{ely_nimi_sv}
#'   \item{mk_nimi_sv}{mk_nimi_sv}
#'   \item{sa_nimi_sv}{sa_nimi_sv}
#'   \item{sa_nimi_sk}{sa_nimi_sk}
#'   \item{sp_nimi_sv}{sp_nimi_sv}
#'   \item{va_nimi_sv}{va_nimi_sv}
#'   \item{vakuutuspiiri_nimi_sv}{vakuutuspiiri_nimi_sv}
#'   \item{name_sv}{name_sv}
#'   \item{name_fi}{name_fi}
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
#'   \item{avi_nimi}{Aluehallintoviraston nimi}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen koodi}
#'   \item{ely_nimi}{Elinkeino-, liikenne- ja ympäristökeskuksen nimi}
#'   \item{hp_code}{Hovioikeuspiirin koodi}
#'   \item{hp_nimi}{Hovioikeuspiirin nimi}
#'   \item{kr_code}{Tilastokeskuksen tilastollisen kuntaluokituksen koodi}
#'   \item{kr_nimi}{Tilastokeskuksen tilastollisen kuntaluokituksen nimi}
#'   \item{mk_code}{Maakunnan koodi}
#'   \item{mk_nimi}{Maakunnan nimi}
#'   \item{sa_code}{Suuralueen koodi}
#'   \item{sa_nimi}{Suuralueen nimi}
#'   \item{sk_code}{Seutukunnan koodi}
#'   \item{sk_nimi}{Seutukunnan nimi}
#'   \item{sp_code}{Sairaanhoitopiirin koodi}
#'   \item{sp_nimi}{Sairaanhoitopiirin nimi}
#'   \item{tk_code}{Työssäköyntialueen koodi}
#'   \item{tk_nimi}{Työssäkäyntialueen nimi}
#'   \item{va_code}{Vaalipiirin koodi}
#'   \item{va_nimi}{Vaalipiirin nimi}
#'   \item{vakuutuspiiri_nimi}{Kelan vakuutuspiirin nimi}
#'   \item{vakuutuspiiri_code}{Kelan vakuutuspiirin koodi (epävirallinen)}
#'   \item{asumistukialue_nimi}{Kelan asumistukialueen nimi}
#'   \item{asumistukialue_code}{Kelan asumistukialueen koodi (epävirallinen)}
#'   \item{erva_nimi}{Erityisvastuualueen nimi}
#'   \item{erva_code}{Erityisvastuualueen koodi (epävirallinen)}
#'   \item{avi_nimi_sv}{avi_nimi_sv}
#'   \item{ely_nimi_sv}{ely_nimi_sv}
#'   \item{mk_nimi_sv}{mk_nimi_sv}
#'   \item{sa_nimi_sv}{sa_nimi_sv}
#'   \item{sa_nimi_sk}{sa_nimi_sk}
#'   \item{sp_nimi_sv}{sp_nimi_sv}
#'   \item{va_nimi_sv}{va_nimi_sv}
#'   \item{vakuutuspiiri_nimi_sv}{vakuutuspiiri_nimi_sv}
#'   \item{15_64_vuotiaiden_osuus_vaestosta_prosenttia_2016}{15_64_vuotiaiden_osuus_vaestosta_prosenttia_2016}
#'   \item{alkutuotannon_tyopaikkojen_osuus_prosenttia_2015}{alkutuotannon_tyopaikkojen_osuus_prosenttia_2015}
#'   \item{alle_15_vuotiaiden_osuus_vaestosta_prosenttia_2016}{alle_15_vuotiaiden_osuus_vaestosta_prosenttia_2016}
#'   \item{alueella_asuvan_tyollisen_tyovoiman_maara_2015}{alueella_asuvan_tyollisen_tyovoiman_maara_2015}
#'   \item{asuinkunnassaan_tyossakayvien_osuus_prosenttia_2015}{asuinkunnassaan_tyossakayvien_osuus_prosenttia_2015}
#'   \item{asuntokuntien_lukumaara_2016}{asuntokuntien_lukumaara_2016}
#'   \item{elakelaisten_osuus_vaestosta_prosenttia_2015}{elakelaisten_osuus_vaestosta_prosenttia_2015}
#'   \item{jalostuksen_tyopaikkojen_osuus_prosenttia_2015}{jalostuksen_tyopaikkojen_osuus_prosenttia_2015}
#'   \item{konsernin_lainakanta_euroa_asukas_2016}{konsernin_lainakanta_euroa_asukas_2016}
#'   \item{korkea_asteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2016}{korkea_asteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2016}
#'   \item{kunnassa_olevien_tyopaikkojen_lukumaara_2015}{kunnassa_olevien_tyopaikkojen_lukumaara_2015}
#'   \item{kuntien_valinen_muuttovoitto_tappio_henkiloa_2016}{kuntien_valinen_muuttovoitto_tappio_henkiloa_2016}
#'   \item{lainakanta_euroa_asukas_2016}{lainakanta_euroa_asukas_2016}
#'   \item{opetus_ja_kulttuuritoiminta_yhteensa_nettokayttokustannukset_euroa_asukas_2016}{opetus_ja_kulttuuritoiminta_yhteensa_nettokayttokustannukset_euroa_asukas_2016}
#'   \item{palvelujen_tyopaikkojen_osuus_prosenttia_2015}{palvelujen_tyopaikkojen_osuus_prosenttia_2015}
#'   \item{perheiden_lukumaara_2016}{perheiden_lukumaara_2016}
#'   \item{rivi_ja_pientaloissa_asuvien_asuntokuntien_osuus_prosenttia_2016}{rivi_ja_pientaloissa_asuvien_asuntokuntien_osuus_prosenttia_2016}
#'   \item{ruotsinkielisten_osuus_vaestosta_prosenttia_2016}{ruotsinkielisten_osuus_vaestosta_prosenttia_2016}
#'   \item{sosiaali_ja_terveystoiminta_yhteensa_nettokayttokustannukset_euroa_asukas_2016}{sosiaali_ja_terveystoiminta_yhteensa_nettokayttokustannukset_euroa_asukas_2016}
#'   \item{syntyneiden_enemmyys_henkiloa_2016}{syntyneiden_enemmyys_henkiloa_2016}
#'   \item{taajama_aste_prosenttia_2016}{taajama_aste_prosenttia_2016}
#'   \item{taloudellinen_huoltosuhde_2015}{taloudellinen_huoltosuhde_2015}
#'   \item{tyollisyysaste_prosenttia_2015}{tyollisyysaste_prosenttia_2015}
#'   \item{tyottomien_osuus_tyovoimasta_prosenttia_2015}{tyottomien_osuus_tyovoimasta_prosenttia_2015}
#'   \item{ulkomaan_kansalaisten_osuus_vaestosta_prosenttia_2016}{ulkomaan_kansalaisten_osuus_vaestosta_prosenttia_2016}
#'   \item{vahintaan_toisen_asteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2016}{vahintaan_toisen_asteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2016}
#'   \item{vakiluku_2016}{vakiluku_2016}
#'   \item{vakiluvun_muutos_edellisesta_vuodesta_prosenttia_2016}{vakiluvun_muutos_edellisesta_vuodesta_prosenttia_2016}
#'   \item{vuokra_asunnoissa_asuvien_asuntokuntien_osuus_prosenttia_2016}{vuokra_asunnoissa_asuvien_asuntokuntien_osuus_prosenttia_2016}
#'   \item{vuosikate_euroa_asukas_2016}{vuosikate_euroa_asukas_2016}
#'   \item{yli_64_vuotiaiden_osuus_vaestosta_prosenttia_2016}{yli_64_vuotiaiden_osuus_vaestosta_prosenttia_2016}
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
#'   \item{avi_nimi}{Aluehallintoviraston nimi}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen koodi}
#'   \item{ely_nimi}{Elinkeino-, liikenne- ja ympäristökeskuksen nimi}
#'   \item{hp_code}{Hovioikeuspiirin koodi}
#'   \item{hp_nimi}{Hovioikeuspiirin nimi}
#'   \item{kr_code}{Tilastokeskuksen tilastollisen kuntaluokituksen koodi}
#'   \item{kr_nimi}{Tilastokeskuksen tilastollisen kuntaluokituksen nimi}
#'   \item{mk_code}{Maakunnan koodi}
#'   \item{mk_nimi}{Maakunnan nimi}
#'   \item{sa_code}{Suuralueen koodi}
#'   \item{sa_nimi}{Suuralueen nimi}
#'   \item{sk_code}{Seutukunnan koodi}
#'   \item{sk_nimi}{Seutukunnan nimi}
#'   \item{sp_code}{Sairaanhoitopiirin koodi}
#'   \item{sp_nimi}{Sairaanhoitopiirin nimi}
#'   \item{tk_code}{Työssäköyntialueen koodi}
#'   \item{tk_nimi}{Työssäkäyntialueen nimi}
#'   \item{va_code}{Vaalipiirin koodi}
#'   \item{va_nimi}{Vaalipiirin nimi}
#'   \item{vakuutuspiiri_nimi}{Kelan vakuutuspiirin nimi}
#'   \item{vakuutuspiiri_code}{Kelan vakuutuspiirin koodi (epävirallinen)}
#'   \item{asumistukialue_nimi}{Kelan asumistukialueen nimi}
#'   \item{asumistukialue_code}{Kelan asumistukialueen koodi (epävirallinen)}
#'   \item{erva_nimi}{Erityisvastuualueen nimi}
#'   \item{erva_code}{Erityisvastuualueen koodi (epävirallinen)}
#'   \item{avi_nimi_sv}{avi_nimi_sv}
#'   \item{ely_nimi_sv}{ely_nimi_sv}
#'   \item{kr_nimi_sv}{kr_nimi_sv}
#'   \item{mk_nimi_sv}{mk_nimi_sv}
#'   \item{sp_nimi_sv}{sp_nimi_sv}
#'   \item{vakuutuspiiri_nimi_sv}{vakuutuspiiri_nimi_sv}
#'   \item{15_64_vuotiaiden_osuus_vaestosta_prosenttia_2016}{15_64_vuotiaiden_osuus_vaestosta_prosenttia_2016}
#'   \item{alkutuotannon_tyopaikkojen_osuus_prosenttia_2015}{alkutuotannon_tyopaikkojen_osuus_prosenttia_2015}
#'   \item{alle_15_vuotiaiden_osuus_vaestosta_prosenttia_2016}{alle_15_vuotiaiden_osuus_vaestosta_prosenttia_2016}
#'   \item{alueella_asuvan_tyollisen_tyovoiman_maara_2015}{alueella_asuvan_tyollisen_tyovoiman_maara_2015}
#'   \item{asuinkunnassaan_tyossakayvien_osuus_prosenttia_2015}{asuinkunnassaan_tyossakayvien_osuus_prosenttia_2015}
#'   \item{asuntokuntien_lukumaara_2016}{asuntokuntien_lukumaara_2016}
#'   \item{elakelaisten_osuus_vaestosta_prosenttia_2015}{elakelaisten_osuus_vaestosta_prosenttia_2015}
#'   \item{jalostuksen_tyopaikkojen_osuus_prosenttia_2015}{jalostuksen_tyopaikkojen_osuus_prosenttia_2015}
#'   \item{konsernin_lainakanta_euroa_asukas_2016}{konsernin_lainakanta_euroa_asukas_2016}
#'   \item{korkea_asteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2016}{korkea_asteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2016}
#'   \item{kunnassa_olevien_tyopaikkojen_lukumaara_2015}{kunnassa_olevien_tyopaikkojen_lukumaara_2015}
#'   \item{kuntien_valinen_muuttovoitto_tappio_henkiloa_2016}{kuntien_valinen_muuttovoitto_tappio_henkiloa_2016}
#'   \item{lainakanta_euroa_asukas_2016}{lainakanta_euroa_asukas_2016}
#'   \item{opetus_ja_kulttuuritoiminta_yhteensa_nettokayttokustannukset_euroa_asukas_2016}{opetus_ja_kulttuuritoiminta_yhteensa_nettokayttokustannukset_euroa_asukas_2016}
#'   \item{palvelujen_tyopaikkojen_osuus_prosenttia_2015}{palvelujen_tyopaikkojen_osuus_prosenttia_2015}
#'   \item{perheiden_lukumaara_2016}{perheiden_lukumaara_2016}
#'   \item{rivi_ja_pientaloissa_asuvien_asuntokuntien_osuus_prosenttia_2016}{rivi_ja_pientaloissa_asuvien_asuntokuntien_osuus_prosenttia_2016}
#'   \item{ruotsinkielisten_osuus_vaestosta_prosenttia_2016}{ruotsinkielisten_osuus_vaestosta_prosenttia_2016}
#'   \item{sosiaali_ja_terveystoiminta_yhteensa_nettokayttokustannukset_euroa_asukas_2016}{sosiaali_ja_terveystoiminta_yhteensa_nettokayttokustannukset_euroa_asukas_2016}
#'   \item{syntyneiden_enemmyys_henkiloa_2016}{syntyneiden_enemmyys_henkiloa_2016}
#'   \item{taajama_aste_prosenttia_2016}{taajama_aste_prosenttia_2016}
#'   \item{taloudellinen_huoltosuhde_2015}{taloudellinen_huoltosuhde_2015}
#'   \item{tyollisyysaste_prosenttia_2015}{tyollisyysaste_prosenttia_2015}
#'   \item{tyottomien_osuus_tyovoimasta_prosenttia_2015}{tyottomien_osuus_tyovoimasta_prosenttia_2015}
#'   \item{ulkomaan_kansalaisten_osuus_vaestosta_prosenttia_2016}{ulkomaan_kansalaisten_osuus_vaestosta_prosenttia_2016}
#'   \item{vahintaan_toisen_asteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2016}{vahintaan_toisen_asteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2016}
#'   \item{vakiluku_2016}{vakiluku_2016}
#'   \item{vakiluvun_muutos_edellisesta_vuodesta_prosenttia_2016}{vakiluvun_muutos_edellisesta_vuodesta_prosenttia_2016}
#'   \item{vuokra_asunnoissa_asuvien_asuntokuntien_osuus_prosenttia_2016}{vuokra_asunnoissa_asuvien_asuntokuntien_osuus_prosenttia_2016}
#'   \item{vuosikate_euroa_asukas_2016}{vuosikate_euroa_asukas_2016}
#'   \item{yli_64_vuotiaiden_osuus_vaestosta_prosenttia_2016}{yli_64_vuotiaiden_osuus_vaestosta_prosenttia_2016}
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
#'   \item{avi_nimi}{Aluehallintoviraston nimi}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen koodi}
#'   \item{ely_nimi}{Elinkeino-, liikenne- ja ympäristökeskuksen nimi}
#'   \item{kr_code}{Tilastokeskuksen tilastollisen kuntaluokituksen koodi}
#'   \item{kr_nimi}{Tilastokeskuksen tilastollisen kuntaluokituksen nimi}
#'   \item{mk_code}{Maakunnan koodi}
#'   \item{mk_nimi}{Maakunnan nimi}
#'   \item{sa_code}{Suuralueen koodi}
#'   \item{sa_nimi}{Suuralueen nimi}
#'   \item{sk_code}{Seutukunnan koodi}
#'   \item{sk_nimi}{Seutukunnan nimi}
#'   \item{va_code}{Vaalipiirin koodi}
#'   \item{va_nimi}{Vaalipiirin nimi}
#'   \item{avi_nimi_sv}{avi_nimi_sv}
#'   \item{ely_nimi_sv}{ely_nimi_sv}
#'   \item{kr_nimi_sv}{kr_nimi_sv}
#'   \item{mk_nimi_sv}{mk_nimi_sv}
#'   \item{15_64_vuotiaiden_osuus_vaestosta_prosenttia_2014}{15_64_vuotiaiden_osuus_vaestosta_prosenttia_2014}
#'   \item{alkutuotannon_tyopaikkojen_osuus_prosenttia_2013}{alkutuotannon_tyopaikkojen_osuus_prosenttia_2013}
#'   \item{alle_15_vuotiaiden_osuus_vaestosta_prosenttia_2014}{alle_15_vuotiaiden_osuus_vaestosta_prosenttia_2014}
#'   \item{alueella_asuvan_tyollisen_tyovoiman_maara_2013}{alueella_asuvan_tyollisen_tyovoiman_maara_2013}
#'   \item{asuinkunnassaan_tyossakayvien_osuus_prosenttia_2013}{asuinkunnassaan_tyossakayvien_osuus_prosenttia_2013}
#'   \item{asuntokuntien_lukumaara_2014}{asuntokuntien_lukumaara_2014}
#'   \item{elakelaisten_osuus_vaestosta_prosenttia_2013}{elakelaisten_osuus_vaestosta_prosenttia_2013}
#'   \item{jalostuksen_tyopaikkojen_osuus_prosenttia_2013}{jalostuksen_tyopaikkojen_osuus_prosenttia_2013}
#'   \item{korkea_asteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2014}{korkea_asteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2014}
#'   \item{kunnassa_olevien_tyopaikkojen_lukumaara_2013}{kunnassa_olevien_tyopaikkojen_lukumaara_2013}
#'   \item{kuntien_valinen_muuttovoitto_tappio_henkiloa_2014}{kuntien_valinen_muuttovoitto_tappio_henkiloa_2014}
#'   \item{palvelujen_tyopaikkojen_osuus_prosenttia_2013}{palvelujen_tyopaikkojen_osuus_prosenttia_2013}
#'   \item{perheiden_lukumaara_2014}{perheiden_lukumaara_2014}
#'   \item{rivi_ja_pientaloissa_asuvien_asuntokuntien_osuus_prosenttia_2014}{rivi_ja_pientaloissa_asuvien_asuntokuntien_osuus_prosenttia_2014}
#'   \item{ruotsinkielisten_osuus_vaestosta_prosenttia_2014}{ruotsinkielisten_osuus_vaestosta_prosenttia_2014}
#'   \item{syntyneiden_enemmyys_henkiloa_2014}{syntyneiden_enemmyys_henkiloa_2014}
#'   \item{taajama_aste_prosenttia_2014}{taajama_aste_prosenttia_2014}
#'   \item{taloudellinen_huoltosuhde_2013}{taloudellinen_huoltosuhde_2013}
#'   \item{tyollisyysaste_prosenttia_2013}{tyollisyysaste_prosenttia_2013}
#'   \item{tyottomien_osuus_tyovoimasta_prosenttia_2013}{tyottomien_osuus_tyovoimasta_prosenttia_2013}
#'   \item{ulkomaan_kansalaisten_osuus_vaestosta_prosenttia_2014}{ulkomaan_kansalaisten_osuus_vaestosta_prosenttia_2014}
#'   \item{vahintaan_keskiasteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2014}{vahintaan_keskiasteen_tutkinnon_suorittaneiden_osuus_15_vuotta_tayttaneista_prosenttia_2014}
#'   \item{vakiluku_2014}{vakiluku_2014}
#'   \item{vakiluvun_muutos_edellisesta_vuodesta_prosenttia_2014}{vakiluvun_muutos_edellisesta_vuodesta_prosenttia_2014}
#'   \item{vuokra_asunnoissa_asuvien_asuntokuntien_osuus_prosenttia_2014}{vuokra_asunnoissa_asuvien_asuntokuntien_osuus_prosenttia_2014}
#'   \item{yli_64_vuotiaiden_osuus_vaestosta_prosenttia_2014}{yli_64_vuotiaiden_osuus_vaestosta_prosenttia_2014}
#' }
#' @source \url{http://www.stat.fi}
"municipality_key_2016"
# urli: http://www.stat.fi/meta/luokitukset/kunta/001-2016/luokitusavaimet.html

#' Vuoden 2015 kunnat erilaisilla alueluokituksilla
#'
#' Data jolla kuntatason datoja voidaan aggregoida ylemmälle tasolla
#'
#' @format A data frame with 317 rows and 16 variables:
#' \describe{
#'   \item{kunta}{Kuntanumero}
#'   \item{name}{Kunnan nimi suomeksi}
#'   \item{avi_code}{Aluehallintoviraston koodi}
#'   \item{avi_nimi}{Aluehallintoviraston nimi}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen koodi}
#'   \item{ely_nimi}{Elinkeino-, liikenne- ja ympäristökeskuksen nimi}
#'   \item{kr_code}{Tilastokeskuksen tilastollisen kuntaluokituksen koodi}
#'   \item{kr_nimi}{Tilastokeskuksen tilastollisen kuntaluokituksen nimi}
#'   \item{mk_code}{Maakunnan koodi}
#'   \item{mk_nimi}{Maakunnan nimi}
#'   \item{sa_code}{Suuralueen koodi}
#'   \item{sa_nimi}{Suuralueen nimi}
#'   \item{sk_code}{Seutukunnan koodi}
#'   \item{sk_nimi}{Seutukunnan nimi}
#'   \item{va_code}{Vaalipiirin koodi}
#'   \item{va_nimi}{Vaalipiirin nimi}
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
#'   \item{avi_nimi}{Aluehallintoviraston nimi}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen koodi}
#'   \item{ely_nimi}{Elinkeino-, liikenne- ja ympäristökeskuksen nimi}
#'   \item{kr_code}{Tilastokeskuksen tilastollisen kuntaluokituksen koodi}
#'   \item{kr_nimi}{Tilastokeskuksen tilastollisen kuntaluokituksen nimi}
#'   \item{mk_code}{Maakunnan koodi}
#'   \item{mk_nimi}{Maakunnan nimi}
#'   \item{sa_code}{Suuralueen koodi}
#'   \item{sa_nimi}{Suuralueen nimi}
#'   \item{sp_code}{Sairaanhoitopiirin koodi}
#'   \item{sp_nimi}{Sairaanhoitopiirin nimi}
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
#'   \item{avi_nimi}{Aluehallintoviraston nimi}
#'   \item{ely_code}{Elinkeino-, liikenne- ja ympäristökeskuksen koodi}
#'   \item{ely_nimi}{Elinkeino-, liikenne- ja ympäristökeskuksen nimi}
#'   \item{kr_code}{Tilastokeskuksen tilastollisen kuntaluokituksen koodi}
#'   \item{kr_nimi}{Tilastokeskuksen tilastollisen kuntaluokituksen nimi}
#'   \item{mk_code}{Maakunnan koodi}
#'   \item{mk_nimi}{Maakunnan nimi}
#'   \item{sa_code}{Suuralueen koodi}
#'   \item{sa_nimi}{Suuralueen nimi}
#'   \item{sk_code}{Seutukunnan koodi}
#'   \item{sk_nimi}{Seutukunnan nimi}
#'   \item{sp_code}{Sairaanhoitopiirin koodi}
#'   \item{sp_nimi}{Sairaanhoitopiirin nimi}
#'   \item{tk_code}{Työssäköyntialueen koodi}
#'   \item{tk_nimi}{Työssäkäyntialueen nimi}
#'   \item{va_code}{Vaalipiirin koodi}
#'   \item{va_nimi}{Vaalipiirin nimi}
#' }
#' @source \url{http://www.stat.fi/meta/luokitukset/kunta/001-2013/luokitusavaimet.html}
"municipality_key_2013"