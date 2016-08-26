# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4,5} )

inherit cmake-utils git-r3 python-r1

DESCRIPTION="vendor and platform neutral SDR support library"
HOMEPAGE="https://github.com/pothosware/SoapyHackRF"
EGIT_REPO_URI="https://github.com/pothosware/SoapyHackRF.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

IUSE="python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="python? ( ${PYTHON_DEPS} )
		net-wireless/soapysdr
		net-libs/libhackrf"
DEPEND="${RDEPEND}
		python? ( dev-lang/swig:0 )
"

src_prepare() {
	use python && python_copy_sources
}

src_configure() {
	configuration() {
		local mycmakeargs=(
			-DPYTHON_BASENAME="-${EPYTHON}"
			-DPYTHON_SUFFIX="-${EPYTHON}"
			$(cmake-utils_use_enable python PYTHON)
		)
		#if python_is_python3; then
			#mycmakeargs+=( -DBUILD_PYTHON3=ON )
		#else
			#mycmakeargs+=( -DBUILD_PYTHON3=OFF )
		#fi

		CMAKE_USE_DIR="${BUILD_DIR}" cmake-utils_src_configure
	}
	use python && python_foreach_impl configuration || configuration
}

src_compile() {
	compilation() {
		CMAKE_USE_DIR="${BUILD_DIR}" cmake-utils_src_make
	}
	use python && python_foreach_impl compilation || compilation
}

src_install() {
	installation() {
		CMAKE_USE_DIR="${BUILD_DIR}" cmake-utils_src_install DESTDIR="${D}"
		use python && python_optimize
	}
	use python && python_foreach_impl installation || installation
}
