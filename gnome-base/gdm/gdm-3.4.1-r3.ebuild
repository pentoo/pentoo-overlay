# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gdm/gdm-3.4.1-r3.ebuild,v 1.2 2012/12/26 21:45:01 eva Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2 pam user

G_PV="2012.09.25"
G_P="gdm-gentoo-${G_PV}"
DESCRIPTION="GNOME Display Manager"
HOMEPAGE="https://live.gnome.org/GDM"
SRC_URI="${SRC_URI}
	http://dev.gentoo.org/~tetromino/distfiles/${PN}/${G_P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
IUSE="accessibility audit +consolekit +fallback fprint +gnome-shell +introspection ipv6 ldap plymouth selinux smartcard tcpd test xinerama +xklavier"
KEYWORDS="~amd64 ~sh ~x86"

# NOTE: x11-base/xorg-server dep is for X_SERVER_PATH etc, bug #295686
# nspr used by smartcard extension
# dconf, dbus and g-s-d are needed at install time for dconf update
COMMON_DEPEND="
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/glib-2.29.3:2
	>=x11-libs/gtk+-2.91.1:3
	>=x11-libs/pango-1.3
	dev-libs/nspr
	>=dev-libs/nss-3.11.1
	>=media-libs/fontconfig-2.5.0
	>=media-libs/libcanberra-0.4[gtk3]
	>=x11-misc/xdg-utils-1.0.2-r3
	>=sys-power/upower-0.9
	>=sys-apps/accountsservice-0.6.12

	>=gnome-base/dconf-0.11.6
	>=gnome-base/gnome-settings-daemon-3.1.4
	gnome-base/gsettings-desktop-schemas
	sys-apps/dbus

	app-text/iso-codes

	x11-base/xorg-server
	x11-libs/libXi
	x11-libs/libXau
	x11-libs/libX11
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXrandr
	x11-apps/sessreg

	virtual/pam
	sys-auth/pambase[consolekit?]

	accessibility? ( x11-libs/libXevie )
	audit? ( sys-process/audit )
	consolekit? ( sys-auth/consolekit[pam] )
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )
	plymouth? ( sys-boot/plymouth )
	selinux? ( sys-libs/libselinux )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	xinerama? ( x11-libs/libXinerama )
	xklavier? ( >=x11-libs/libxklavier-4 )"
DEPEND="${COMMON_DEPEND}
	test? ( >=dev-libs/check-0.9.4 )
	xinerama? ( x11-proto/xineramaproto )
	app-text/docbook-xml-dtd:4.1.2
	sys-devel/gettext
	x11-proto/inputproto
	x11-proto/randrproto
	>=dev-util/intltool-0.40.0
	>=app-text/scrollkeeper-0.1.4
	>=app-text/gnome-doc-utils-0.3.2
	virtual/pkgconfig"
# XXX: These deps are from session and desktop files in data/ directory
# at-spi:1 is needed for at-spi-registryd (spawned by simple-chooser)
# fprintd is used via dbus by gdm-fingerprint-extension
RDEPEND="${COMMON_DEPEND}
	>=gnome-base/gnome-session-2.91.92
	x11-apps/xhost
	x11-themes/gnome-icon-theme-symbolic

	accessibility? (
		app-accessibility/gnome-mag
		app-accessibility/gok
		app-accessibility/orca
		gnome-extra/at-spi:1 )
	consolekit? ( gnome-extra/polkit-gnome )
	fallback? ( x11-wm/metacity )
	fprint? (
		sys-auth/fprintd
		sys-auth/pam_fprint )
	gnome-shell? ( >=gnome-base/gnome-shell-3.1.90 )
	!gnome-shell? ( x11-wm/metacity )
	smartcard? (
		app-crypt/coolkey
		sys-auth/pam_pkcs11 )

	!gnome-extra/fast-user-switch-applet"

