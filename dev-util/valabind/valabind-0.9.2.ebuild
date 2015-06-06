# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

VALA_MIN_API_VERSION=0.18
VALA_USE_DEPEND=vapigen
inherit vala

DESCRIPTION="Valabind is a tool to parse vala or vapi files to transform them into swig files"
HOMEPAGE="https://github.com/radare/valabind"
SRC_URI="https://github.com/radare/valabind/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-lang/vala
	dev-lang/swig"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	#upstream smoked something here
	sed -i -e "s:^GIT_TIP:#GIT_TIP:" Makefile || die
	#they don't detect version properly either
	sed -i -e "s:=valac:=valac-$(vala_best_api_version):" Makefile || die
	sed -i -e "s:\$(shell ./getvv):libvala-$(vala_best_api_version):" Makefile || die
}

#src_compile() {
#	emake -j1 || die "compile failed"
#}

src_install() {
	emake DESTDIR="${ED}" install
}
