# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Cisco LEAP and Generic MS-CHAPv2 Dictionary Attack"
HOMEPAGE="https://github.com/joswr1ght/asleap"

HASH_COMMIT="f8229d2fd800b36b34699a19f50a35981b1dcb49" # 20160730
SRC_URI="https://github.com/joswr1ght/asleap/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/openssl
	net-libs/libpcap
	sys-libs/libxcrypt"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_prepare() {
	eapply "${FILESDIR}"

	sed -e "s/-pipe//;s/-Wall//;s/-g3 -ggdb -g/${CFLAGS}/" \
		-i Makefile || die

	sed -e "s/#define VER \"2.2\"/#define VER \"${PV}\"/" \
		-i version.h || die

	default
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	dosbin asleap
	newbin genkeys asleap-genkeys
	dodoc THANKS README
}
