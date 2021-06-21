# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs multilib

DESCRIPTION="Central Regulatory Domain Agent for wireless networks"
HOMEPAGE="https://wireless.wiki.kernel.org/en/developers/regulatory/crda"
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/crda.git/snapshot/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"

KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""
DEPEND="dev-libs/openssl
	dev-libs/libgcrypt
	dev-libs/libnl:1.1
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
