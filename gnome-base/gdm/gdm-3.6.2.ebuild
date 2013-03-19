# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gdm/gdm-3.6.2.ebuild,v 1.9 2013/03/14 04:29:23 tetromino Exp $

EAPI="5"
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
IUSE="accessibility audit +consolekit +fallback fprint +gnome-shell +introspection ipv6 ldap plymouth selinux smartcard tcpd test xinerama"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"

# NOTE: x11-base/xorg-server dep is for X_SERVER_PATH etc, bug #295686
# nspr used by smartcard extension
# dconf, dbus and g-s-d are needed at install time for dconf update
# libdaemon needed for our fix-daemonize-regression.patch
COMMON_DEPEND="
	app-text/iso-codes
	>=dev-libs/glib-2.33.2:2
	>=x11-libs/gtk+-2.91.1:3
	dev-libs/libdaemon
	>=x11-libs/pango-1.3
	dev-libs/nspr
	>=dev-libs/nss-3.11.1
	>=gnome-base/dconf-0.11.6
	>=gnome-base/gnome-settings-daemon-3.1.4
	gnome-base/gsettings-desktop-schemas
	>=media-libs/fontconfig-2.5.0
	>=media-libs/libcanberra-0.4[gtk3]
	sys-apps/dbus
	>=sys-apps/accountsservice-0.6.12
	>=sys-power/upower-0.9

	x11-apps/sessreg
	x11-base/xorg-server
	x11-libs/libXi
	x11-libs/libXau
	x11-libs/libX11
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXrandr
	>=x11-misc/xdg-utils-1.0.2-r3

	virtual/pam
	sys-auth/pambase[consolekit?]

	accessibility? ( x11-libs/libXevie )
	audit? ( sys-process/audit )
	consolekit? ( sys-auth/consolekit )
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )
	plymouth? ( sys-boot/plymouth )
	selinux? ( sys-libs/libselinux )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	xinerama? ( x11-libs/libXinerama )
"
# XXX: These deps are from session and desktop files in data/ directory
# at-spi:1 is needed for at-spi-registryd (spawned by simple-chooser)
# fprintd is used via dbus by gdm-fingerprint-extension
# gnome-session-3.6 needed to avoid freezing with orca
RDEPEND="${COMMON_DEPEND}
	>=gnome-base/gnome-session-3.6
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

	!gnome-extra/fast-user-switch-applet
"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=dev-util/intltool-0.40.0
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
	x11-proto/inputproto
	x11-proto/randrproto
	test? ( >=dev-libs/check-0.9.4 )
	xinerama? ( x11-proto/xineramaproto )
"

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
	# GDM grabs VT2 instead of VT7, bug 261339, bug 284053, bug 288852
	# XXX: We can now pass a hard-coded initial value; temporary fix
	#epatch "${FILESDIR}/${PN}-2.32.0-fix-vt-problems.patch"

	# daemonize so that the boot process can continue, bug #236701
	epatch "${FILESDIR}/${PN}-3.6.0-fix-daemonize-regression.patch"

	# make custom session work, bug #216984
	epatch "${FILESDIR}/${PN}-3.2.1.1-custom-session.patch"

	# ssh-agent handling must be done at xinitrc.d, bug #220603
	epatch "${FILESDIR}/${PN}-2.32.0-xinitrc-ssh-agent.patch"

	# automagic selinux :/
	epatch "${FILESDIR}/${PN}-3.6.0-selinux-automagic.patch"

	# spurious unicode characters causing build failure, bug #449062
	# https://bugzilla.gnome.org/show_bug.cgi?id=690842
	LC_ALL=C epatch "${FILESDIR}/${PN}-3.6.2-gdm-slave.xml-unicode.patch"

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
		--with-default-pam-config=none
		--with-at-spi-registryd-directory=${EPREFIX}/usr/libexec
		--with-initial-vt=7
		$(use_with accessibility xevie)
		$(use_with audit libaudit)
		$(use_enable ipv6)
		$(use_with consolekit console-kit)
		$(use_with plymouth)
		$(use_with selinux)
		$(use_with tcpd tcp-wrappers)
		$(use_with xinerama)
		ITSTOOL=$(type -P true)"
	gnome2_src_configure
}

src_install() {
	gnome2_src_install

	# our x11's scripts point to /usr/bin/gdm
	dosym /usr/sbin/gdm-binary /usr/bin/gdm

	# log, etc.
	keepdir /var/log/gdm

	# gdm user's home directory
	keepdir /var/lib/gdm
	fowners gdm:gdm /var/lib/gdm

	# install XDG_DATA_DIRS gdm changes
	echo 'XDG_DATA_DIRS="/usr/share/gdm"' > 99xdg-gdm
	doenvd 99xdg-gdm

	cd "${WORKDIR}/${G_P}"
	local LDAP
	use ldap && LDAP=yes
	emake GDM_WELCOME="gdm-launch-environment" LDAP=${LDAP} EPREFIX="${EPREFIX}" \
		SYSTEMD_UNITDIR="$(systemd_get_unitdir)" DESTDIR="${D}" install
}

pkg_postinst() {
	local d ret

	gnome2_pkg_postinst

	dbus-launch dconf update || die "'dconf update' failed"

	# bug #436456; gdm crashes if /var/lib/gdm subdirs are not owned by gdm:gdm
	ret=0
	ebegin "Fixing ${EROOT}var/lib/gdm ownership"
	chown gdm:gdm "${EROOT}var/lib/gdm" || ret=1
	for d in "${EROOT}var/lib/gdm/"{.cache,.config,.local}; do
		[[ ! -e "${d}" ]] || chown -R gdm:gdm "${d}" || ret=1
	done
	eend ${ret}

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
}

pkg_postrm() {
	gnome2_pkg_postrm

	if rc-config list default | grep -q xdm; then
		elog "To remove GDM from startup please execute"
		elog "'rc-update del xdm default'"
	fi
}
