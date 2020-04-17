# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit autotools eutils flag-o-matic python-r1

DESCRIPTION="A forensic copy program developed at and used by the NFI"
HOMEPAGE="https://sourceforge.net/projects/rdd/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

# no worky
RESTRICT="test"

BDEPEND="
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

RDEPEND="${PYTHON_DEPS}
	app-arch/bzip2:=
	app-forensics/libbfio:=
	app-forensics/libewf:=
	dev-libs/openssl:=
	dev-libs/libcfile:=
	dev-libs/libcpath:=
	dev-libs/libclocale:=
	dev-libs/libcsplit:=
	dev-libs/libfdata:=
	dev-libs/libfcache:=
	dev-libs/libfvalue:=
	dev-libs/libuna:=
	dev-libs/libfdatetime:=
	dev-libs/libfguid:=
	dev-libs/libfwnt:=
	dev-libs/libcdata:=
	dev-libs/libcnotify:=
	dev-libs/libcthreads:=
	dev-libs/libcerror:=
	sys-libs/zlib:="

DEPEND="${RDEPEND}"

# These are not linked against, not needed?
# Confirmed they are not required to build
PDEPEND="
	gnome-base/libglade:2.0
	x11-libs/gtk+:2"

PATCHES=(
	"${FILESDIR}/${P}-sandbox-fix.patch"
	"${FILESDIR}/${P}-libewf-warning.patch"
)

pkg_setup() {
	python_setup
}

src_prepare() {
	default

	sed -i 's/AM_PATH_GTK_2_0//' configure.ac || die
	#the following fixes cflags but breaks include path (the code is that bad)
	sed -i -e '/NFI_CFLAGS/d' configure.ac || die
	rm m4/nfi_cflags.m4 || die

	#libewf 2017 api fix
	sed -i 's/libewf_get_flags_write/libewf_get_access_flags_write/' src/ewfwriter.c || die
	sed -i 's/libewf_get_flags_read/libewf_get_access_flags_read/' src/ewfwriter.c || die
	sed -i 's/libewf_handle_set_segment_file_size/libewf_handle_set_maximum_segment_size/' src/ewfwriter.c || die
	sed -i 's/libewf_handle_get_segment_file_size/libewf_handle_get_maximum_segment_size/' src/ewfwriter.c || die
	sed -i 's/libewf_get_flags_read/libewf_get_access_flags_read/' test/tewfwriter.c || die
	sed -i 's/libewf_handle_get_segment_file_size/libewf_handle_get_maximum_segment_size/' test/tewfwriter.c || die

	python_fix_shebang "${S}"

	#fix include
	AT_M4DIR=m4 eautoreconf
}

src_configure() {
	append-cppflags -I "${S}/src"

	#doxygen-html fails but the docs are prebuilt so we don't need to enable them
	econf --disable-doxygen-html \
		$(use_enable debug tracing) \
		$(use_enable doc doxygen-doc)
}

src_compile() {
	emake -C src librdd.la
	emake
}

src_install() {
	default

	python_foreach_impl python_newscript src/rddi.py rddi
	dosym rdd-copy /usr/bin/rdd
	#go online if you want html
	#dohtml -r doxygen-doc/html/*
}
