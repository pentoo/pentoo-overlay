# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo meta ebuild to install all X and WM/DE related things"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="amd64 arm x86"
IUSE="X cdr cups gtk2 enlightenment kde livecd-stage1 mate pentoo-full pulseaudio samba +thunar upstream-bins +vnc +xfce"

S="${WORKDIR}"

#moving remaining desktop stuff to from pentoo-system
DEPEND="!<pentoo/pentoo-system-2018.2-r1"

#X windows stuff
PDEPEND="X? (
		!livecd-stage1? ( || ( x11-base/xorg-server dev-libs/wayland ) )
		app-admin/genmenu
		net-misc/networkmanager
		|| ( x11-misc/slim x11-misc/sddm )
		app-arch/file-roller

		pentoo-full? (
			net-misc/x11-ssh-askpass
			x11-apps/setxkbmap
			x11-apps/xbacklight
			x11-apps/xinit
			x11-apps/xinput
			x11-misc/arandr
			x11-apps/xrandr
			x11-terms/rxvt-unicode
			x11-terms/terminator
			x11-themes/gtk-theme-switch
		)
		pulseaudio? ( media-sound/pavucontrol
				media-sound/paprefs )
		gtk2? ( net-misc/rdesktop
			)
		vnc? (
			|| ( kde? ( kde-apps/krdc ) net-misc/tigervnc )
		)
		amd64? ( upstream-bins? ( || ( www-client/google-chrome www-client/google-chrome-beta www-client/google-chrome-unstable ) )
				!upstream-bins? ( www-client/chromium ) )
		x86? ( upstream-bins?  ( || ( www-client/google-chrome www-client/google-chrome-beta www-client/google-chrome-unstable ) )
				!upstream-bins? ( www-client/chromium ) )
		upstream-bins? ( www-client/firefox-bin )
		!upstream-bins? ( www-client/firefox )
		www-plugins/hackplugins-meta
		)"

# Window makers
PDEPEND="${PDEPEND}
	enlightenment? ( x11-wm/enlightenment:0.17
		x11-terms/terminology
		gnome-base/gnome-menus
	)
	kde? ( kde-plasma/plasma-meta
		kde-apps/konsole
		kde-apps/gwenview
		kde-apps/kate
		kde-apps/kcalc
		kde-apps/kcharselect
		kde-apps/kmix
		kde-apps/kolourpaint
		kde-apps/spectacle
		kde-apps/okular
		kde-apps/dolphin
		kde-apps/kio-extras[samba?]
	)
	mate? ( mate-base/mate
		gnome-extra/nm-applet
		x11-misc/mate-notification-daemon
	)
	xfce? ( xfce-base/xfce4-meta
		cdr? ( gtk2? ( app-cdr/xfburn ) )
		pulseaudio? ( xfce-extra/xfce4-volumed-pulse )
		gnome-extra/nm-applet
		app-editors/leafpad
		app-text/evince
		app-text/mupdf
		media-gfx/geeqie
		sys-apps/gnome-disk-utility
		x11-terms/xfce4-terminal
		x11-themes/tango-icon-theme
		thunar? ( xfce-base/thunar )
		xfce-extra/xfce4-battery-plugin
		xfce-extra/xfce4-sensors-plugin
		xfce-extra/thunar-archive-plugin
		xfce-extra/thunar-vcs-plugin
		xfce-extra/thunar-volman
		xfce-extra/tumbler
		pulseaudio? ( xfce-extra/xfce4-pulseaudio-plugin )
		xfce-extra/xfce4-notifyd
		xfce-extra/xfce4-screenshooter
		xfce-extra/xfce4-xkb-plugin
	)"

src_install() {
	#/usr/bin
	use enlightenment && newbin "${FILESDIR}"/dokeybindings-2012.1 dokeybindings

	dodir /etc/env.d
	use kde && echo 'XSESSION="kde"' > "${ED}"/etc/env.d/90xsession
	use xfce && echo 'XSESSION="Xfce4"' > "${ED}"/etc/env.d/90xsession

	insinto /etc/skel
	newins "${FILESDIR}"/Xdefaults .Xdefaults
	use xfce && newins "${FILESDIR}"/xfce-xinitrc .xinitrc

	insinto /etc/skel/.config
	doins "${FILESDIR}"/mimeapps.list

	insinto /etc/skel/.config/gtk-3.0/
	newins "${FILESDIR}"/gtk3-settings.ini settings.ini

	insinto /etc/skel/.config/xfce4/terminal/
	doins "${FILESDIR}"/terminalrc

	insinto /usr/share/pentoo/wallpaper
	doins "${FILESDIR}"/domo-roolz.jpg
	doins "${FILESDIR}"/domo-roolz-shmoocon2014.png
	doins "${FILESDIR}"/tux-winfly-killah.1600x1200.jpg
	dosym /usr/share/pentoo/wallpaper/domo-roolz.jpg /usr/share/backgrounds/xfce/domo-roolz.jpg
	dosym /usr/share/pentoo/wallpaper/domo-roolz-shmoocon2014.png /usr/share/backgrounds/xfce/domo-roolz-shmoocon2014.png
	dosym /usr/share/pentoo/wallpaper/tux-winfly-killah.1600x1200.jpg /usr/share/backgrounds/xfce/tux-winfly-killah.1600x1200.jpg

	insinto /etc/skel/.config/xfce4
	doins "${FILESDIR}"/helpers.rc
	insinto /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml
	doins "${FILESDIR}"/xfce4-desktop.xml
	doins "${FILESDIR}"/xsettings.xml

	#gtk-theme-switch needs X so do it manually
	insinto /etc/skel
	newins "${FILESDIR}"/gtkrc-2.0 .gtkrc-2.0
}
