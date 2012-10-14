# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
E_SNAP_DATE="2012-10-12"
inherit enlightenment

DESCRIPTION="Enlightenment DR17 window manager"
SLOT="0.17"

# The @ is just an anchor to expand from
__EVRY_MODS=""
__CONF_MODS="
	+@applications +@dialogs +@display +@edgebindings
	+@interaction +@intl +@keybindings +@menus
	+@paths +@performance +@randr +@shelves +@theme
	+@wallpaper2 +@window-manipulation +@window-remembers"
__NORM_MODS="
	@access +@backlight +@battery +@clock +@comp +@connman +@cpufreq +@dropshadow
	+@everything +@fileman +@fileman-opinfo +@gadman +@ibar +@ibox +@illume2
	+@mixer	+@msgbus +@notification @ofono +@pager +@quickaccess +@shot +@start +@syscon
	+@systray +@tasks +@temperature +@tiling +@winlist +@wizard +@xkbswitch"
IUSE_E_MODULES="
	${__CONF_MODS//@/e_modules_conf-}
	${__NORM_MODS//@/e_modules_}"

IUSE="bluetooth exchange pam spell static-libs +udev ukit ${IUSE_E_MODULES}"

RDEPEND="exchange? ( >=app-misc/exchange-9999 )
	pam? ( sys-libs/pam )
	>=dev-libs/efreet-1.7.0
	>=dev-libs/eio-1.7.0
	>=dev-libs/eina-1.7.0[mempool-chained]
	|| ( >=dev-libs/ecore-1.7.0[X,evas,inotify] >=dev-libs/ecore-1.7.0[xcb,evas,inotify] )
	>=media-libs/edje-1.7.0
	>=dev-libs/e_dbus-1.7.0[libnotify,udev?]
	ukit? ( >=dev-libs/e_dbus-1.7.0[udev] )
	e_modules_connman? ( >=dev-libs/e_dbus-1.7.0[connman] )
	e_modules_ofono? ( >=dev-libs/e_dbus-1.7.0[ofono] )
	|| ( >=media-libs/evas-1.7.0[eet,X,jpeg,png] >=media-libs/evas-1.7.0[eet,xcb,jpeg,png] )
	bluetooth? ( net-wireless/bluez )
	>=dev-libs/eeze-1.7.0"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/quickstart.diff
	enlightenment_src_prepare
}

src_configure() {
	export MY_ECONF="
		--disable-install-sysactions
		--disable-elementary
		$(use_enable bluetooth bluez)
		$(use_enable doc)
		$(use_enable exchange)
		--disable-device-hal
		--disable-mount-hal
		$(use_enable nls)
		$(use_enable pam)
		--enable-device-udev
		$(use_enable udev mount-eeze)
		$(use_enable ukit mount-udisks)
	"
	local u c
	for u in ${IUSE_E_MODULES} ; do
		u=${u#+}
		c=${u#e_modules_}
		MY_ECONF+=" $(use_enable ${u} ${c})"
	done
	enlightenment_src_configure
}

src_install() {
	enlightenment_src_install
	insinto /etc/enlightenment
	newins "${FILESDIR}"/gentoo-sysactions.conf sysactions.conf || die
}
