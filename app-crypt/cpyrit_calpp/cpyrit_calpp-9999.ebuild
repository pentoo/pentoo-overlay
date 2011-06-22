# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils python distutils subversion

DESCRIPTION="A GPU-based WPA-PSK and WPA2-PSK cracking tool"
HOMEPAGE="http://code.google.com/p/pyrit/"
ESVN_REPO_URI="http://pyrit.googlecode.com/svn/trunk/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-util/calpp-0.87
	>=x11-drivers/ati-drivers-10.2"
RDEPEND="${DEPEND}"

src_compile() {
	cd "${S}/cpyrit_calpp"
	distutils_src_compile
}

src_install() {
	cd "${S}/cpyrit_calpp"
	distutils_src_install
}
