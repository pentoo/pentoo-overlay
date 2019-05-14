# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils flag-o-matic gnome2-utils xdg-utils

DESCRIPTION="Scans a disk image for regular expressions and other content"
HOMEPAGE="https://github.com/simsong/bulk_extractor"
SRC_URI="http://digitalcorpora.org/downloads/bulk_extractor/${P}.tar.gz"
KEYWORDS="amd64 ~x86"
LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="0"
IUSE="aff doc +beviewer +exiv2 hashdb rar"

RDEPEND="
	aff? ( app-forensics/afflib )
	beviewer? ( virtual/jdk:* )
	dev-libs/boost[threads]
	dev-libs/expat
	dev-libs/openssl:0=
	dev-db/sqlite:3
	dev-libs/libxml2
	exiv2? ( >=media-gfx/exiv2-0.27.0 )
	sys-libs/zlib
	hashdb? ( >=dev-libs/hashdb-3.1.0 )"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	sys-devel/flex
	virtual/man
	virtual/pkgconfig"

src_prepare() {
	# Add support hashdb-3.1.0 for old bulk_extractor versions
	# https://github.com/NPS-DEEP/hashdb/wiki/hashdb-3.1.0-and-bulk_extractor
	use hashdb && \
		eapply "${FILESDIR}/${P}_hashdb-3.1.0_and_old_bulk_extractor.patch"

	# Using -I rather than -isystem for BOOST_CPPFLAGS
	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70129
	# Add exiv-0.27.0 support and other minor fixes...
	eapply "${FILESDIR}/add_exiv2-0.27_api_support.patch"
	eapply "${FILESDIR}/${P}_fix_call_of_overloaded_errors.patch"
	eapply "${FILESDIR}/${P}_other_minor_fixes.patch"

	eautoreconf
	eapply_user
}

src_configure() {
	append-cxxflags -std=c++11

	# null — is true for ./configure options
	econf \
		--without-o3 \
		--disable-libewf \
		$(use aff || echo "--disable-afflib") \
		$(use beviewer || echo "--disable-BEViewer") \
		$(use exiv2 && echo "--enable-exiv2") \
		$(use hashdb || echo "--disable-hashdb") \
		$(use rar || echo "--disable-rar" )
}

src_install() {
	dobin src/${PN} plugins/plugin_test
	doman man/*.1
	dodoc AUTHORS ChangeLog NEWS README

	if use doc ; then
		pushd doc/doxygen >/dev/null || die
		doxygen || die "doxygen failed"
		popd >/dev/null || die

		dodoc -r \
			doc/doxygen/html \
			doc/*.{pdf,txt,md}
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
