# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

ESVN_URI_APPEND="e"
inherit enlightenment eutils

DESCRIPTION="the e17 window manager"

SLOT="0.17"
IUSE="pam exchange"

RDEPEND=">=x11-libs/ecore-9999
	>=media-libs/edje-9999
	>=dev-libs/eet-9999
	>=dev-libs/efreet-9999
	>=dev-libs/embryo-9999
	>=dev-libs/eina-9999
	>=x11-libs/evas-9999
	>=x11-libs/e_dbus-9999
	pam? ( sys-libs/pam )
	exchange? ( >=app-misc/exchange-9999 )"

# Masked modules due to theirs merge into 'e' tree, forcing against them, to
# prevent any collisions
DEPEND="${RDEPEND}
	!x11-plugins/e_modules-systray
	x11-proto/xproto
	sys-devel/libtool"

pkg_setup() {
	if ! built_with_use x11-libs/evas png ; then
		eerror "Re-emerge evas with USE=png"
		die "Re-emerge evas with USE=png"
	fi
	enlightenment_pkg_setup
}

src_compile() {
	epatch "${FILESDIR}/batget_cpu_fix.patch"
	export MY_ECONF="
		$(use_enable exchange conf-theme)
	"
	enlightenment_src_compile
}
