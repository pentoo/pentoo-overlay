# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit subversion distutils

DESCRIPTION="generic web application fingerprinter that produces results by examining a small set of static files"
HOMEPAGE="http://blindelephant.sourceforge.net/"
ESVN_REPO_URI="https://${PN}.svn.sourceforge.net/svnroot/${PN}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	cd trunk/src
	distutils_src_compile
}

src_install() {
	cd trunk/src
	distutils_src_install
	dodoc "${S}"/trunk/README "${S}"/trunk/doc/*
	insinto /usr/share/${PN}
	doins -r "${S}"/trunk/tools/*
}
