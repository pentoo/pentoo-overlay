# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Modular,Parallel,Multiprotocol, Network Login Auditor"
HOMEPAGE="http://www.foofus.net/jmk/medusa/medusa.html"
COMMIT_HASH="8edc73ad77985e85ae2a40711ab7468f280d7936"
SRC_URI="https://github.com/jmk-foofus/medusa/archive/${COMMIT_HASH}.zip -> ${P}.zip"

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

S="${WORKDIR}/${PN}-${COMMIT_HASH}"

src_configure() {
	econf \
		--with-default-mod-path="/usr/lib/medusa/modules" \
		`use_enable afp module-afp` \
		`use_enable debug` \
		`use_enable ncp module-ncp` \
		`use_enable postgres module-postgres` \
		`use_enable rdp module-rdp` \
		`use_enable ssh2 module-ssh` \
		`use_enable subversion module-svn`
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README.md TODO ChangeLog
#	dohtml doc/*.html
}
