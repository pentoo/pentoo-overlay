# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools desktop eutils git-r3 xdg-utils

DESCRIPTION="Scans a disk image for regular expressions and other content"
HOMEPAGE="https://github.com/simsong/bulk_extractor"

# Must use git due to recursive links
# Please check a ".gitmodules" file on upstream before bump it
EGIT_REPO_URI="https://github.com/simsong/bulk_extractor"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="e40e45a7bdde3d60372f0b55d696a54305acec40"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

#fails to compile with exiv2
#fails to compile without rar
IUSE="aff doc beviewer +ewf exiv2 hashdb +rar"

RDEPEND="
	aff? ( app-forensics/afflib )
	dev-libs/boost
	dev-libs/expat
	dev-libs/openssl:0=
	dev-db/sqlite:3
	dev-libs/libxml2
	ewf? ( app-forensics/libewf )
	exiv2? ( media-gfx/exiv2 )
	sys-libs/zlib
	hashdb? ( dev-libs/hashdb )
	beviewer? (
		|| ( virtual/jre:* virtual/jdk:* )
	)"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	virtual/man"

BDEPEND="
	sys-devel/flex
	virtual/pkgconfig"

src_prepare() {
#	eapply "${FILESDIR}/add_exiv2-0.27_api_support.patch"

	if [[ ${PV} != *9999 ]]; then
		sed -e "s/AC_INIT(BULK_EXTRACTOR, \(.*\),/AC_INIT(BULK_EXTRACTOR, ${PV},/" \
			-i configure.ac || die
	fi

	eautoreconf
	default
}

src_configure() {
	econf \
		--disable-o3 \
		$(use ewf || echo "--disable-libewf")

#		$(use beviewer || echo "--disable-BEViewer") \
#		$(use exiv2 && echo "--enable-exiv2") \
#		$(use aff || echo "--disable-afflib") \
#		$(use hashdb || echo "--disable-hashdb") \
#		$(use rar || echo "--disable-rar" )
}

src_install() {
	dobin src/${PN}
	doman man/*.1
	dodoc AUTHORS ChangeLog NEWS README.md

	if use doc ; then
		pushd doc/doxygen >/dev/null || die
		doxygen || die "doxygen failed"
		popd >/dev/null || die

		dodoc -r \
			doc/doxygen/html \
			doc/Diagnostics_Notes \
			doc/announce \
			doc/*.{pdf,txt,md} \
			doc/programmer_manual/*.pdf
	fi

#	if use beviewer; then
#		local bev_dir="/opt/beviewer-${PV}"

#		insinto "${bev_dir}"
#		doins java_gui/BEViewer.jar

#		insinto /usr/share/pixmaps
#		newins java_gui/icons/24/run-build-install.png ${PN}.png

#		make_wrapper "beviewer" \
#			"/usr/bin/java -Xmx1g -jar \"${bev_dir}/BEViewer.jar\""
#		make_desktop_entry \
#			"beviewer" \
#			"BEViewer (bulk_extractor)" \
#			"${PN}" "Utility"
#	fi
}

#pkg_postinst() {
#	if use beviewer; then
#		xdg_icon_cache_update
#		xdg_desktop_database_update
#	fi
#}

#pkg_postrm() {
#	if use beviewer; then
#		xdg_icon_cache_update
#		xdg_desktop_database_update
#	fi
#}
