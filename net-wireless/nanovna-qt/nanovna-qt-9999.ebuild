# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="software for NanoVNA V2"
HOMEPAGE="https://github.com/nanovna/NanoVNA-QT"

inherit qmake-utils autotools multilib

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nanovna/NanoVNA-QT.git"
else
	TAG="20200507"
	SRC_URI="https://github.com/nanovna/NanoVNA-QT/archive/${TAG}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/NanoVNA-QT-${TAG}"
	KEYWORDS="amd64 ~arm arm64 x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtcore:5
	dev-qt/qtcharts:5
	dev-qt/qtsvg:5
	media-libs/libglvnd
	sci-libs/fftw:3.0
	virtual/opengl
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	eautoreconf
	sed -i "s#/usr/lib#/usr/$(get_libdir)#" libxavna/xavna_mock_ui/xavna_mock_ui.pro || die
	default
}

src_configure() {
	econf
	pushd libxavna/xavna_mock_ui > /dev/null
	qmake
	sed -i "s#-O2 -Wall#${CXXFLAGS}#" Makefile || die
	sed -i "s#-shared#-shared ${LDFLAGS}#" Makefile || die
	sed -i '/-$(STRIP) --strip-unneeded/d' Makefile || die
	popd > /dev/null
	pushd vna_qt > /dev/null
	qmake
	sed -i "s#-O2 -Wall#${CXXFLAGS}#" Makefile || die
	sed -i "s#-Wl,-O1#-Wl,-O1 ${LDFLAGS}#" Makefile || die
	popd > /dev/null
}

src_compile() {
	emake
	pushd libxavna/xavna_mock_ui > /dev/null
	emake
	popd > /dev/null
	pushd vna_qt > /dev/null
	emake
	popd > /dev/null
}

src_install() {
	DESTDIR="${ED}" emake install
	pushd libxavna/xavna_mock_ui > /dev/null
	INSTALL_ROOT="${ED}" emake install
	popd > /dev/null
	pushd vna_qt > /dev/null
	dobin vna_qt
	#DESTDIR="${ED}" emake install
	popd > /dev/null
}
