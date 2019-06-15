# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils

HASH_COMMIT=18c649203f009ef1d77d6f8301eba09af3777adf
DESCRIPTION="Create extremely-fast and secure embedded HTTP servers with ease"
HOMEPAGE="https://github.com/criticalstack/libevhtp"
SRC_URI="https://github.com/haiwen/libevhtp/archive/${HASH_COMMIT}.zip -> ${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+oniguruma"

RDEPEND="oniguruma? ( dev-libs/oniguruma )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/libevhtp-${HASH_COMMIT}"

src_prepare() {
#	eapply "${FILESDIR}/010-strcmp-endianness-fix.patch"
#	eapply "${FILESDIR}/020-openssl-1.1-compatibility.patch"
	eapply "${FILESDIR}/pull-1.patch"

	sed -i -e "s|lib/pkgconfig|$(get_libdir)/pkgconfig|" \
		-e "s|lib/cmake|$(get_libdir)/cmake|" \
		-e "s|DESTINATION \"lib|DESTINATION \"$(get_libdir)|" \
		"${S}/CMakeLists.txt"
	cmake-utils_src_prepare
	eapply_user
}

src_configure() {
	local mycmakeargs=(
#		#libevent issue
#		-DEVHTP_DISABLE_MEMFUNCTIONS=ON
#		#https://manual.seafile.com/build_seafile/server.html
		-DEVHTP_DISABLE_SSL=ON
		-DEVHTP_BUILD_SHARED=OFF
		#must be OFF for seafile
#		$(usex oniguruma -DEVHTP_DISABLE_REGEX=OFF)
	)
	cmake-utils_src_configure
}
