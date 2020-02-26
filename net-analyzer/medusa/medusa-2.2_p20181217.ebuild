# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MODULES=( afp ncp postgres +rdp +ssh subversion )

inherit autotools multilib

DESCRIPTION="A modular, parallel, multiprotocol, network login auditor"
HOMEPAGE="http://foofus.net/goons/jmk/medusa/medusa.html"

COMMIT_HASH="292193b3995444aede53ff873899640b08129fc7" # 20181217
SRC_URI="https://github.com/jmk-foofus/medusa/archive/${COMMIT_HASH}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="${MODULES[@]} debug libressl"
DOCS=( AUTHORS NEWS README.md TODO ChangeLog sample )

RDEPEND="
	ssh? ( net-libs/libssh2 )
	ncp? ( net-fs/ncpfs )
	postgres? ( dev-db/postgresql:= )
	rdp? ( net-misc/freerdp )
	subversion? ( dev-vcs/subversion )
	!libressl? ( dev-libs/openssl:= )
	libressl? ( dev-libs/libressl:= )
	afp? ( net-fs/afpfs-ng )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${COMMIT_HASH}"

src_prepare() {
	sed -e "s:\$_dir/libssh2.so:/usr/$(get_libdir)/libssh2.so:" \
		-e "s/module-svn/module-subversion/" \
		-i configure.ac || die 'sed failed!'

	eautoreconf
	default
}

src_configure() {
	local econfargs

	for x in ${MODULES[@]}; do
		econfargs+=( $(use_enable ${x/[[:punct:]]} module-${x/[[:punct:]]}) )
	done

	econf \
		--with-default-mod-path="/usr/$(get_libdir)/medusa/modules" \
		$(use_enable debug) \
		${econfargs[@]}
}
