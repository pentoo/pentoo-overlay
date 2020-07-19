# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

AVC=( $(ver_rs 1- ' ') )
MY_PV="R${AVC[0]}_${AVC[1]}"

DESCRIPTION="Free diagnostic software for OBD-II compliant motor vehicles"
HOMEPAGE="https://github.com/fenugrec/freediag"
SRC_URI="https://github.com/fenugrec/freediag/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="gui"

DEPEND="gui? ( x11-libs/fltk:* )"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}_fix_scangui_compiling.patch" )

DOCS=( AUTHORS CHANGES COPYING README doc )

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	sed -i \
		-e 's:"README_v${PKGVERSIONMAJOR}_${PKGVERSIONMINOR}.txt"::g' \
		CMakeLists.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILDGUI="$(usex gui)"
		-DUSE_RCFILE=ON
		-DUSE_INIFILE=ON
	)

	cmake_src_configure
}
