# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils flag-o-matic systemd

MY_PN=openvasmd

DESCRIPTION="A remote security scanner for Linux (openvas-manager)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="https://github.com/greenbone/gvm/releases/download/v${PV}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

RDEPEND="
	>=net-analyzer/openvas-libraries-9.0.2
	>=dev-db/sqlite-3
	dev-db/redis
	!net-analyzer/openvas-administrator"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/gvm-${PV}"

PATCHES=( "${FILESDIR}"/${PN}-6.0.1-bsdsource.patch )

src_prepare() {
	sed \
		-e '/^install.*OPENVAS_CACHE_DIR.*/d' \
		-i CMakeLists.txt || die
	sed \
		-e "s/\\(doc\/openvas-manager\\)/\\1-${PV}/" \
		-i CMakeLists.txt -i doc/CMakeLists.txt || die
	cmake-utils_src_prepare
}

src_configure() {
	append-cppflags -U_FORTIFY_SOURCE
	local mycmakeargs=(
		-DLOCALSTATEDIR="${EPREFIX}/var"
		-DSYSCONFDIR="${EPREFIX}/etc"
		-DOPENVAS_RUN_DIR="/run"
		)
	cmake-utils_src_configure
}

src_install() {
	keepdir /var/lib/openvas/openvasmd
	cmake-utils_src_install

	insinto /etc/openvas/
	doins "${FILESDIR}"/${MY_PN}-daemon.conf
	dosym ../openvas/${MY_PN}-daemon.conf /etc/conf.d/${MY_PN}

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${MY_PN}.logrotate ${MY_PN}

	newinitd "${FILESDIR}"/${MY_PN}.init ${MY_PN}
	systemd_dounit "${FILESDIR}"/${MY_PN}.service
}
