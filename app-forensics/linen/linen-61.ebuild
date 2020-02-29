# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

#MY_P="LinEn_${PV}"
SRC_URI="LinEn_${PV}.zip"
DESCRIPTION="Encase's linen utility"
HOMEPAGE="http://www.encaseenterprise.com/support/LinEn_LicenseAgreement.aspx"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 arm ppc ppc64 x86"
IUSE=""
RDEPEND=""
DEPEND="app-arch/unzip"
RESTRICT="fetch"

S="${WORKDIR}"

src_install() {
	dosbin linen
}

pkg_nofetch() {
	einfo "Please go to ${HOMEPAGE} and accept the license"
	einfo "to download linen. Save it to ${DISTDIR}"
}
