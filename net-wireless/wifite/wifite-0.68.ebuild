# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

EAPI=3
PYTHON_DEPEND="2:2.6"
PYTHON_USE_WITH="tk"
PYTHON_USE_WITH_OPT="tk"

inherit python eutils versionator

AVC=( $(get_version_components) )

DESCRIPTION="Mass WEP/WPA cracker"
HOMEPAGE="http://code.google.com/p/wifite/"
SRC_URI="http://wifite.googlecode.com/svn-history/r${AVC[1]}/trunk/wifite.py"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dict extra tk"

DEPEND=""
RDEPEND="net-wireless/aircrack-ng
	dev-python/pexpect
	dict? ( sys-apps/cracklib-words )
	extra? ( app-crypt/pyrit
		net-wireless/cowpatty
		net-analyzer/macchanger )
	tk? ( x11-terms/xterm )"

S=${WORKDIR}/${PN}

pkg_setup() {
    python_set_active_version 2
    python_pkg_setup
}

src_unpack() {
	mkdir "${S}"
	cp "${DISTDIR}"/${A} "${S}/${PN}"
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-noupgrade.patch
}

src_install() {
	dobin wifite
}
