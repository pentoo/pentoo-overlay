# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils versionator

AVC=( $(get_version_components) )
MY_PV="R${AVC[0]}_${AVC[1]}${AVC[2]}"

DESCRIPTION="Free diagnostic software for OBD-II compliant motor vehicles"
HOMEPAGE="https://github.com/fenugrec/freediag"
SRC_URI="https://github.com/fenugrec/freediag/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

DOCS=( AUTHORS CHANGES COPYING README doc )

src_prepare() {
	sed -i -e 's:DESTINATION doc:DESTINATION share/doc/'${P}':g' CMakeLists.txt || die
	sed -i -e 's:DESTINATION . OPTIONAL:DESTINATION share/doc/'${P}' OPTIONAL:g' CMakeLists.txt || die
}

src_configure() {
	CMAKE_BUILD_TYPE=Release
	use debug && CMAKE_BUILD_TYPE=Debug

	local mycmakeargs=(
		-DDBUILDGUI=ON
		-DUSE_RCFILE=ON -DUSE_INIFILE=ON
	)
	cmake-utils_src_configure
}

#copied from arch, where the official mess was introduced
src_install() {
	cmake-utils_src_install
#  emake DESTDIR="${D}" install
#hax cleanup. CMakeLists.txt should really be fixed upstream for the next release
	mkdir -p "${D}"/usr/share/freediag/carsim_examples
	mv "${D}"/usr/bin/*.db "${D}"/usr/share/freediag/carsim_examples
	mv "${D}"/usr/bin/scantool.ini "${D}"/usr/share/freediag/
}
