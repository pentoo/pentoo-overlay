# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils systemd

DESCRIPTION="A remote security scanner for Linux (OpenVAS-scanner)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="https://github.com/greenbone/openvas-scanner/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="snmp"

RDEPEND="
	app-crypt/gpgme
	dev-libs/glib:2
	dev-libs/libgcrypt:=
	dev-libs/libksba
	net-libs/gnutls
	>=dev-libs/gvm-libs-10.0.0
	net-libs/libpcap
	net-libs/libssh
	>=net-analyzer/openvas-libraries-8.0.2
	!net-analyzer/openvas-plugins
	!net-analyzer/openvas-server
	snmp? ( net-analyzer/net-snmp )"

DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/bison
	virtual/pkgconfig"

PATCHES=(
#	"${FILESDIR}"/${PN}-4.0.3-mkcertclient.patch
	"${FILESDIR}"/${PN}-4.0.3-rulesdir.patch
#	"${FILESDIR}"/${PN}-4.0.3-run.patch
	)

src_prepare() {
	sed -e '/^install.*OPENVAS_CACHE_DIR.*/d' \
		-i CMakeLists.txt || die

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLOCALSTATEDIR="${EPREFIX}/var"
		-DSYSCONFDIR="${EPREFIX}/etc"
	)

	cmake-utils_src_configure
}

src_install() {
	local my_pn="openvassd"

	cmake-utils_src_install

	insinto /etc/openvas
	doins "${FILESDIR}"/${my_pn}.conf "${FILESDIR}"/${my_pn}-daemon.conf
	dosym ../openvas/${my_pn}-daemon.conf /etc/conf.d/${my_pn}

	insinto /etc/logrotate.d
	doins "${FILESDIR}"/${my_pn}.logrotate

	insinto /etc/
	newins "${FILESDIR}"/${my_pn}-redis_40.conf redis_openvas.conf

	dodoc "${FILESDIR}"/openvas-nvt-sync-cron

	newinitd "${FILESDIR}"/${my_pn}.init ${my_pn}
	systemd_newtmpfilesd "${FILESDIR}"/${my_pn}.tmpfiles.d ${my_pn}.conf
	systemd_dounit "${FILESDIR}"/${my_pn}.service
}
