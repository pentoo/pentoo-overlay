# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_COMMIT="f1a6744b220d4e7b2c8719e705f56d8c171a6a32"
PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

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
MAKEOPTS="${MAKEOPTS} -j1"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}/src"

src_configure() {
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
