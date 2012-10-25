# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="*:2.7"
DISTUTILS_SRC_TEST=setup.py

MY_PN=Impacket
MY_P=${MY_PN}-${PV}

inherit distutils subversion

DESCRIPTION="A collection of Python classes focused on providing access to network packets"
HOMEPAGE="http://code.google.com/p/impacket"
ESVN_REPO_URI="http://impacket.googlecode.com/svn/trunk/"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS=""
IUSE=""

#S=${WORKDIR}/impacket

src_configure() {
	cd "${S}"/impacket
	default
}

src_compile() {
	cd "${S}"/impacket
	default
}

src_install() {
	cd "${S}"/impacket
	default
}
