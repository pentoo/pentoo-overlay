# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils eapi7-ver gnome2-utils unpacker xdg-utils

DESCRIPTION="Visualise, map and mine data"
HOMEPAGE="https://www.paterva.com/"

SHORT_V="$(ver_cut 1-3)"
SRC_URI="https://www.paterva.com/malv${SHORT_V//./}/Maltego.v${PV}.deb -> ${P}.deb"

KEYWORDS="~amd64 ~x86"
LICENSE="all-rights-reserved"
SLOT=0
IUSE=""
DEPEND="$(unpacker_src_uri_depends)"
RDEPEND="virtual/jre:1.8"

S="${WORKDIR}"

src_prepare() {
	# Cleanup
	for x in share/doc share/applications bin; do
		rm -fr "usr/${x}" || die
	done

	default
}

src_install() {
	doins -r *

	fperms +x "/usr/share/${PN}/bin/${PN}"
	dosym "../share/${PN}/bin/${PN}" "/usr/bin/${PN}"

	make_wrapper \
		"${PN}_memory_config" \
		"/usr/bin/java -jar \"/usr/share/maltego/maltego-ui/modules/ext/Java_Config_App.jar\""

	make_desktop_entry \
		"${PN}" \
		"Maltego" \
		"${PN}" \
		"Development;Utility;"

	make_desktop_entry \
		"${PN}_memory_config" \
		"Maltego Memory Config" \
		"${PN}" \
		"Settings;"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	elog "\nSee documentation:"
	elog "    https://docs.paterva.com/"
	elog "    https://docs.maltego.com/support/home\n"
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
