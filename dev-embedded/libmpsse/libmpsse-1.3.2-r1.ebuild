# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#PYTHON_COMPAT=( python2_7 )
#inherit eutils python-single-r1 autotools

inherit eutils autotools

DESCRIPTION="Open source library for SPI/I2C control via FTDI chips"
HOMEPAGE="https://github.com/l29ah/libmpsse"
#SRC_URI="https://github.com/devttys0/libmpsse/archive/${EGIT_COMMIT}.zip -> ${P}.zip"
SRC_URI="https://github.com/l29ah/libmpsse/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 x86"
#IUSE="doc examples python"
IUSE="doc examples"

RDEPEND="dev-embedded/libftdi:*"
DEPEND="dev-lang/swig
	${RDEPEND}"

S="${WORKDIR}/${P}/src"

src_prepare() {
	eautoconf
	eapply_user
}

src_configure() {
#	econf $(use_enable python)
	econf --disable-python
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ../docs/README*
	if use doc ; then
		dodoc ../docs/AN_135_MPSSE_Basics.pdf
	fi
	if use examples ; then
		insinto /usr/share/${PN}/
		doins -r examples
	fi
}
