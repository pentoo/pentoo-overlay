# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit autotools subversion

DESCRIPTION="packet-o-matic is a real time packet processor"
HOMEPAGE="http://www.packet-o-matic.org/"
ESVN_REPO_URI="https://svn.tuxicoman.be/svn/packet-o-matic/trunk"
ESVN_PROJECT="packet-o-matic"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~hppa ~sparc ~amd64"
IUSE="zlib postgres sqlite xmlrpc"

DEPEND="dev-libs/libxml2
		net-libs/libpcap
		zlib? ( sys-libs/zlib )
		postgres? ( dev-db/postgresql-base:8.4 )
		sqlite? ( >dev-db/sqlite-3 )
		xmlrpc? ( dev-libs/xmlrpc-c )"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	subversion_src_unpack
	SVN_PATH="${ESVN_STORE_DIR}/${ESVN_PROJECT}/${ESVN_REPO_URI##*/}"
	export SVN_VERSION=`svnversion -c ${SVN_PATH} | sed -e 's/.*://' -e 's/[A-Za-z]//'`
	sed \
		-e "/POM_RELEASE_VERSION/s/.*/#define POM_RELEASE_VERSION \"svn-r${SVN_VERSION}\"/" \
		-i src/release.h || die "Unable to set SVN revision"
	eautoreconf || die "autoreconf failed"
	econf || die "Configuration failed"

}

src_compile() {
	emake || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
