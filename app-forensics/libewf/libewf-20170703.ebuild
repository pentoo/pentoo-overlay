# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit versionator autotools python-r1

MY_DATE="$(get_version_component_range 1)"

DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="http://github.com/libyal/libewf/"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${MY_DATE}/${PN}-experimental-${MY_DATE}.tar.gz"

LICENSE="LGPL-3"
SLOT="0/3"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="debug ewf fuse python nls ssl unicode uuid zlib"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="mirror"

DEPEND="
	sys-libs/zlib
	fuse? ( sys-fs/fuse )
	uuid? ( || (
			>=sys-apps/util-linux-2.16
			<=sys-libs/e2fsprogs-libs-1.41.8
			sys-darwin/libsystem
		) )
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )
	nls? (
		virtual/libintl
		virtual/libiconv
	)
	dev-libs/libuna
	app-forensics/libbfio
	python? ( ${PYTHON_DEPS} )

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
	dev-libs/libbfio
	dev-libs/libcaes
	dev-libs/libodraw
	dev-libs/libsmraw

"
RDEPEND="${DEPEND}"

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

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local myconf=(
		$(use_enable debug debug-output)
		$(use_enable debug verbose-output)
		$(use_enable ewf v1-api)
		$(use_enable python)
		$(use_enable nls)
		$(use_with nls libiconv-prefix)
		$(use_with nls libintl-prefix)
		$(use_enable unicode wide-character-type)
		$(use_with zlib)
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

	econf ${myconf[@]}

}

