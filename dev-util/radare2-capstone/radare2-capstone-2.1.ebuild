# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv$

EAPI=5

inherit eutils multilib

DESCRIPTION="Plugins for r2 to use capstone as disassembler and code analysis"
HOMEPAGE="https://github.com/radare/radare2-capstone"
SRC_URI="https://github.com/radare/radare2-capstone/archive/cs-2.1.tar.gz -> ${P}.tar.gz"
IUSE=""

LICENSE="BSD"
SLOT="0"

#absolute software
KEYWORDS=""

RDEPEND=""
DEPEND="dev-util/capstone
	dev-util/radare2:="

S=${WORKDIR}/${PN}-cs-${PV}

src_install() {
	# hack copied from one of Makefiles
	R2DIR=$(r2 -hh| grep LIBR_PLUGINS|awk '{print $2}')
	mkdir -p "${D}/${R2DIR}"
	emake DESTDIR="${D}" install
}
