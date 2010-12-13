# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

EAPI=3

inherit python

DESCRIPTION="Mass WEP/WPA cracker"
HOMEPAGE="http://code.google.com/p/wifite/"
SRC_URI="http://wifite.googlecode.com/files/wifite_r54.py"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="extra wep"

DEPEND=""
#	tk? ( python-tk :http://packages.debian.org/source/lenny/python-stdlib-extensions
#or 	tk? ( dev-lang/python[tk] )
RDEPEND="virtual/python
	net-wireless/aircrack-ng
	extra? ( app-crypt/pyrit )
	wep? ( net-analyzer/macchanger )"

S=${WORKDIR}/${PN}

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}"/${A} "${S}/${PN}"
}

src_install() {
	dobin wifite
}
