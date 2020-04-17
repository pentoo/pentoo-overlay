# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="RetDec is a retargetable machine-code decompiler based on LLVM."
HOMEPAGE="https://github.com/avast-tl/retdec"
SRC_URI="https://github.com/avast-tl/retdec/archive/v${PV}.tar.gz -> ${P}.tar.gz"
#FIXME: install-share.py
#https://github.com/avast-tl/retdec-support/releases/download/2019-03-08/retdec-support_2019-03-08.tar.xz

LICENSE="MIT"
SLOT="0"
#https://github.com/avast/retdec/issues/356
#KEYWORDS="~amd64 ~x86"
IUSE="doc system-libs"

RDEPEND="|| ( app-arch/upx app-arch/upx-bin )
	sys-devel/bc
	sys-devel/bison
	sys-devel/flex
	dev-ruby/pkg-config
	sys-apps/coreutils
	sys-libs/zlib
	sys-libs/ncurses:*[tinfo]
	dev-libs/capstone
	dev-libs/openssl:0

	system-libs? (
		dev-libs/jsoncpp
		sys-devel/llvm:*
		dev-libs/rapidjson
		dev-libs/tinyxml2
	)

	doc? ( media-gfx/graphviz
		app-doc/doxygen )"

DEPEND="${RDEPEND}
	dev-util/cmake"

CMAKE_REMOVE_MODULES_LIST="FindJsoncpp FindRapidjson FindTynyxml2 FindLibdwarf FindOpenssl"

src_prepare(){

#	if use system-libs; then
#		sed '/add_subdirectory(deps)/d' -i ./CMakeLists.txt
	eapply "${FILESDIR}/4.0-system-deps.patch"
	sed '/cond_add_subdirectory(capstone/d' -i ./deps/CMakeLists.txt
	sed '/cond_add_subdirectory(keystone/d' -i ./deps/CMakeLists.txt
	sed '/cond_add_subdirectory(llvm/d' -i ./deps/CMakeLists.txt
	sed '/cond_add_subdirectory(rapidjson/d' -i ./deps/CMakeLists.txt
	sed '/cond_add_subdirectory(tinyxml2/d' -i ./deps/CMakeLists.txt
	sed '/cond_add_subdirectory(yara/d' -i ./deps/CMakeLists.txt
	sed '/cond_add_subdirectory(yaramod/d' -i ./deps/CMakeLists.txt
	sed '/cond_add_subdirectory(openssl/d' -i ./deps/CMakeLists.txt
#	fi

	sed "s|get_install_path(sys.argv)| \"${D}\" + get_install_path(sys.argv)|g" -i ./support/install-share.py
	sed "s|output = os.path.join|output = \"${D}\" + os.path.join|g" -i ./support/install-yara.py

	cmake-utils_src_prepare
	eapply_user
}

#src_configure() {

#-Dbtrfs-snapshot=$(usex btrfs)
#-DRETDEC_DOC=ON
#-DRETDEC_TESTS=ON
#-DCMAKE_BUILD_TYPE=Debug

#	local mycmakeargs=(
#		-DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
#		-DRETDEC_FORCE_OPENSSL_BUILD=0
#	)
#	cmake-utils_src_configure
#}

#src_compile() {
#	cmake -DCMAKE_INSTALL_PREFIX="${EPREFIX}/usr"
#}
