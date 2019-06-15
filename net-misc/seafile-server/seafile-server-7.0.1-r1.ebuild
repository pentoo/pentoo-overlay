# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )
inherit autotools python-single-r1 vala

DESCRIPTION="File syncing and sharing software with file encryption and group sharing"
HOMEPAGE="https://github.com/haiwen/seafile-server/ http://www.seafile.com/"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}-server.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+-with-openssl-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	!net-libs/ccnet
	net-misc/ccnet-server

	net-libs/libevhtp[oniguruma]
	dev-libs/libevent
	net-misc/curl
	dev-libs/glib
	virtual/libmysqlclient
	app-arch/libarchive
	dev-libs/jansson
	sys-fs/fuse
	dev-db/sqlite:3

	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/termcolor-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.8.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-3.3.2[${PYTHON_USEDEP}]
	>=dev-python/backports-functools-lru-cache-1.4[${PYTHON_USEDEP}]
	>=dev-python/tenacity-4.8.0[${PYTHON_USEDEP}]"
#moviepy
DEPEND="${RDEPEND}
	$(vala_depend)"

S="${WORKDIR}/${P}-server"

src_prepare() {
	#https://github.com/haiwen/seafile-server/issues/67#issuecomment-337904800
	eapply "${FILESDIR}/libevhtp-1.2.18.patch"

	#do not overlap files with seafile
	#https://github.com/haiwen/seafile-server/issues/235
	eapply "${FILESDIR}/remove_pc.patch"
	sed -i '/seafile_HEADERS/d' lib/Makefile.am || die
	sed -i -e 's|seafile ||' python/Makefile.am || die
	sed -i -e 's/valac /${VALAC} /' lib/Makefile.am || die

	python_fix_shebang tools/seafile-admin

	eautoreconf
	vala_src_prepare
	eapply_user
}

