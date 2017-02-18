# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

EGIT_COMMIT="a2eafa24a3446a711b13523ec06c17b5a1c6cdc1"
PYTHON_COMPAT=( python2_7 )

inherit eutils python-single-r1

DESCRIPTION="Open source library for SPI/I2C control via FTDI chips"
HOMEPAGE="https://code.google.com/p/libmpsse"
SRC_URI="https://github.com/devttys0/libmpsse/archive/${EGIT_COMMIT}.zip -> ${P}.zip"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc examples python"

RDEPEND="dev-embedded/libftdi:0"
DEPEND="dev-lang/swig
	${RDEPEND}"

#https://github.com/devttys0/libmpsse/issues/16
#MAKEOPTS="${MAKEOPTS} -j1"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}/src"

src_configure() {
	epatch ${FILESDIR}/pr-libmpsse-objconf.patch
	econf $(use_enable python )
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
