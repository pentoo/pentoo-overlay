# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils

DESCRIPTION="Create extremely-fast and secure embedded HTTP servers with ease"
HOMEPAGE="https://github.com/criticalstack/libevhtp"
SRC_URI="https://github.com/criticalstack/libevhtp/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+oniguruma"

RDEPEND="oniguruma? ( dev-libs/oniguruma )"
DEPEND="${RDEPEND}"

src_prepare() {
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
		-DEVHTP_DISABLE_MEMFUNCTIONS=ON
#		#https://manual.seafile.com/build_seafile/server.html
#		-DEVHTP_DISABLE_SSL=ON
#		-DEVHTP_BUILD_SHARED=OFF
		#must be OFF for seafile
		$(usex oniguruma -DEVHTP_DISABLE_REGEX=OFF)
	)
	cmake-utils_src_configure
}
