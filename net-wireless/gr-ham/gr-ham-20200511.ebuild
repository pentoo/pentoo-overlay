# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
inherit cmake cmake-utils python-single-r1

DESCRIPTION=""
HOMEPAGE="https://github.com/argilo/gr-ham"
HASH_COMMIT="7ece28e0e66365522b0dfb63c63717725189d5bf"
SRC_URI="https://github.com/argilo/gr-ham/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE="+doc"

DEPEND=">=net-wireless/gnuradio-3.8.0:="
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_prepare() {
	#fixme below
	sed -i "s|\${GR_DOC_DIR}\/\${CMAKE_PROJECT_NAME}|${EPREFIX}/usr/share/doc/${PF}|g" CMakeLists.txt
	cmake-utils_src_prepare
}

src_configure() {
#	export GR_DOC_DIR="/usr/my/test"
	mycmakeargs=(
		-DENABLE_DOXYGEN="$(usex doc)"
#		-DGR_DOC_DIR="${EPREFIX}/usr/share/doc2/${PF}"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake_src_install
	python_optimize "${ED}/$(python_get_sitedir)"
}
