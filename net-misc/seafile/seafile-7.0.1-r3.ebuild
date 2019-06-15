# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )
inherit autotools python-single-r1 vala

DESCRIPTION="File syncing and sharing software with file encryption and group sharing"
HOMEPAGE="https://github.com/haiwen/seafile/ http://www.seafile.com/"
SRC_URI="https://github.com/haiwen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+-with-openssl-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	!net-libs/ccnet
	net-misc/ccnet-server
	>=net-libs/libsearpc-3.1[${PYTHON_USEDEP}]
	dev-libs/glib:2
	dev-libs/libevent:0
	dev-libs/jansson
	sys-libs/zlib:0
	net-misc/curl
	dev-libs/openssl:0
	dev-db/sqlite:3"
DEPEND="${RDEPEND}
	$(vala_depend)"

src_prepare() {
	default
	# similar with libsearpc
	sed -i -e 's|(DESTDIR)||' lib/libseafile.pc.in

	sed -i -e 's/valac /${VALAC} /' lib/Makefile.am || die

	# seems not required, overlaps with server
	sed -i -e 's/ python//' Makefile.am || die

	eautoreconf
	vala_src_prepare
	eapply_user
}

src_install() {
	default
	# Remove unnecessary .la files, as recommended by ltprune.eclass
	find "${ED}" -name '*.la' -delete || die
	python_fix_shebang "${ED}"/usr/bin
}
