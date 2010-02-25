# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

EAPI="2"

DESCRIPTION="A Modular,Parallel,Multiprotocol, Network Login Auditor"
HOMEPAGE="http://www.foofus.net/jmk/medusa/medusa.html"
SRC_URI="http://www.foofus.net/jmk/tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug ncp postgres +ssh2 subversion +untested-modules"

RDEPEND="ssh2? ( net-libs/libssh2 )
	ncp? ( net-fs/ncpfs )
	postgres? ( dev-db/libpq )
	subversion? ( dev-util/subversion )"
DEPEND="${RDEPEND}
	dev-libs/openssl
	sys-devel/autoconf
	sys-devel/automake"

src_prepare() {
	epatch "${FILESDIR}"/$PN-as-needed.patch
}

src_configure() {
	local myconf
	econf \
		--with-default-mod-path="/usr/lib/medusa/modules" \
		`use_enable debug` \
		`use_enable ssh2 module-ssh` \
		`use_with ncp module-ncp` \
		`use_with postgres module-postgres` \
		`use_with subversion module-svn` \
		|| die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed!"

	dodoc README TODO ChangeLog
	dohtml doc/*.html
}
