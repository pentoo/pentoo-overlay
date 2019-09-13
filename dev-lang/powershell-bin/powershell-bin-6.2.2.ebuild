# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit rpm

DESCRIPTION="A cross-platform automation and configuration tool/framework"
HOMEPAGE="https://github.com/Powershell/Powershell"
SRC_URI="
	amd64? ( https://github.com/PowerShell/PowerShell/releases/download/v${PV}/powershell-${PV}-1.rhel.7.x86_64.rpm )
"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-libs/icu
	sys-libs/libunwind
	|| ( =dev-libs/openssl-1.0* dev-libs/openssl-compat:1.0.0 )"

QA_PREBUILT="/opt/microsoft/*"

S="${WORKDIR}"

src_prepare() {
	#fix symlinks
	rm opt/microsoft/powershell/6/{libcrypto.so.1.0.0,libssl.so.1.0.0}
	default
}

src_install() {
	# Using doins -r would strip executable bits from all binaries
	cp -pPR "${S}"/{opt,usr/bin} "${D}"/ || die "Failed to copy files"
	dosym "${EPREFIX}/usr/$(get_libdir)/libcrypto.so.1.0.0" /opt/microsoft/powershell/6/libcrypto.so.1.0.0
	dosym "${EPREFIX}/usr/$(get_libdir)/libssl.so.1.0.0" /opt/microsoft/powershell/6/libssl.so.1.0.0
}
