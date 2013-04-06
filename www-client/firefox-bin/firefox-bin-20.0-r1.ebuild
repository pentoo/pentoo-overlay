# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/firefox-bin/firefox-bin-20.0.ebuild,v 1.1 2013/04/03 00:34:04 jdhore Exp $

EAPI="4"

# Can be updated using scripts/get_langs.sh from mozilla overlay
MOZ_LANGS=(af ak ar as ast be bg bn-BD bn-IN br bs ca cs csb cy da de el en
en-GB en-US en-ZA eo es-AR es-CL es-ES es-MX et eu fa fi fr fy-NL ga-IE gd gl
gu-IN he hi-IN hr hu hy-AM id is it ja kk kn ko ku lg lt lv mai mk ml mr nb-NO
nl nn-NO nso or pa-IN pl pt-BR pt-PT rm ro ru si sk sl son sq sr sv-SE ta ta-LK
te th tr uk vi zh-CN zh-TW zu)

# Convert the ebuild version to the upstream mozilla version, used by mozlinguas
MOZ_PV="${PV/_beta/b}" # Handle beta for SRC_URI
MOZ_PV="${MOZ_PV/_rc/rc}" # Handle rc for SRC_URI
MOZ_PN="${PN/-bin}"
MOZ_P="${MOZ_PN}-${MOZ_PV}"

# Upstream ftp release URI that's used by mozlinguas.eclass
# We don't use the http mirror because it deletes old tarballs.
MOZ_FTP_URI="ftp://ftp.mozilla.org/pub/mozilla.org/${MOZ_PN}/releases/"

inherit eutils multilib pax-utils fdo-mime gnome2-utils mozlinguas nsplugins

DESCRIPTION="Firefox Web Browser"
MOZ_FTP_URI="ftp://ftp.mozilla.org/pub/mozilla.org/${MOZ_PN}/releases"
SRC_URI="${SRC_URI}
	amd64? ( ${MOZ_FTP_URI}/${MOZ_PV}/linux-x86_64/en-US/${MOZ_P}.tar.bz2 -> ${PN}_x86_64-${PV}.tar.bz2 )
	x86? ( ${MOZ_FTP_URI}/${MOZ_PV}/linux-i686/en-US/${MOZ_P}.tar.bz2 -> ${PN}_i686-${PV}.tar.bz2 )"
HOMEPAGE="http://www.mozilla.com/firefox"
RESTRICT="strip mirror binchecks"

KEYWORDS="-* ~amd64 ~x86"
SLOT="0"
LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
IUSE="startup-notification"

DEPEND="app-arch/unzip"
RDEPEND="dev-libs/dbus-glib
	virtual/freedesktop-icon-theme
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libXmu

	>=x11-libs/gtk+-2.2:2
	>=media-libs/alsa-lib-1.0.16

	!net-libs/libproxy[spidermonkey]
"

S="${WORKDIR}/${MOZ_PN}"

src_unpack() {
	unpack ${A}

	# Unpack language packs
	mozlinguas_src_unpack
}

src_install() {
	declare MOZILLA_FIVE_HOME=/opt/${MOZ_PN}

	# Install icon and .desktop for menu entry
	newicon "${S}"/chrome/icons/default/default48.png ${PN}-icon.png
	domenu "${FILESDIR}"/${PN}.desktop

	# Add StartupNotify=true bug 237317
	if use startup-notification; then
		echo "StartupNotify=true" >> "${D}"/usr/share/applications/${PN}.desktop
	fi

	# Install firefox in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	mv "${S}" "${D}"${MOZILLA_FIVE_HOME} || die

	# Fix prefs that make no sense for a system-wide install
	insinto ${MOZILLA_FIVE_HOME}/defaults/pref/
	doins "${FILESDIR}"/local-settings.js
	insinto ${MOZILLA_FIVE_HOME}/
	doins "${FILESDIR}"/mozilla.cfg

	# Install language packs
	mozlinguas_src_install

	local LANG=${linguas%% *}
	if [[ -n ${LANG} && ${LANG} != "en" ]]; then
		elog "Setting default locale to ${LANG}"
		echo "pref(\"general.useragent.locale\", \"${LANG}\");" \
			>> "${D}${MOZILLA_FIVE_HOME}"/defaults/pref/${PN}-prefs.js || \
			die "sed failed to change locale"
	fi

	# Create /usr/bin/firefox-bin
	dodir /usr/bin/
	cat <<-EOF >"${D}"/usr/bin/${PN}
	#!/bin/sh
	unset LD_PRELOAD
	LD_LIBRARY_PATH="/opt/firefox/"
	GTK_PATH=/usr/lib/gtk-2.0/
	exec /opt/${MOZ_PN}/${MOZ_PN} "\$@"
	EOF
	fperms 0755 /usr/bin/${PN}

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	doins "${FILESDIR}"/10${PN} || die

	# Plugins dir
	share_plugins_dir

	# Required in order to use plugins and even run firefox on hardened.
	pax-mark mr "${ED}"/${MOZILLA_FIVE_HOME}/{firefox,firefox-bin,plugin-container}
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	if ! has_version 'gnome-base/gconf' || ! has_version 'gnome-base/orbit' \
		|| ! has_version 'net-misc/curl'; then
		einfo
		einfo "For using the crashreporter, you need gnome-base/gconf,"
		einfo "gnome-base/orbit and net-misc/curl emerged."
		einfo
	fi
	# Drop requirement of curl not built with nss as it's not necessary anymore
	#if has_version 'net-misc/curl[nss]'; then
	#	einfo
	#	einfo "Crashreporter won't be able to send reports"
	#	einfo "if you have curl emerged with the nss USE-flag"
	#	einfo
	#fi

	# Update mimedb for the new .desktop file
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
