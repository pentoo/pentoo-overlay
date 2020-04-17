# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="RetDec is a retargetable machine-code decompiler based on LLVM."
HOMEPAGE="https://github.com/avast-tl/retdec"
SRC_URI="https://github.com/avast-tl/retdec/archive/v${PV}.tar.gz -> ${P}.tar.gz"
#FIXME: install-share.py
#https://github.com/avast-tl/retdec-support/releases/download/2019-03-08/retdec-support_2019-03-08.tar.xz

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="|| ( app-arch/upx app-arch/upx-bin )
	sys-devel/bc
	sys-devel/bison
	sys-devel/flex
	dev-ruby/pkg-config
	sys-apps/coreutils
	sys-libs/zlib
	sys-libs/ncurses:*[tinfo]
	dev-libs/libdwarf
	dev-libs/capstone
	dev-libs/openssl:0

	doc? ( media-gfx/graphviz
		app-doc/doxygen )"

DEPEND="${RDEPEND}
	dev-util/cmake"

CMAKE_REMOVE_MODULES_LIST="FindJsoncpp FindRapidjson FindTynyxml2 FindLibdwarf FindOpenssl"

src_prepare(){
	#https://github.com/avast-tl/retdec/issues/357
	#compile with system dwarf
	sed "s|libdwarf|dwarf elf z|g" -i ./src/cpdetect/CMakeLists.txt
	sed "s|libdwarf|dwarf elf z|g" -i ./src/dwarfparser/CMakeLists.txt
	sed '/add_subdirectory(libdwarf)/d' -i ./deps/CMakeLists.txt
	sed '/add_subdirectory(capstone)/d' -i ./deps/CMakeLists.txt

	sed "s|get_install_path(sys.argv)| \"${D}\" + get_install_path(sys.argv)|g" -i ./support/install-share.py
	sed "s|output = os.path.join|output = \"${D}\" + os.path.join|g" -i ./support/install-yara.py

	cmake-utils_src_prepare
	eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
		-DRETDEC_FORCE_OPENSSL_BUILD=0
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake -DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
}
