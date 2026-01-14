# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CMAKE_BUILD_TYPE=RELEASE
CMAKE_MAKEFILE_GENERATOR=emake
CMAKE_IN_SOURCE_BUILD=1
inherit cmake
#inherit autotools

DESCRIPTION="A Qt/C++ GUI front end to some encrypted filesystems and sshfs"
HOMEPAGE="
	https://mhogomchungu.github.io/sirikali/
	https://github.com/mhogomchungu/sirikali
"
SRC_URI="https://github.com/mhogomchungu/sirikali/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2+"
SLOT="0"

#FAILS: https://github.com/mhogomchungu/sirikali/issues/300
#KEYWORDS="amd64"

IUSE="debug +pwquality test"
RESTRICT="!test? ( test )"

DEPEND="
	dev-qt/qtbase:6[dbus,gui,network,widgets]
	dev-libs/libgcrypt:0=
	pwquality? ( dev-libs/libpwquality )
	app-crypt/lxqt-wallet
"

src_prepare() {

	#NONETWORKSUPPORT is broken, see https://github.com/mhogomchungu/sirikali/issues/299
	#sed -i '/HAS_NETWORK_SUPPORT/d' CMakeLists.txt || die "unable to sed"

	# do not install compressed MAN files
	sed -i 's/\.1\.gz/\.1/g' CMakeLists.txt
	cd src
	unpack ./sirikali.1.gz ./sirikali.pkexec.1.gz
	cd ..

	cmake_src_prepare
	eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_WITH_QT6=true
		-DINTERNAL_LXQT_WALLET=false
	)
	DCMAKE_BUILD_TYPE=$(usex debug RelWithDebInfo Release) cmake_src_configure
}

pkg_postinst() {
	if has_version 'kde-frameworks/kwallet:6'; then
		ewarn "This software does not support kwallet6 yet"
	fi
}
