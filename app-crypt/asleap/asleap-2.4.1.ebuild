# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="OscarAkaElvis/asleap"

inherit github-archive

DESCRIPTION="Cisco LEAP and Generic MS-CHAPv2 Dictionary Attack"
HOMEPAGE="https://github.com/joswr1ght/asleap https://github.com/OscarAkaElvis/asleap"

KEYWORDS="amd64 x86"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="net-libs/libpcap
	dev-libs/openssl:="
DEPEND="${RDEPEND}"

src_prepare() {
	eapply "${FILESDIR}/asleap-2.4.1-cflags-ldflags.patch"
	eapply "${FILESDIR}/asleap-2.4.1-unchecked-io.patch"
	eapply "${FILESDIR}/asleap-2.4.1-openssl-md4.patch"
	default
}

src_install() {
	dobin asleap genkeys
	dodoc THANKS.md README.md
}
