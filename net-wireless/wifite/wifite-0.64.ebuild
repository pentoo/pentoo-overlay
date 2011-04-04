# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

EAPI=3
PYTHON_DEPEND="2:2.6"

inherit python

DESCRIPTION="Mass WEP/WPA cracker"
HOMEPAGE="http://code.google.com/p/wifite/"
SRC_URI="http://wifite.googlecode.com/svn-history/r68/trunk/wifite.py"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="extra tk wep"

DEPEND="tk? ( dev-lang/python:2.6[tk] )"

RDEPEND="virtual/python
	net-wireless/aircrack-ng
	extra? ( app-crypt/pyrit
		dev-python/pexpect
		net-wireless/cowpatty )
	wep? ( net-analyzer/macchanger )"

#sys-apps/cracklib-words

S=${WORKDIR}/${PN}

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}"/${A} "${S}/${PN}"
}

src_install() {
	dobin wifite
}
