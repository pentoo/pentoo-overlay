# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils desktop xdg-utils

DESCRIPTION="A web app for encryption, encoding, compression and data analysis (offline)"
HOMEPAGE="https://gchq.github.io/CyberChef"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gchq/CyberChef"
else
	SRC_URI="https://github.com/gchq/CyberChef/releases/download/v${PV}/CyberChef_v${PV}.zip -> ${P}.zip"
	KEYWORDS="~amd64 ~arm64 ~x86"
	S="${WORKDIR}"
fi

LICENSE="Apache-2.0"
SLOT=0
IUSE=""
RDEPEND="
	app-arch/unzip
	x11-misc/xdg-utils"

src_install() {
	insinto "/usr/share/${PN}"
	doins -r .

	dosym "../${PN}/images/cyberchef-128x128.png" \
		"/usr/share/pixmaps/${PN}.png"

	make_wrapper "${PN}" \
		"xdg-open /usr/share/${PN}/CyberChef_v${PV}.html"

	make_desktop_entry \
		"${PN}" \
		"CyberChef" \
		"${PN}" \
		"Utility;Development"
}

pkg_postinst() {
	einfo "\nInstall your favorite web browser and make it as default (it is not necessary in Pentoo)"
	einfo "Example:"
	einfo "    ~$ xdg-mime default firefox.desktop text/html"
	einfo "    ~$ xdg-settings set default-web-browser firefox.desktop\n"
	#for x in \
	#	"www-client/firefox-bin" \
	#	"www-client/firefox" \
	#	"www-client/chromium" \
	#	"www-client/google-chrome" \
	#	"www-client/google-chrome-beta" \
	#	"www-client/google-chrome-unstable"
	#do
	#	optfeature "${PN} support" "${x}"
	#done

	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
