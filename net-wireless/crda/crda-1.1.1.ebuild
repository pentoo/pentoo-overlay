# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs multilib

DESCRIPTION="Central Regulatory Domain Agent for wireless networks."
HOMEPAGE="http://wireless.kernel.org/en/developers/Regulatory"
SRC_URI="http://wireless.kernel.org/download/crda/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"

KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""
DEPEND="dev-libs/openssl
	dev-libs/libgcrypt
	dev-libs/libnl
	dev-python/m2crypto"
RDEPEND="dev-libs/libnl
	dev-libs/openssl
	net-wireless/wireless-regdb"

src_compile() {
	emake UDEV_RULE_DIR=/etc/udev/rules.d/ USE_OPENSSL=1 RUNTIME_PUBKEY_DIR=/usr/$(get_libdir)/crda/ CC="$(tc-getCC)" || die "Compilation failed"
}

src_install() {
	emake UDEV_RULE_DIR=/etc/udev/rules.d/ USE_OPENSSL=1 RUNTIME_PUBKEY_DIR=/usr/$(get_libdir)/crda/ DESTDIR="${D}" install || die "emake install failed"
}
