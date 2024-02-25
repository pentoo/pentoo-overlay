# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library with common code used by the libraries and tools around the libimobiledevice project"
HOMEPAGE="https://www.libimobiledevice.org/"
SRC_URI="https://github.com/libimobiledevice/libimobiledevice-glue/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="LGPL-2.1+"
SLOT="0"
#SLOT="0/2.0-6" # based on SONAME of libusbmuxd-2.0.so
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="static-libs"

RDEPEND="
	>=app-pda/libplist-2.3.0:=
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default
	#define version in AC_INIT
	sed -i -e "s|m4_esyscmd(./git-version-gen \$RELEASE_VERSION)|${PV}|g" configure.ac || die
	eautoreconf
	eapply_user
}

src_configure() {
	econf $(use_enable static-libs static)
}
