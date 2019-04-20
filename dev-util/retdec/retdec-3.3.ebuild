# Copyright 1999-2019 Gentoo Authors
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
IUSE="doc system-libs"

RDEPEND="|| ( app-arch/upx-ucl app-arch/upx-bin )
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

	system-libs? (
		dev-libs/elfio
		dev-libs/jsoncpp
		sys-devel/llvm
		dev-libs/rapidjson
		dev-libs/tinyxml2
	)

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

	#FIXME: do not download files here
	#https://github.com/avast/retdec/issues/356
	#use system files
#	sed '/add_subdirectory(jsoncpp)/d' -i ./deps/CMakeLists.txt
#/data/notmpfs/portage/dev-util/retdec-3.1/work/retdec-3.1/include/retdec/config/base.h:16:10: fatal error: json/json.h: No such file or directory
# #include <json/json.h>
#	sed "s|add_subdirectory(rapidjson)|#add_subdirectory(rapidjson)|g" -i ./deps/CMakeLists.txt
#	sed "s|add_subdirectory(tinyxml2)|#add_subdirectory(tinyxml2)|g" -i ./deps/CMakeLists.txt
#	sed '/add_subdirectory(llvm)/d' -i ./deps/CMakeLists.txt

	sed '/add_subdirectory(libdwarf)/d' -i ./deps/CMakeLists.txt
	sed '/add_subdirectory(capstone)/d' -i ./deps/CMakeLists.txt

	sed "s|get_install_path(sys.argv)| \"${D}\" + get_install_path(sys.argv)|g" -i ./support/install-share.py
	sed "s|output = os.path.join|output = \"${D}\" + os.path.join|g" -i ./support/install-yara.py

#	if use system-libs; then
#		sed '/add_subdirectory(deps)/d' -i ./CMakeLists.txt
#	fi

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
		-DRETDEC_FORCE_OPENSSL_BUILD=0
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake -DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
}
