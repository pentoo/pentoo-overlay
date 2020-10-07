# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake multilib

DESCRIPTION="A software oscilloscope and signal analysis toolset"
HOMEPAGE="https://github.com/analogdevicesinc/scopy"

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/analogdevicesinc/scopy.git"
else
	SRC_URI="https://github.com/analogdevicesinc/scopy/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="net-wireless/gr-iio
		net-wireless/gr-scopy
		net-wireless/gr-m2k
		sci-libs/libsigrokdecode
		=x11-libs/qwt-multiaxes-9999
		x11-libs/qwtpolar
		dev-qt/qtdeclarative:5
		dev-libs/boost:=
		dev-qt/qtxml:5
		dev-libs/glib
		dev-cpp/glibmm
		net-wireless/libm2k
		dev-qt/qtwidgets:5
		dev-qt/qtgui:5
		dev-qt/qtcore:5
		net-wireless/gnuradio:=
		sci-libs/volk:=
		net-libs/libiio
		"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	mycmakeargs=(
		-DCMAKE_PREFIX_PATH="/usr/$(get_libdir)/cmake"
		-DWITH_DOC=OFF
	)
	#sed -i "s#find_package(Qwt REQUIRED)#set(QWT_INCLUDE_DIRS /usr/include/qwt6-multiaxes)\nset(QWT_LIBRARIES /usr/lib64/libqwt6-qt5-multiaxes.so.9999.0.0)#" CMakeLists.txt || die
	sed -i "s#find_package(Qwt REQUIRED)#set(QWT_INCLUDE_DIRS /usr/include/qwt6-multiaxes)\nset(QWT_LIBRARIES -lqwt6-qt5-multiaxes -lQt5Concurrent -lQt5PrintSupport -lQt5Svg -lQt5OpenGL -lQt5Widgets -lQt5Gui -lQt5Core)#" CMakeLists.txt || die
	sed -i 's# -Wall##' CMakeLists.txt || die
	sed -i '/-Werror=uninitialized/d' CMakeLists.txt || die
	#this installs docs in the right place, but it almost exclusively installs crap instead of docs
	sed -i "s#set(CMAKE_INSTALL_DOCDIR \"\${CMAKE_CURRENT_BINARY_DIR}/doc\")#set(CMAKE_INSTALL_DOCDIR \"/usr/share/doc/${PF}\")#" CMakeLists.txt || die
	cmake_src_configure
}
