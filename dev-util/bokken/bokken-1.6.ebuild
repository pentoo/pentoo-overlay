# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="GUI for the Pyew malware analysis tool and Radare the reverse engineering framework"
HOMEPAGE="https://inguma.eu/projects/bokken"
SRC_URI="https://inguma.eu/attachments/download/197/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+radare"

DEPEND=""
RDEPEND="radare? ( dev-libs/radare2-bindings[python]
	>=dev-util/radare2-0.9.6 )"
# TODO:
# pyew? ( dev-util/pyew )
# app-text/htmltidy
# psyco
# tidy

src_prepare(){
	epatch "${FILESDIR}"/radare-0.9.6.patch
}

src_install() {
	rm README LICENSE

	dodir /usr/share/${PN}/
	cp -R * "${ED}"/usr/share/${PN}/

	python_fix_shebang "${ED}"/usr/share/${PN}/${PN}.py
	dobin "${FILESDIR}/${PN}"
}