pkg_setup() {
	enewgroup gdm
	enewgroup video # Just in case it hasn't been created yet
	enewuser gdm -1 -1 /var/lib/gdm gdm,video

	# For compatibility with certain versions of nvidia-drivers, etc., need to
	# ensure that gdm user is in the video group
	if ! egetent group video | grep -q gdm; then
		# FIXME XXX: is this at all portable, ldap-safe, etc.?
		# XXX: egetent does not have a 1-argument form, so we can't use it to
		# get the list of gdm's groups
		local g=$(groups gdm)
		elog "Adding user gdm to video group"
		usermod -G video,${g// /,} gdm || die "Adding user gdm to video group failed"
	fi
}

src_prepare() {
	# remove unneeded linker directive for selinux, bug #41022
	epatch "${FILESDIR}/${PN}-2.32.0-selinux-remove-attr.patch"

	# daemonize so that the boot process can continue, bug #236701
	epatch "${FILESDIR}/${PN}-2.32.0-fix-daemonize-regression.patch"

	# GDM grabs VT2 instead of VT7, bug 261339, bug 284053, bug 288852
	epatch "${FILESDIR}/${PN}-2.32.0-fix-vt-problems.patch"

	# make custom session work, bug #216984
	epatch "${FILESDIR}/${PN}-3.2.1.1-custom-session.patch"

	# ssh-agent handling must be done at xinitrc.d, bug #220603
	epatch "${FILESDIR}/${PN}-2.32.0-xinitrc-ssh-agent.patch"

	# fix libxklavier automagic support
	epatch "${FILESDIR}/${PN}-2.32.0-automagic-libxklavier-support.patch"

	# plymouth support (in next release)
	epatch "${FILESDIR}/${P}-save-root-window.patch"
	epatch "${FILESDIR}/${P}-plymouth.patch"

	# dconf-0.13.x compatibility (next release)
	epatch "${FILESDIR}/${P}-dconf-0.13.patch"

	# don't load accessibility support at runtime when USE=-accessibility
	use accessibility || epatch "${FILESDIR}/${PN}-3.3.92.1-disable-accessibility.patch"

	# make gdm-fallback session the default if USE=-gnome-shell
	if ! use gnome-shell; then
		sed -e "s:'gdm-shell':'gdm-fallback':" \
			-i data/00-upstream-settings || die "sed failed"
	fi

	mkdir -p "${S}"/m4
	eautoreconf

	gnome2_src_prepare
}

src_configure() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"

	# PAM is the only auth scheme supported
	# even though configure lists shadow and crypt
	# they don't have any corresponding code.
	# --with-at-spi-registryd-directory= needs to be passed explicitly because
	# of https://bugzilla.gnome.org/show_bug.cgi?id=607643#c4
	G2CONF="${G2CONF}
		--disable-static
		--localstatedir=${EPREFIX}/var
		--with-xdmcp=yes
		--enable-authentication-scheme=pam
		--with-pam-prefix=${EPREFIX}/etc
		--with-at-spi-registryd-directory=${EPREFIX}/usr/libexec
		$(use_with accessibility xevie)
		$(use_with audit libaudit)
		$(use_enable ipv6)
		$(use_enable xklavier libxklavier)
		$(use_with consolekit console-kit)
		$(use_with plymouth)
		$(use_with selinux)
		$(use_with tcpd tcp-wrappers)
		$(use_with xinerama)"
	gnome2_src_configure
}

src_install() {
	gnome2_src_install

	# gdm-binary should be gdm to work with our init (#5598)
	rm -f "${ED}/usr/sbin/gdm"
	ln -sfn /usr/sbin/gdm-binary "${ED}/usr/sbin/gdm"
	# our x11's scripts point to /usr/bin/gdm
	ln -sfn /usr/sbin/gdm-binary "${ED}/usr/bin/gdm"

	# log, etc.
	keepdir /var/log/gdm

	# install XDG_DATA_DIRS gdm changes
	echo 'XDG_DATA_DIRS="/usr/share/gdm"' > 99xdg-gdm
	doenvd 99xdg-gdm

	# pam.d/gdm is no longer needed, and can block pam-1.1.6, #435042
	rm -v "${ED}etc/pam.d/gdm" || die

	cd "${WORKDIR}/${G_P}"
	local LDAP
	use ldap && LDAP=yes
	emake LDAP=${LDAP} EPREFIX="${EPREFIX}" \
		SYSTEMD_UNITDIR="$(systemd_get_unitdir)" DESTDIR="${D}" install
}

pkg_postinst() {
	gnome2_pkg_postinst

	dbus-launch dconf update || die "'dconf update' failed"

	ewarn
	ewarn "This is an EXPERIMENTAL release, please bear with its bugs and"
	ewarn "visit us on #gentoo-desktop if you have problems."
	ewarn

	elog "To make GDM start at boot, edit /etc/conf.d/xdm"
	elog "and then execute 'rc-update add xdm default'."
	elog "If you already have GDM running, you will need to restart it."

	elog
	elog "GDM ignores most non-localization environment variables. If you"
	elog "need GDM to launch gnome-session with a particular environment,"
	elog "you need to use pam_env.so in /etc/pam.d/gdm-welcome; see"
	elog "the pam_env man page for more information."
	elog

	if has_version sys-auth/pambase[gnome-keyring]; then
		elog "For passwordless login to unlock your keyring, you need to set an"
		elog "empty password on your keyring. Use app-crypt/seahorse for that."
	else
		elog "To unlock your keyring on login, install sys-auth/pambase"
		elog "with USE=gnome-keyring"
	fi

	if [[ -f "/etc/X11/gdm/gdm.conf" ]]; then
		elog "You had /etc/X11/gdm/gdm.conf which is the old configuration"
		elog "file.  It has been moved to /etc/X11/gdm/gdm-pre-gnome-2.16"
		mv /etc/X11/gdm/gdm.conf /etc/X11/gdm/gdm-pre-gnome-2.16
	fi

	# https://bugzilla.redhat.com/show_bug.cgi?id=513579
	# Lennart says this problem is fixed, but users are still reporting problems
	# XXX: Do we want this elog?
#	if has_version "media-libs/libcanberra[pulseaudio]" ; then
#		elog
#		elog "You have media-libs/libcanberra with the pulseaudio USE flag"
#		elog "enabled. GDM will start a pulseaudio process to play sounds. This"
#		elog "process should automatically terminate when a user logs into a"
#		elog "desktop session. If GDM's pulseaudio fails to terminate and"
#		elog "causes problems for users' audio, you can prevent GDM from"
#		elog "starting pulseaudio by editing /var/lib/gdm/.pulse/client.conf"
#		elog "so it contains the following two lines:"
#		elog
#		elog "autospawn = no"
#		elog "daemon-binary = /bin/true"
#	fi
}

pkg_postrm() {
	gnome2_pkg_postrm

	if rc-config list default | grep -q xdm; then
		elog "To remove GDM from startup please execute"
		elog "'rc-update del xdm default'"
	fi
}
