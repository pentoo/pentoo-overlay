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

#list of deps ./ci/requirements.txt
RDEPEND="${PYTHON_DEPS}
	!net-libs/ccnet
	net-misc/ccnet-server

	net-libs/libevhtp-haiwen[oniguruma]
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
#	eapply "${FILESDIR}/libevhtp-1.2.18.patch"

#https://github.com/openwrt/packages/tree/master/net/seafile-server/patches
##	eapply "${FILESDIR}/020-script-patches.patch"
	eapply "${FILESDIR}/030-pidfiles-in-same-directory.patch"
	eapply "${FILESDIR}/040-seafile-admin.patch"
##	eapply "${FILESDIR}/050-libseafile-makefile-fixes.patch"
	eapply "${FILESDIR}/060-timestamps-as-int64.patch"
	eapply "${FILESDIR}/070-fuse-mount.patch"
##	eapply "${FILESDIR}/080-Remove-API-deprecated-in-openssl-1.1.patch"
	eapply "${FILESDIR}/090-django-11-compat.patch"
	eapply "${FILESDIR}/100-seafile-admin-Make-sure-ccnet-is-running.patch"

	#libevhtp 1.2.18 (not forked) patches
	#https://github.com/haiwen/seafile-server/issues/67#issuecomment-337904800
##	eapply "${FILESDIR}/110-libevhtp-linking.patch"
#	eapply "${FILESDIR}/120-recent-libevhtp.patch"
#	eapply "${FILESDIR}/130-newer-libevhtp.patch"

	#do not overlap files with seafile
	#https://github.com/haiwen/seafile-server/issues/235
	eapply "${FILESDIR}/remove_pc.patch"
	sed -i '/seafile_HEADERS/d' lib/Makefile.am || die

	sed -i -e 's/valac /${VALAC} /' lib/Makefile.am || die

	python_fix_shebang tools/seafile-admin

	eautoreconf
	vala_src_prepare
	eapply_user
}
