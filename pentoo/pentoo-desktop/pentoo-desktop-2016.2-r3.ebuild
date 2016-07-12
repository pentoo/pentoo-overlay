# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

KEYWORDS="amd64 arm x86"
DESCRIPTION="Pentoo meta ebuild to install all X and WM/DE related things"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="X cdr cups gtk2 enlightenment hardened kde livecd-stage1 mate pentoo plasma pulseaudio samba +xfce"

S="${WORKDIR}"

DEPEND="!pentoo/pentoo-etc-portage
	pentoo? ( !<pentoo/pentoo-system-2014.3-r1 )
	!!<pentoo/pentoo-2014.3"

RDEPEND="pentoo? ( !<pentoo/pentoo-system-2014.3 )"

#X windows stuff
PDEPEND="X? (
		!livecd-stage1? ( || ( x11-base/xorg-server dev-libs/wayland ) )
		app-admin/genmenu
		|| ( net-misc/networkmanager net-misc/wicd net-wireless/wifi-radar )
		net-misc/x11-ssh-askpass
		x11-apps/setxkbmap
		x11-apps/xbacklight
		x11-apps/xdm
		x11-apps/xinit
		x11-apps/xinput
		x11-misc/arandr
		x11-apps/xrandr
		x11-misc/slim
		x11-proto/dri2proto
		x11-terms/rxvt-unicode
		x11-themes/gtk-theme-switch
		app-arch/file-roller
		pulseaudio? ( media-sound/pavucontrol )
		kde? ( || ( kde-misc/kdesudo kde-apps/kdesu ) )
		gtk2? ( net-misc/rdesktop
			x11-libs/gksu
			)
		|| ( kde? ( kde-apps/krdc:4 ) net-misc/tigervnc net-misc/tightvnc )
		amd64? ( || ( www-client/chromium www-client/google-chrome www-client/google-chrome-beta www-client/google-chrome-unstable ) )
		x86? ( !hardened? ( || ( www-client/chromium www-client/google-chrome www-client/google-chrome-beta www-client/google-chrome-unstable ) ) )
		|| ( www-client/firefox www-client/firefox-bin )
		www-plugins/hackplugins-meta
		)"

# Window makers
PDEPEND="${PDEPEND}
	enlightenment? ( x11-wm/enlightenment:0.17
		x11-terms/terminology
		gnome-base/gnome-menus
		=x11-plugins/extramenu-9999
	)
	kde? ( kde-base/kdebase-startkde
		kde-apps/gwenview:4
		kde-apps/kate:4
		kde-apps/kcalc:4
		kde-apps/kgpg
		kde-apps/kmix:4
		kde-apps/knotify
		kde-apps/kolourpaint
		kde-apps/ksnapshot
		kde-misc/plasma-nm
		kde-apps/okular
		samba? ( net-misc/smb4k )
	)
	plasma? ( kde-plasma/plasma-meta
		kde-apps/konsole
		kde-apps/gwenview
		kde-apps/kate
		kde-apps/kcalc
		kde-apps/kcharselect
		kde-apps/kmix
		kde-apps/kolourpaint
		kde-apps/ksnapshot
		kde-apps/okular
		kde-apps/dolphin
		samba? ( net-misc/smb4k )
	)
	mate? ( mate-base/mate
		|| ( gnome-extra/nm-applet net-misc/wicd net-wireless/wifi-radar )
		x11-misc/mate-notification-daemon
	)
	xfce? ( xfce-base/xfce4-meta
		cdr? ( app-cdr/xfburn )
		pulseaudio? ( xfce-extra/xfce4-volumed-pulse )
		|| ( gnome-extra/nm-applet net-misc/wicd net-wireless/wifi-radar )
		app-editors/leafpad
		app-text/evince
		app-text/mupdf
		media-gfx/geeqie
		x11-terms/xfce4-terminal
		x11-themes/tango-icon-theme
		xfce-base/thunar
		xfce-extra/xfce4-battery-plugin
		xfce-extra/thunar-archive-plugin
		xfce-extra/thunar-vcs-plugin
		xfce-extra/thunar-volman
		xfce-extra/tumbler
		pulseaudio? ( xfce-extra/xfce4-pulseaudio-plugin )
		xfce-extra/xfce4-notifyd
		xfce-extra/xfce4-power-manager
		xfce-extra/xfce4-screenshooter
		xfce-extra/xfce4-xkb-plugin
	)"

src_install() {
	insinto /usr/share/pentoo/wallpaper
	doins "${FILESDIR}"/domo-roolz.jpg
	doins "${FILESDIR}"/domo-roolz-shmoocon2014.png
	doins "${FILESDIR}"/tux-winfly-killah.1600x1200.jpg
	doins "${FILESDIR}"/xfce4-desktop.xml
	dosym /usr/share/pentoo/wallpaper/domo-roolz.jpg /usr/share/backgrounds/xfce/domo-roolz.jpg
	dosym /usr/share/pentoo/wallpaper/domo-roolz-shmoocon2014.png /usr/share/backgrounds/xfce/domo-roolz-shmoocon2014.png
	dosym /usr/share/pentoo/wallpaper/tux-winfly-killah.1600x1200.jpg /usr/share/backgrounds/xfce/tux-winfly-killah.1600x1200.jpg
}
