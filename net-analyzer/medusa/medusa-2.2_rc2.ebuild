# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A Modular,Parallel,Multiprotocol, Network Login Auditor"
HOMEPAGE="http://www.foofus.net/jmk/medusa/medusa.html"
SRC_URI="https://github.com/jmk-foofus/medusa/releases/download/${PVR}/${PF}.tar.gz -> ${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="afp debug ncp postgres rdp +ssh2 subversion"

RDEPEND="ssh2? ( net-libs/libssh2 )
	ncp? ( net-fs/ncpfs )
	postgres? ( dev-db/postgresql:= )
	rdp? ( net-misc/freerdp )
	subversion? ( dev-vcs/subversion )
	dev-libs/openssl:=
	afp? ( net-fs/afpfs-ng )"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake"

src_configure() {
	econf \
		--with-default-mod-path="/usr/lib/medusa/modules" \
		`use_enable afp module-afp` \
		`use_enable debug` \
		`use_enable ncp module-ncp` \
		`use_enable postgres module-postgres` \
		`use_enable rdp module-rdp` \
		`use_enable ssh2 module-ssh` \
		`use_enable subversion module-svn` \
		|| die "econf failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed!"
	dodoc README TODO ChangeLog
	dohtml doc/*.html
}
