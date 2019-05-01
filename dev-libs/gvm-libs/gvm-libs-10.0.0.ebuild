# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Greenbone Vulnerability Management Libraries"
HOMEPAGE="https://github.com/greenbone/gvm-libs"
SRC_URI="https://github.com/greenbone/gvm-libs/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="ldap"

RDEPEND="
	app-crypt/gpgme
	dev-libs/glib:2
	dev-libs/hiredis
	dev-libs/libgpg-error
	dev-libs/libgcrypt
	ldap? ( net-nds/openldap )
	net-libs/gnutls
	net-libs/libssh
	sys-libs/zlib"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DGVM_PID_DIR="${EPREFIX}/run"
		-DLOCALSTATEDIR="${EPREFIX}/var"
	)

	cmake-utils_src_configure
}
