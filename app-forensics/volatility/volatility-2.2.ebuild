# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

PYTHON_DEPEND="2:2.6"

inherit distutils

DESCRIPTION="Forensic tool for analyzing volatile memory"
HOMEPAGE="http://code.google.com/p/volatility/"
SRC_URI="http://volatility.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/libpcre
	dev-python/pycrypto
	>=dev-libs/distorm64-3"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	distutils_src_install
	mkdir "${D}/usr/share/${PN}"
	mv "${D}/usr/plugins" "${D}/usr/share/${PN}"
	mv "${D}/usr/bin/vol.py" "${D}/usr/bin/volatility"
}
