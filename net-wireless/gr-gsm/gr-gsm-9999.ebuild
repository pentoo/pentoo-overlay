# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 cmake-utils git-r3 python-utils-r1

DESCRIPTION="Set of tools for receiving information transmitted by GSM equipment/devices"
HOMEPAGE="https://github.com/ptrkrysik/gr-gsm"
EGIT_REPO_URI="https://github.com/ptrkrysik/gr-gsm.git"

KEYWORDS=""
LICENSE="GPL-3"
SLOT="0"
IUSE="doc"

DEPEND=">=net-wireless/gnuradio-3.7.0:=
	net-wireless/gr-osmosdr
	dev-util/cppunit
	net-libs/libosmocore"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i "s|gr-grgsm|gr-gsm|g" CMakeLists.txt
#fixme below
	sed -i "s|\${GR_DOC_DIR}\/\${CMAKE_PROJECT_NAME}|${EPREFIX}/usr/share/doc/${PF}|g" CMakeLists.txt
}

#Fixme: GR_PKG_DOC_DIR is not getting set
#		-DGR_PKG_DOC_DIR="${EPREFIX}/usr/share/doc/${PF}"
src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable doc DOXYGEN) \
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	python_fix_shebang "${ED}"usr/bin
}
