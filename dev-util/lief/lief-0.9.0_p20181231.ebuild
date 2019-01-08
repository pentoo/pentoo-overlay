# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_5,3_6,3_7} )

inherit cmake-utils python-r1

HASH_COMMIT="8d7ec26a93800b0729c2c05be8c55c8318ba3b20"

DESCRIPTION="Library to instrument executable formats"
HOMEPAGE="https://lief.quarkslab.com/"
SRC_URI="https://github.com/lief-project/LIEF/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
#https://github.com/lief-project/LIEF/issues/251
KEYWORDS="~amd64 ~x86"

IUSE="+python"

RDEPEND="python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	python? ( dev-python/setuptools[${PYTHON_USEDEP}] )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

S=${WORKDIR}/LIEF-${HASH_COMMIT}

src_configure(){
	#cmake/LIEFOptions.cmake
	local FORCE32=NO
	use x86 && FORCE32=YES

	#examples fail to compile
	#https://github.com/lief-project/LIEF/issues/251
	local mycmakeargs=(
		-DLIEF_EXAMPLES=OFF
		-DLIEF_INSTALL_PYTHON="$(usex python)"
		-DLIEF_FORCE32="$FORCE32"
	)
	cmake-utils_src_configure
}
