# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils

# no worky
RESTRICT="test"

DESCRIPTION="Rdd is a forensic copy program"
HOMEPAGE="http://www.sf.net/projects/rdd"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

KEYWORDS="~x86 ~amd64"
IUSE="debug doc"
LICENSE="BSD"
SLOT="0"

RDEPEND=">=app-forensics/libewf-20170701
	x11-libs/gtk+:2
	gnome-base/libglade:2.0"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_prepare() {
	epatch "${FILESDIR}/rdd-3.0.4-sandbox-fix.patch"
	sed -i 's/AM_PATH_GTK_2_0//' configure.ac || die

	#libewf 2017 api fix
	sed -i 's/libewf_get_flags_write/libewf_get_access_flags_write/' src/ewfwriter.c || die
	sed -i 's/libewf_get_flags_read/libewf_get_access_flags_read/' src/ewfwriter.c || die
	sed -i 's/libewf_handle_set_segment_file_size/libewf_handle_set_maximum_segment_size/' src/ewfwriter.c || die
	sed -i 's/libewf_handle_get_segment_file_size/libewf_handle_get_maximum_segment_size/' src/ewfwriter.c || die
	sed -i 's/libewf_get_flags_read/libewf_get_access_flags_read/' test/tewfwriter.c || die
	sed -i 's/libewf_handle_get_segment_file_size/libewf_handle_get_maximum_segment_size/' test/tewfwriter.c || die

	eapply_user
	AT_M4DIR=m4 eautoreconf
}

src_configure() {
	#doxygen-html fails but the docs are prebuilt so we don't need to enable them
	econf --disable-doxygen-html \
		$(use_enable debug tracing) \
		$(use_enable doc doxygen-doc)
}

src_compile() {
	emake -j1
}

src_install() {
	emake install DESTDIR="${D}"
	dobin src/rddi.py
	dosym rdd-copy /usr/bin/rdd
	#this causes a warning about not being recursive, no clue why
	dohtml -r doxygen-doc/html/*
}
