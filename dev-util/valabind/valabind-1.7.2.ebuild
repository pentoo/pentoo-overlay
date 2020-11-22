# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.40
VALA_USE_DEPEND=vapigen
inherit vala

DESCRIPTION="Valabind is a tool to parse vala or vapi files to transform them into swig files"
HOMEPAGE="https://github.com/radare/valabind"
SRC_URI="https://github.com/radare/valabind/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="$(vala_depend)"
DEPEND="${RDEPEND}
	dev-lang/swig
	virtual/pkgconfig"

src_prepare() {
	#upstream smoked something here
	sed -i -e "s:^GIT_TIP:#GIT_TIP:" Makefile || die
	#they don't detect version properly either
	sed -i -e "s:=valac:=valac-$(vala_best_api_version):" Makefile || die
	sed -i -e "s:\$(shell ./getvv):vala-$(vala_best_api_version):" Makefile || die
	eapply_user
}

src_configure() {
	econf VALAC=valac-$(vala_best_api_version) VALA=vala-$(vala_best_api_version)
}

src_install() {
	emake DESTDIR="${ED}" install
}
