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
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	dev-libs/openssl
	net-libs/libpcap
	sys-libs/libxcrypt"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_prepare() {
	PATCHES=(
		"${FILESDIR}/001_add_simple_password_bruteforcing_option.patch"
		"${FILESDIR}/002_added_the_possibility_to_verify_MSCHAP-V2_authentication.patch"
		"${FILESDIR}/010_replace_libcrypt_with_libxcrypt.patch"
	)
	default

	sed -e "s/-pipe//;s/-Wall//;s/-g3 -ggdb -g/${CFLAGS}/" \
		-i Makefile || die

	sed -e "s/#define VER \"\(.*\)\"/#define VER \"${PV}\"/" \
		-i version.h || die

	sed -e 's#CFLAGS    =#CFLAGS    +=#' -i Makefile || die

}

src_compile() {
	CFLAGS="${CFLAGS}" emake CC=$(tc-getCC)
}

src_install() {
	dosbin asleap
	newbin genkeys asleap-genkeys
	dodoc THANKS README
}
