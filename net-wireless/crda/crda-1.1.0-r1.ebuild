# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs multilib

DESCRIPTION="Central Regulatory Domain Agent for wireless networks."
HOMEPAGE="http://wireless.kernel.org/en/developers/Regulatory"
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/crda.git/snapshot/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"

DESIRED_REGDB="20090817"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""
DEPEND="dev-libs/libgcrypt
	dev-libs/libnl:1.1
	dev-python/m2crypto
	=net-wireless/wireless-regdb-${DESIRED_REGDB}"
RDEPEND="dev-libs/libnl
	=net-wireless/wireless-regdb-${DESIRED_REGDB}"
# I am "pretty sure" about the rdepends

src_unpack() {
	unpack ${A}

	##Make sure we install the rules where udev rules go...
	sed -i -e "/^UDEV_RULE_DIR/s:lib:$(get_libdir):" "${S}"/Makefile || die \
	"Makefile sed failed"
	cp /usr/lib/crda/custom-distro.key.pub.pem ${S}/pubkeys/ || die "please 'emerge -1 =wireless-regdb-${DESIRED_REGDB}', sorry"
}

src_compile() {
	emake CC="$(tc-getCC)" || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
