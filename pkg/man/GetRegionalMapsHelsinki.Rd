\name{GetRegionalMapsHelsinki}
\alias{GetRegionalMapsHelsinki}
\title{Retrieve HKK Seutukartta data}
\usage{
  GetRegionalMapsHelsinki(map)
}
\arguments{
  \item{map}{A string. Specify the name of the HKK data set
  to retrieve. Options: "A_es_pie", "a_hy_suu", "a_ki_pie",
  "a_nu_til", "a_tu_til", "l_jrata", " m_jarvet",
  "N_MERI_R", "A_es_suu", "a_hy_til", "a_ki_suu",
  "a_pkspie", "a_va_kos", "l_kiitor", "m_joet", "
  N_MERI_S", "a_es_til", "a_ja_pie", "a_ki_til",
  "a_pkstil", "a_va_suu", "l_metras", "m_meri", "
  N_PAIK_R", "a_hk_osa", "a_ja_til", "a_kunta", "
  a_pksuur", "a_vi_pie", "l_metror", "m_rantav",
  "N_PAIK_S", "a_hk_per", "a_ka_pie", "a_ma_pie",
  "a_po_til", "a_vi_suu", "l_tiest2", "m_teolal",
  "a_hk_pie", "a_ka_til", "a_ma_til", "a_si_pie",
  "a_vi_til", "l_tiesto", "m_vihral", "a_hk_suu",
  "a_ke_pie", "a_nu_pie", "a_tu_pie", "Copyrig", "
  Maankay2", "N_KOS_R", "a_hy_pie", "a_ke_til", "a_nu_suu",
  "a_tu_suu", "l_jasema", "m_asalue", "N_KOS_S"}
}
\value{
  Shape object (from SpatialPolygonsDataFrame class)
}
\description{
  Retrieves Seutukartta data from Helsinki Real Estate
  Department (Helsingin kaupungin kiinteistovirasto, HKK)
  through the HKK website
  http://kartta.hel.fi/avoindata/index.html
}
\details{
  For licensing information and other details, see
  http://kartta.hel.fi/avoindata/aineistot/Seutukartan%20avoimen%20datan%20lisenssi_1_11_2011.pdf
}
\examples{
# tab <- GetRegionalMapsHelsinki("m_rantav")
}
\author{
  Joona Lehtomaki and Leo Lahti
  \email{louhos@googlegroups.com}
}
\references{
  See citation("helsinki")
}

