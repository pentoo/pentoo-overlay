# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit rpm

DESCRIPTION="A cross-platform automation and configuration tool/framework"
HOMEPAGE="https://github.com/Powershell/Powershell"
#SRC_URI="https://github.com/PowerShell/PowerShell/releases/download/v${PV}/powershell-${PV}-linux-x64.tar.gz"
#https://github.com/PowerShell/PowerShell/releases/download/v6.1.1/powershell_6.1.1-1.ubuntu.16.04_amd64.deb
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
	dev-libs/openssl-chacha"

S="${WORKDIR}"

src_install() {
	# Using doins -r would strip executable bits from all binaries
	cp -pPR "${S}"/{opt,usr/bin} "${D}"/ || die "Failed to copy files"
}
