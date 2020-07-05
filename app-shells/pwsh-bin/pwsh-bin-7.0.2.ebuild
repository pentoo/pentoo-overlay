# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="PowerShell - binary precompiled for glibc"
HOMEPAGE="https://powershell.org/"
LICENSE="MIT"

SRC_URI="
	amd64? ( https://github.com/PowerShell/PowerShell/releases/download/v${PV}/powershell-${PV}-linux-x64.tar.gz )
	arm?   ( https://github.com/PowerShell/PowerShell/releases/download/v${PV}/powershell-${PV}-linux-arm32.tar.gz )
	arm64? ( https://github.com/PowerShell/PowerShell/releases/download/v${PV}/powershell-${PV}-linux-arm64.tar.gz )
"

SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

QA_PREBUILT="*"

DEPEND=""
RDEPEND="${DEPEND}
	>=sys-apps/lsb-release-1.4
	>=sys-libs/libunwind-1.1-r1
	>=dev-libs/icu-57.1
	>=dev-util/lttng-ust-2.8.1
	|| ( dev-libs/openssl-compat:1.0.0 =dev-libs/openssl-1.0*:0 )
	>=net-misc/curl-7.49.0
	>=app-crypt/mit-krb5-1.14.2
	>=sys-libs/zlib-1.2.8-r1"
BDEPEND=""

S=${WORKDIR}

src_prepare() {
	default
	rm libcrypto.so.1.0.0 libssl.so.1.0.0 || die
}

src_install() {
	local dest="opt/pwsh"
	dodir "${dest}"
	local ddest="${D}/${dest}"
	cp -a "${S}"/* "${ddest}/" || die
	fperms 0755 "/${dest}/pwsh"
	dosym "/${dest}/pwsh" "/usr/bin/pwsh"
}
