# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
inherit cmake python-single-r1

DESCRIPTION="collection of GNU Radio blocks useful for amateur radio"
HOMEPAGE="https://github.com/argilo/gr-ham"
#EGIT_BRANCH="maint-3.10"
HASH_COMMIT="005f72b9e492e514b775992eb96460b44f1f9eae"
SRC_URI="https://github.com/argilo/gr-ham/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+doc"

DEPEND="net-wireless/gnuradio:="
RDEPEND="${DEPEND}
	${PYTHON_DEPS}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	#fixme below
	sed -i "s|\${GR_DOC_DIR}\/\${CMAKE_PROJECT_NAME}|${EPREFIX}/usr/share/doc/${PF}|g" CMakeLists.txt
	cmake_src_prepare
}

src_configure() {
#	export GR_DOC_DIR="/usr/my/test"
	mycmakeargs=(
		-DENABLE_DOXYGEN="$(usex doc)"
#		-DGR_DOC_DIR="${EPREFIX}/usr/share/doc2/${PF}"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	find "${ED}" -name "*.py[co]" -delete || die
	python_optimize
}
