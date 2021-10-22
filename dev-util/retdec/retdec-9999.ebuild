# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="RetDec is a retargetable machine-code decompiler based on LLVM."
HOMEPAGE="https://github.com/avast-tl/retdec"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/avast/retdec.git"
else
	#https://github.com/avast/retdec/issues/356
	#KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/avast-tl/retdec/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi
#FIXME: install-share.py
#https://github.com/avast-tl/retdec-support/releases/download/2019-03-08/retdec-support_2019-03-08.tar.xz

LICENSE="MIT"
SLOT="0"
IUSE="doc"

MY_RDEPEND="|| ( app-arch/upx app-arch/upx-bin )
	sys-devel/bc
	dev-ruby/pkg-config
	sys-apps/coreutils
	sys-libs/zlib
	sys-libs/ncurses:*[tinfo]
	dev-libs/capstone
	dev-libs/openssl:0
	dev-libs/jsoncpp
	sys-devel/llvm:*
	dev-libs/rapidjson
	dev-libs/tinyxml2
	"

RDEPEND=${MY_RDEPEND}

DEPEND="${RDEPEND}
	dev-util/cmake
	sys-devel/bison
	sys-devel/flex

	doc? ( media-gfx/graphviz
		app-doc/doxygen )"

CMAKE_REMOVE_MODULES_LIST="FindJsoncpp FindRapidjson FindTynyxml2 FindLibdwarf FindOpenssl"

src_prepare(){

	eapply "${FILESDIR}/9999-system-deps.patch"
	sed '/cond_add_subdirectory(capstone/d' -i ./deps/CMakeLists.txt || die
	sed '/cond_add_subdirectory(keystone/d' -i ./deps/CMakeLists.txt || die
	sed '/cond_add_subdirectory(llvm/d' -i ./deps/CMakeLists.txt || die
	sed '/cond_add_subdirectory(rapidjson/d' -i ./deps/CMakeLists.txt || die
	sed '/cond_add_subdirectory(tinyxml2/d' -i ./deps/CMakeLists.txt || die
	sed '/cond_add_subdirectory(yara/d' -i ./deps/CMakeLists.txt || die
	sed '/cond_add_subdirectory(yaramod/d' -i ./deps/CMakeLists.txt || die
	sed '/cond_add_subdirectory(openssl/d' -i ./deps/CMakeLists.txt || die

	sed -i 's/retdec::deps::llvm/llvm/g' $(grep -r --color=never 'retdec::deps::llvm' | awk -F':' '{print $1}') || die
	sed -i 's/retdec::deps::rapidjson/rapidjson/g' $(grep -r --color=never 'retdec::deps::rapidjson' | awk -F':' '{print $1}') || die
	sed -i 's/retdec::deps::capstone/capstone/g' $(grep -r --color=never 'retdec::deps::capstone' | awk -F':' '{print $1}') || die
	sed -i 's/retdec::deps::libyara/yara/g' $(grep -r --color=never 'retdec::deps::libyara' | awk -F':' '{print $1}') || die
	sed -i 's/retdec::deps::tinyxml2/tinyxml2/g' $(grep -r --color=never 'retdec::deps::tinyxml2' | awk -F':' '{print $1}') || die
	sed -i 's/retdec::deps::yaramod/yaramod/g' $(grep -r --color=never 'retdec::deps::yaramod' | awk -F':' '{print $1}') || die
	#sed -i 's/retdec::deps::openssl-crypto/libcrypto/g' $(grep -r --color=never 'retdec::deps::openssl-crypto' | awk -F':' '{print $1}') || die

	sed "s|get_install_path(sys.argv)| \"${D}\" + get_install_path(sys.argv)|g" -i ./support/install-share.py || die
	sed "s|output = os.path.join|output = \"${D}\" + os.path.join|g" -i ./support/install-yara.py || die

	cmake_src_prepare
}

