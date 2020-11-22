# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop eutils unpacker xdg-utils

DESCRIPTION="Visualise, map and mine data"
HOMEPAGE="https://www.paterva.com/"
SRC_URI="https://maltego-downloads.s3.us-east-2.amazonaws.com/linux/Maltego.v${PV}.deb -> ${P}.deb"

LICENSE="Paterva-EULA"
SLOT=0
KEYWORDS="~amd64 ~x86"

RDEPEND="|| ( virtual/jre virtual/jdk )"
BDEPEND="$(unpacker_src_uri_depends)"

S="${WORKDIR}"

src_prepare() {
	# cleanup
	rm -fr usr/{share/doc,share/applications,bin} || die
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

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
