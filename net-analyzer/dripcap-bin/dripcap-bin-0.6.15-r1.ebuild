# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
CHROMIUM_LANGS="am ar bg bn ca cs da de el en-GB es es-419 et fa fi fil fr
	gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru
	sk sl sr sv sw ta te th tr uk vi zh-CN zh-TW"

inherit chromium-2 gnome2-utils unpacker xdg-utils

DESCRIPTION="Caffeinated Modern Packet Analyzer"
HOMEPAGE="https://dripcap.org https://github.com/dripcap/dripcap"
SRC_URI="https://github.com/dripcap/dripcap/releases/download/v${PV}/dripcap-linux-amd64.deb -> ${P}.deb"
LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

#libcap2-bin
#node-gyp mocha
#libnode.so: dev-util/electron
DEPEND="$(unpacker_src_uri_depends)"
RDEPEND="
	!net-analyzer/dripcap
	app-misc/ca-certificates
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	dev-libs/openssl:0=
	gnome-base/gconf
	media-libs/alsa-lib
	media-libs/freetype
	net-misc/wget
	net-misc/curl
	sys-apps/dbus
	virtual/libudev
	x11-libs/gtk+:2
	x11-misc/xdg-utils
	x11-libs/gtk+:2"

QA_PREBUILT="*"

S="${WORKDIR}"

pkg_setup() {
	:
}

src_prepare() {
	default

	pushd "usr/share/dripcap/locales" > /dev/null || die "Failed to install!"
	chromium_remove_language_paks
	popd > /dev/null

	# Cleanup
	rm -r usr/share/{doc,lintian}
}

src_install() {
	cp -Rp . "${D}" || die "Failed to install!"
	dosym ../share/dripcap/dripcap /usr/bin/dripcap
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
