# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2:2.6"
inherit versionator python

DESCRIPTION=""
HOMEPAGE="http://code.ettus.com/redmine/ettus/projects/uhd/wiki"

SRC_URI="https://github.com/EttusResearch/UHD-Mirror/tarball/release_00$(get_version_component_range 1)_00$(get_version_component_range 2)_00$(get_version_component_range 3) -> EttusResearch-UHD-Mirror-$(get_version_component_range 1).$(get_version_component_range 2).$(get_version_component_range 3).tar.gz \
	http://files.ettus.com/binaries/maint_images/archive/uhd-images_00$(get_version_component_range 1).00$(get_version_component_range 2).002-12-geb083300.tar.gz"
#https://github.com/EttusResearch/UHD-Mirror/tags
#http://files.ettus.com/binaries/master_images/archive
KEYWORDS="~amd64 ~x86"
S="${WORKDIR}"/EttusResearch-UHD-Mirror-6047010

LICENSE="GPL-3"
SLOT="0"
IUSE=""
DEPEND="dev-util/cmake
	dev-libs/libusb:1
	dev-libs/boost
	dev-python/cheetah"
RDEPEND="dev-libs/libusb:1
	dev-libs/boost"

src_configure() {
	cd "${S}"/host
	mkdir build
	cd build
	use amd64 && cmake ../  -DCMAKE_INSTALL_PREFIX=/usr -DLIB_SUFFIX=64
	use x86 && cmake ../  -DCMAKE_INSTALL_PREFIX=/usr
	sed -i "s#SET(CMAKE_INSTALL_PREFIX \"/usr\")#SET(CMAKE_INSTALL_PREFIX \"${ED}/usr\")#" cmake_install.cmake
}

src_compile() {
	cd "${S}"/host/build
	emake
}

src_install() {
	cd "${S}"/host/build
	emake install
	mv "${WORKDIR}"/uhd-images_00$(get_version_component_range 1).00$(get_version_component_range 2).00$(get_version_component_range 3)-release/share/uhd/images "${ED}"/usr/share/uhd/
}

src_test() {
	cd "${S}"/host/build
	emake test
}

pkg_postinst() {
	cp /usr/share/uhd/utils/uhd-usrp.rules /lib/udev/rules.d/99-uhd-usrp.rules
}
