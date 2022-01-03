# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
inherit cmake cmake-utils python-single-r1

DESCRIPTION="Set of tools for receiving information transmitted by GSM equipment/devices"
HOMEPAGE="https://github.com/ptrkrysik/gr-gsm"
#EGIT_REPO_URI="https://github.com/ptrkrysik/gr-gsm.git"
#EGIT_BRANCH="porting_to_gr38"
HASH_COMMIT="2de47e28ce1fb9a518337bfc0add36c8e3cff5eb"
SRC_URI="https://github.com/ptrkrysik/gr-gsm/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="doc"

#if(NOT LIBOSMOCORE_FOUND OR NOT LIBOSMOCODEC_FOUND OR NOT LIBOSMOGSM_FOUND)
#    set(LOCAL_OSMOCOM ON)
DEPEND=">=net-wireless/gnuradio-3.8.0:=
	net-wireless/gr-osmosdr
	dev-util/cppunit
	net-libs/libosmocore"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_prepare() {
	#fixme below
	sed -i "s|\${GR_DOC_DIR}\/\${CMAKE_PROJECT_NAME}|${EPREFIX}/usr/share/doc/${PF}|g" CMakeLists.txt
	cmake-utils_src_prepare
}

src_configure() {
	mycmakeargs=(
		-DENABLE_DOXYGEN="$(usex doc)"
#why it doesn't work?
#		-DGR_PKG_DOC_DIR="$(usex doc ${EPREFIX}/usr/share/doc/${PF})"
		-DPYTHON_EXECUTABLE=${PYTHON}
		-DLOCAL_OSMOCOM=ON
	)
	cmake-utils_src_configure
}

src_install() {
	cmake_src_install
	python_optimize "${ED}/$(python_get_sitedir)"
}
