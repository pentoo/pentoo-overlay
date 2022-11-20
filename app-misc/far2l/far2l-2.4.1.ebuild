# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#CMAKE_MAKEFILE_GENERATOR ?= ninja
CMAKE_MAKEFILE_GENERATOR=emake
CMAKE_IN_SOURCE_BUILD=1
CMAKE_VERBOSE=ON
CMAKE_BUILD_TYPE=Release

inherit cmake

DESCRIPTION="Linux port of FAR v2"
HOMEPAGE="https://github.com/elfmz/far2l/"
SRC_URI="https://github.com/elfmz/far2l/archive/refs/tags/v_${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64 ~arm64 x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="+uchardet X +ssh nfs +samba webdav"

DEPEND="
	dev-libs/xerces-c
	uchardet? ( app-i18n/uchardet )
	dev-util/cmake
	dev-libs/spdlog

	X? ( x11-libs/wxGTK )
	webdav? ( net-libs/neon )
	ssh? ( net-libs/libssh )
	nfs? ( net-fs/libnfs )
	samba? ( net-fs/samba )
"
RDEPEND="${DEPEND}"
#BDEPEND=""

PATCHES=( "${FILESDIR}/cmakelist.patch" )

S="${WORKDIR}/${PN}-v_${PV}"

src_configure() {

	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DUSEWX=$(usex X yes no)
		# automatic charset detection
		-DUSEUCD=$(usex uchardet yes no)
	)

# -DPYTHON=yes
#ALIGN AUTOWRAP CALC COLORER COMPARE DRAWLINE EDITCASE EDITORCOMP FARFTP FILECASE INCSRCH INSIDE MULTIARC NETROCKS SIMPLEINDENT TMPPANEL

	cmake_src_configure
}

src_install() {
	emake DESTDIR="${D}" install

	dosym "${EPREFIX}"/usr/bin/far2l /usr/lib/far2l/far2l_askpass
	dosym "${EPREFIX}"/usr/bin/far2l /usr/lib/far2l/far2l_sudoapp

	newbin - far <<-EOF
		#!/bin/sh
		/usr/bin/far2l "\$@" --tty
	EOF

}
