# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils eutils git-r3

DESCRIPTION="Graphical disassembler for a large number of instruction sets"
HOMEPAGE="http://www.emilpro.com/"

EGIT_REPO_URI="https://github.com/SimonKagstrom/emilpro.git"
EGIT_COMMIT="0e8a615d463244a9969df3a0b92b2b77d1c61365"

KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="+system-binutils"

DEPEND="virtual/libelf:0=
	dev-cpp/gtkmm:3.0
	dev-cpp/gtksourceviewmm:3.0
	dev-cpp/libxmlpp:2.6
	net-misc/curl
	dev-libs/capstone
	sys-devel/bison
	sys-apps/texinfo

	system-binutils? ( >=sys-libs/binutils-libs-2.25.1-r2:=[multitarget] )
	"

#	dev-cpp/glibmm
#	dev-cpp/pangomm
#	dev-cpp/cairomm
#	dev-libs/libsigc++:2
#	dev-libs/glib:2

RDEPEND="${DEPEND}"

src_prepare() {
	if use system-binutils; then
		epatch "${FILESDIR}"/${PN}-9999-system-binutils.patch
	else
		sed -i "s#wget -O binutils.tar.bz2 https://ftp.gnu.org/gnu/binutils/binutils-2.23.2.tar.bz2#cp \"${DISTDIR}/binutils-2.23.2.tar.bz2\" ./binutils.tar.bz2#" cmake/BuildBinutils.cmake
	fi
	cmake-utils_src_prepare
}

src_compile() {
	if use system-binutils; then
		cmake-utils_src_compile
	else
		#bundled binutils is broken, always builds with one thread
		#but somehow it still fails if I don't do this
		cd "${BUILD_DIR}"
		emake -j1
	fi
}

src_install() {
	dobin "${BUILD_DIR}"/emilpro
}
