# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-/_}"
CMAKE_BUILD_TYPE=Release
inherit cmake

DESCRIPTION="A kwallet like functionality for lxqt"
HOMEPAGE="https://github.com/lxqt/lxqt_wallet"
SRC_URI="https://github.com/lxqt/lxqt_wallet/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64"
IUSE="+keyring kwallet test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-qt/qtbase:6[dbus,gui,network,widgets]
	dev-libs/libgcrypt:0=
	keyring? ( app-crypt/libsecret )
	kwallet? ( kde-frameworks/kwallet )
"
#PATCHES=("${FILESDIR}/kwallet6.patch")

src_configure() {
	local mycmakeargs=(
		-DNOSECRETSUPPORT=$(usex keyring false true)
		-DNOKDESUPPORT=$(usex kwallet false true)
#		-DCMAKE_BUILD_TYPE=$(usex debug Debug Release)
	)
#	DCMAKE_BUILD_TYPE=$(usex debug RelWithDebInfo Release) cmake_src_configure
	 cmake_src_configure
}

pkg_postinst() {
	if use kwallet && has_version 'kde-frameworks/kwallet:6'; then
		ewarn "This software does not support kwallet6 yet"
	fi
}
