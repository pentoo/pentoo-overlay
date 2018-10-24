# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6} )

inherit autotools python-r1

DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="https://github.com/libyal/libewf"
SRC_URI="https://github.com/libyal/libewf/releases/download/${PV}/${PN}-experimental-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0/3"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="bfio bzip2 debug ewf +fuse python nls +ssl static-libs +uuid unicode zlib"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	fuse? ( sys-fs/fuse:0= )
	nls? (
		virtual/libintl
		virtual/libiconv
	)
	uuid? ( sys-apps/util-linux )
	ssl? ( dev-libs/openssl:0= )
	zlib? ( sys-libs/zlib )
	python? ( ${PYTHON_DEPS} )

	dev-libs/libuna
	app-forensics/libbfio
	dev-libs/libcerror
	dev-libs/libcthreads
	dev-libs/libcdata
	dev-libs/libcdatetime
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libcsplit
	dev-libs/libuna
	dev-libs/libcfile
	dev-libs/libcpath
	dev-libs/libfcache
	dev-libs/libfdata
	dev-libs/libfguid
	dev-libs/libfvalue
	dev-libs/libsmdev
"
TOBE_ADDED="
	dev-libs/libcaes
	dev-libs/libodraw
	dev-libs/libsmraw

"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
"

# issues finding test executables
RESTRICT="test"

#https://github.com/libyal/libewf/issues/85
# dev-libs/libcfile must be with libsmdev

TEST="
   ADLER32 checksum support:                 zlib
   DEFLATE compression support:              zlib
   BZIP2 compression support:                bzip2
   libhmac support:                          local
   MD5 support:                              libcrypto_evp
   SHA1 support:                             libcrypto_evp
   SHA256 support:                           libcrypto_evp
   AES support:                              libcrypto_evp
"

AUTOTOOLS_IN_SOURCE_BUILD=1

DOCS=( AUTHORS ChangeLog NEWS README )

src_configure() {
	local econfargs=(
		$(use_enable static-libs static)
		$(use_enable nls)
		$(use_enable debug verbose-output)
		$(use_enable debug debug-output)
		$(use_enable python)
		$(use_with nls libiconv-prefix)
		$(use_with nls libintl-prefix)
		$(use_enable unicode wide-character-type)
		$(use_with bfio libbfio)
		$(use_with zlib)
		$(use_with bzip2)
		$(use_with ssl openssl)
		$(use_with uuid libuuid)
		$(use_with fuse libfuse)
	)

	if use python ; then
		#todo: make python2 optional
		myconf+=( --enable-python2 )
		prepare_python() {
			if python_is_python3; then
				myconf+=( --enable-python3 )
			fi
		}
		python_foreach_impl run_in_build_dir prepare_python
	fi

	econf "${econfargs[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}"/usr -name '*.la' -delete
}
