# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils versionator

DESCRIPTION="A remote security scanner for Linux (GSA)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/857/greenbone-security-assistant-${PV}.tar.gz"
SLOT="4"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="+administrator doc"

RDEPEND=">=dev-libs/glib-2.14
	dev-libs/libxml2
	dev-libs/libxslt
	net-libs/gnutls
	net-analyzer/openvas-libraries:4
	>=net-libs/libmicrohttpd-0.4.2"
DEPEND="${RDEPEND}
	net-analyzer/openvas-manager:4
	administrator? ( net-analyzer/openvas-administrator:4 )
	doc? ( app-doc/doxygen )"

#MY_S=greenbone-security-assistant-"$(replace_version_separator 2 '+')"
S="$WORKDIR/greenbone-security-assistant-${PV}"

CMAKE_BUILD_DIR="${S}"

src_configure() {
	mycmakeargs=(-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc)
	cmake-utils_src_configure || die
}

src_compile() {
	mycmakeargs=(-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc)
	cmake-utils_src_compile || die
	if use doc ; then
			emake doc || die
	fi
}

src_install() {
	cmake-utils_src_install || die
	if use doc ; then
		dodoc "${S}"/doc/generated/html/* || die
		dodoc "${S}"/doc/generated/latex/* || die
	fi
	doinitd "${FILESDIR}/openvas-gsa" || die
}
