# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit autotools python-single-r1

DESCRIPTION="Library and tools to access the Virtual Hard Disk (VHD) image format"
HOMEPAGE="https://github.com/libyal/libvhdi"

MY_PV="${PV%_alpha}"
SRC_URI="https://github.com/libyal/libvhdi/releases/download/${MY_PV}/libvhdi-alpha-${MY_PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~hppa ~ppc ~x86"
LICENSE="LGPL-3"
SLOT="0"

IUSE="debug +fuse unicode python nls static static-libs"
REQUIRED_USE="static? ( static-libs )"

RDEPEND="${PYTHON_DEPS}
	fuse? ( sys-fs/fuse:0=[static-libs?] )"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}"/${PN}-${MY_PV}

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		$(usex debug "--enable-debug-output --enable-verbose-output") \
		$(use_with fuse libfuse) \
		$(use_enable unicode wide-character-type) \
		$(use_enable static static-executables) \
		$(use_enable static-libs static) \
		$(use_enable nls) \
		$(use_enable python)
}
