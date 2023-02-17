# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

DESCRIPTION=""
HOMEPAGE=""
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
EGIT_REPO_URI="https://github.com/mikeryan/ice9-bluetooth-sniffer.git"

DEPEND="
	net-libs/libhackrf:=
	net-libs/liquid-dsp
	net-wireless/bladerf:=
	net-wireless/uhd:=
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	sed -i "s#\$ENV{HOME}/.config#/usr/$(get_libdir)#" CMakeLists.txt || die
	cmake_src_prepare
}
