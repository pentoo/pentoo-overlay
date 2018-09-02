# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="RetDec is a retargetable machine-code decompiler based on LLVM."
HOMEPAGE="https://github.com/avast-tl/retdec"
SRC_URI="https://github.com/avast-tl/retdec/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc external"

RDEPEND="|| ( app-arch/upx-ucl app-arch/upx-bin )
	sys-devel/bc
	sys-devel/bison
	sys-devel/flex
	dev-ruby/pkg-config
	sys-apps/coreutils
	sys-libs/zlib
	sys-libs/ncurses:*

	dev-libs/libdwarf

	doc? ( media-gfx/graphviz
		app-doc/doxygen )"
DEPEND="${RDEPEND}
	dev-util/cmake"

#	dev-libs/jsoncpp
#	dev-libs/rapidjson
#	dev-libs/tinyxml2

CMAKE_REMOVE_MODULES_LIST="FindJsoncpp FindRapidjson FindTynyxml2 FindLibdwarf FindOpenssl"

src_prepare(){
	#https://github.com/avast-tl/retdec/issues/357

	#compile with system dwarf
	sed "s|libdwarf|dwarf elf z|g" -i ./src/cpdetect/CMakeLists.txt
	sed "s|libdwarf|dwarf elf z|g" -i ./src/dwarfparser/CMakeLists.txt

	#FIXME: do not download files here
	#use system files
#	sed "s|add_subdirectory(jsoncpp)|#add_subdirectory(jsoncpp)|g" -i ./deps/CMakeLists.txt
#/data/notmpfs/portage/dev-util/retdec-3.1/work/retdec-3.1/include/retdec/config/base.h:16:10: fatal error: json/json.h: No such file or directory
# #include <json/json.h>
#	sed "s|add_subdirectory(rapidjson)|#add_subdirectory(rapidjson)|g" -i ./deps/CMakeLists.txt
#	sed "s|add_subdirectory(tinyxml2)|#add_subdirectory(tinyxml2)|g" -i ./deps/CMakeLists.txt
	sed "s|add_subdirectory(libdwarf)|#add_subdirectory(libdwarf)|g" -i ./deps/CMakeLists.txt

	sed "s|INSTALL_PATH=\"\$1\"|INSTALL_PATH=\"${D}\$1\"|g" -i ./cmake/install-share.sh
	if use !external; then
		sed "s|include(|#include(|g" -i ./CMakeLists.txt
	fi

	sed "s|OUT=\"\$3\"|OUT=\"${D}\$3\"|g" -i ./support/yara_patterns/tools/compile-yara.sh

	cmake-utils_src_prepare
	eapply_user
}

src_configure() {

#-Dbtrfs-snapshot=$(usex btrfs)
#-DRETDEC_DOC=ON
#-DRETDEC_TESTS=ON
#-DCMAKE_BUILD_TYPE=Debug

	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake -DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
}
