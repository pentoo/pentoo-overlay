# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_{5,6,7} )
inherit subversion distutils-r1

DESCRIPTION="generic web application fingerprinter that produces results by examining a small set of static files"
HOMEPAGE="http://blindelephant.sourceforge.net/"
ESVN_REPO_URI="https://svn.code.sf.net/p/${PN}/code/trunk"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	cd src || die "unable to find src directory"
	distutils-r1_src_compile
}

src_install() {
	cd src || die "unable to find src directory"
	distutils-r1_src_install
	dodoc "${S}"/README "${S}"/doc/*
	insinto /usr/share/${PN}
	doins -r "${S}"/tools/*
}
