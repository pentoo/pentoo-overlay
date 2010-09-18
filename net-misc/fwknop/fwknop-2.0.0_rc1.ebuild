# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit versionator

MY_PV=$(delete_version_separator 3)
MY_P=${PN}-${MY_PV}
DESCRIPTION="Single Packet Authorization and Port Knocking application"
HOMEPAGE="http://www.cipherdyne.org/fwknop/"
SRC_URI="http://www.cipherdyne.org/${PN}/download/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gpg +client +server"

DEPEND="gpg? ( app-crypt/gpg )"
RDEPEND="${DEPEND}
	net-firewall/iptables"

S=${WORKDIR}/${MY_P}

src_prepare() {
	 sed -i 's|gpgme.h|gpgme/gpgme.h|g' lib/{fko_common.h,fko_error.c} || die
}

src_configure() {
	econf \
		$(use_enable client) \
		$(use_enable server) \
		$(use_with gpg gpgme)
}

src_install() {
	DESTDIR="${D}" emake install || die
}
