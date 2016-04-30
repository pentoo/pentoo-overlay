# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 eutils

DESCRIPTION="GUI for the Pyew malware analysis and Radare the reverse engineering framework"
HOMEPAGE="https://inguma.eu/projects/bokken"
SRC_URI="https://github.com/inguma/bokken/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+radare"

DEPEND=""
RDEPEND="radare? ( dev-libs/radare2-bindings[python]
	>=dev-util/radare2-0.9.6
	dev-python/pillow
	dev-python/pygtksourceview
	dev-python/pygraphviz
	dev-python/psycopg
	)"
# TODO:
# pyew? ( dev-util/pyew )
# app-text/htmltidy
# tidy

src_prepare(){
	epatch "${FILESDIR}"/${P}_radare.patch
}

src_install() {
	rm README LICENSE

	dodir /usr/share/${PN}/
	cp -R * "${ED}"/usr/share/${PN}/

	python_fix_shebang "${ED}"/usr/share/${PN}/${PN}.py
	dobin "${FILESDIR}/${PN}"
}
