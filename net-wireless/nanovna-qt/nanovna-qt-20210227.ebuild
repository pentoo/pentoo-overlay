# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Software for NanoVNA V2"
HOMEPAGE="https://github.com/nanovna/NanoVNA-QT"

inherit qmake-utils autotools multilib

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/nanovna/NanoVNA-QT.git"
else
	HASH_COMMIT="90b5ad247198acf4f5caf76b794a54ad347cd09a"
	SRC_URI="https://github.com/nanovna/NanoVNA-QT/archive/${HASH_COMMIT}.zip -> ${P}.zip"
	S="${WORKDIR}/NanoVNA-QT-${HASH_COMMIT}"
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
