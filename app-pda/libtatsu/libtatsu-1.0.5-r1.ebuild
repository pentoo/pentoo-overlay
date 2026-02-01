# Copyright 2025-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Library handling the communication with Apple's Tatsu Signing Server (TSS) "
HOMEPAGE="https://libimobiledevice.org/"
SRC_URI="https://github.com/libimobiledevice/${PN}/releases/download/${PV}/${P}.tar.bz2 -> ${P}.gh.tar.bz2"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~hppa ~loong ppc ~ppc64 ~riscv ~s390 x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="virtual/pkgconfig"
DEPEND="app-pda/libplist:=
	net-misc/curl"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		--disable-static \
		$(usex kernel_linux '' --without-inotify)
}

src_install() {
	default
	find "${D}" -name '*.la' -type f -delete || die
}
