# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools desktop eutils multilib toolchain-funcs xdg-utils

DESCRIPTION="Perform a rainbow table attack on password hashes"
HOMEPAGE="https://freerainbowtables.com/"
SRC_URI="mirror://sourceforge/rcracki/rcracki_mt_${PV}_src.7z -> ${P}.7z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="gtk"

RDEPEND="
	app-arch/p7zip
	dev-libs/openssl:0
	gtk? (
		dev-libs/glib:2
		x11-libs/cairo
		x11-libs/gtk+:2
		x11-libs/pango
	)"

DEPEND="${RDEPEND}"

S="${WORKDIR}/rcracki_mt_${PV}_src/${PN}"

src_prepare() {
	sed -e "s#GetApplicationPath() + \"charset.txt\"#\"/usr/share/${PN}/charset.txt\"#g" \
		-i ChainWalkContext.cpp || die
	sed -e "s|CC = g++|CC = $(tc-getCXX)|" \
		-e "s|-O3|${CXXFLAGS}|" \
		-e "s|\$(LFLAGS)|${LDFLAGS}|" \
		-e "s|-L/usr/lib|-L/usr/$(get_libdir)|" \
		-e "s|-L/lib|-L/$(get_libdir)|" \
		-i Makefile || die

	if use gtk; then
		cd ../${PN}-gui || die
		sed -e "s|@LDFLAGS@|@LDFLAGS@ -pthread|" -i Makefile.in || die
		mv configure.in configure.ac || die
		eautoreconf
	fi

	default
}

src_configure() {
	if use gtk; then
		cd ../${PN}-gui || die
		econf
	fi
}

src_compile() {
	if use gtk; then
		cd ../${PN}-gui || die
		emake -j1
	else
		emake
	fi
}

src_install() {
	insinto "/usr/share/${PN}"
	doins charset.txt

	if use gtk; then
		cd ../${PN}-gui || die
		insinto "/usr/share/pixmaps"
		newins icon.png ${PN}.png

		newbin rcracki_mt-gui $PN

		make_desktop_entry $PN \
			"${PN}-GUI" \
			"${PN}" "Utility"
	else
		dobin rcracki_mt
	fi
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}
