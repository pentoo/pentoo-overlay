# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MODULES=( postgres +rdp +ssh subversion )

inherit autotools

DESCRIPTION="A modular, parallel, multiprotocol, network login auditor"
HOMEPAGE="http://foofus.net/goons/jmk/medusa/medusa.html"

#SRC_URI="https://github.com/jmk-foofus/medusa/releases/download/2.3/medusa-2.3.tar.gz"
SRC_URI="https://github.com/jmk-foofus/medusa/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="${MODULES[@]} debug"
DOCS=( AUTHORS NEWS README.md TODO ChangeLog sample )

RDEPEND="dev-libs/openssl:=
	ssh? ( net-libs/libssh2 )
	postgres? ( dev-db/postgresql:= )
	rdp? ( net-misc/freerdp )
	subversion? ( dev-vcs/subversion )
	"
	#afp was removed as unmaintained and unbuildable
	#afp? ( net-fs/afpfs-ng )"
#FIXME: CONFIG_NCP_FS

DEPEND="${RDEPEND}"

#S="${WORKDIR}/${PN}-${COMMIT_HASH}"

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
