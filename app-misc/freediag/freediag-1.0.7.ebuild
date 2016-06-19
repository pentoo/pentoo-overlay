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
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

#	sed -i -e 's:DOCDIR:/usr/share/doc/'${PF}'/README.module_options:g' \
#		"${D}etc/modprobe.d/pf_ring.conf" || die

#DOCS=( AUTHORS CHANGES README README{,.dag,.linux,.macosx,.septel} )
#DOCS=( AUTHORS CHANGES README )

src_prepare() {
#	sed -i -e 's:DESTINATION doc:DESTINATION share/doc'${P}':g' CMakeLists.txt || die
	sed -i -e 's:DESTINATION doc:DESTINATION share/doc/'${P}':g' CMakeLists.txt || die
}

src_configure() {
	CMAKE_BUILD_TYPE=Release
	cmake-utils_src_configure
}
