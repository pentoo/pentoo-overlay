# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
inherit autotools python-single-r1 vala

DESCRIPTION="Internal communication framework and user/group management for Seafile server"
HOMEPAGE="https://github.com/haiwen/ccnet-server/ http://www.seafile.com/"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}-server.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+-with-openssl-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	!net-libs/ccnet
	dev-libs/libevent
	net-libs/libsearpc
	dev-libs/glib"

#openssl... yes
#gobject-2.0 >= 2.16.0... yes

DEPEND="${RDEPEND}
	$(vala_depend)"

S="${WORKDIR}/${P}-server"

src_prepare() {
	sed -i -e 's/valac /${VALAC} /' lib/Makefile.am || die

#	sed -i -e 's|\/ccnet|\/ccnet-server|' include/ccnet/Makefile.am
#	sed -i -e 's|\/ccnet|\/ccnet-server|' include/Makefile.am

	eautoreconf
	vala_src_prepare
	eapply_user
}

#src_configure() {
#	econf \
#		--enable-python=no
#		#--with-mysql \
#		#--with-postgresql \
#}
