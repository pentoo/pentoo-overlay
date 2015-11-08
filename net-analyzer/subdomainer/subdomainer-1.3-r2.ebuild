# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1

DESCRIPTION="This script will search in Google, Msn.search and Yahoo for subdomains related to the target domain"
HOMEPAGE="http://www.edge-security.com/subdomainer.php"
SRC_URI="http://www.edge-security.com/soft/${P}b.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-python_fix.patch
}

src_install() {
	newbin ${PN}.py ${PN}
	python_fix_shebang "${ED}"usr/bin
	dodoc README
}
