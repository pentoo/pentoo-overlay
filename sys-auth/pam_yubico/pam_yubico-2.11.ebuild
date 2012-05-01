# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit eutils autotools

DESCRIPTION="Library for authenticating against PAM with a Yubikey"
HOMEPAGE="https://code.google.com/p/yubico-pam/"
SRC_URI="http://yubico-pam.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="ldap cr"

DEPEND="virtual/pam
	    >=sys-auth/ykclient-2.4
		>=sys-auth/ykpers-1.6"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PV}-drop_privs.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_with cr) \
		$(use_with ldap) \
		--with-pam-dir=/$(get_libdir)/security || die "econf failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README doc/* || die
	find "${D}" -name '*.la' -delete || die
}

