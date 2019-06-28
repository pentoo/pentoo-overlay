# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils git-r3 gnome2-utils xdg-utils

DESCRIPTION="Scans a disk image for regular expressions and other content"
HOMEPAGE="https://github.com/simsong/bulk_extractor"

# Please check a ".gitmodules" file on upstream before bump it
EGIT_REPO_URI="https://github.com/simsong/bulk_extractor"
if [[ ${PV} != *9999 ]]; then
	#EGIT_COMMIT="${PV}"
	EGIT_COMMIT="7457af0666b3c3808c2dd3dd72e9ac7bbac8fa4c" # 20190628
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="aff doc +beviewer +ewf +exiv2 hashdb rar"

RDEPEND="
	aff? ( app-forensics/afflib )
	beviewer? ( virtual/jdk:* )
	dev-libs/boost[threads]
	dev-libs/expat
	dev-libs/openssl:0=
	dev-db/sqlite:3
	dev-libs/libxml2
	ewf? ( app-forensics/libewf )
	exiv2? ( >=media-gfx/exiv2-0.27.0 )
	sys-libs/zlib
	hashdb? ( >=dev-libs/hashdb-3.1.0 )"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	sys-devel/flex
	virtual/man
	virtual/pkgconfig"

src_prepare() {
	eapply "${FILESDIR}/add_exiv2-0.27_api_support.patch"

	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		--without-o3 \
		$(use aff || echo "--disable-afflib") \
		$(use beviewer || echo "--disable-BEViewer") \
		$(use ewf || echo "--disable-libewf") \
		$(use exiv2 && echo "--enable-exiv2") \
		$(use hashdb || echo "--disable-hashdb") \
		$(use rar || echo "--disable-rar" )
}

src_install() {
	dobin src/${PN} plugins/plugin_test
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

	if use beviewer; then
		local bev_dir="/opt/beviewer-${PV}"

		insinto "${bev_dir}"
		doins java_gui/BEViewer.jar

		insinto /usr/share/pixmaps
		newins java_gui/icons/24/run-build-install.png ${PN}.png

		make_wrapper "beviewer" \
			"/usr/bin/java -Xmx1g -jar \"${bev_dir}/BEViewer.jar\""
		make_desktop_entry \
			"beviewer" \
			"BEViewer (bulk_extractor)" \
			"${PN}" "Utility"
	fi
}

pkg_preinst() {
	use beviewer && gnome2_icon_savelist
}

pkg_postinst() {
	if use beviewer; then
		xdg_desktop_database_update
		gnome2_icon_cache_update
	fi
}

pkg_postrm() {
	if use beviewer; then
		xdg_desktop_database_update
		gnome2_icon_cache_update
	fi
}
