# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit python-r1

DESCRIPTION="Library for accessing Personal Folder Files"
HOMEPAGE="https://github.com/libyal/libpff"
#SRC_URI="https://github.com/libyal/libpff/archive/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="https://github.com/libyal/libpff/releases/download/20161119/libpff-experimental-20161119.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug nls python +threads unicode winapi"

DEPEND="app-forensics/libbfio
	dev-libs/libcdata
	dev-libs/libcerror
	dev-libs/libcfile
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libcpath
	dev-libs/libcsplit
	dev-libs/libcsystem
	dev-libs/libcthreads
	dev-libs/libfcache
	dev-libs/libfdata
	dev-libs/libfdatetime
	dev-libs/libfguid

	dev-libs/libfvalue
	dev-libs/libfwnt[winapi?,python?]
	dev-libs/libuna"

#https://github.com/libyal/libpff/issues/43
#	dev-libs/libfmapi

RDEPEND="${DEPEND}"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

CMAKE_IN_SOURCE_BUILD=1

src_configure() {

	local myconf=(
		$(use_enable python) \
		$(use_enable nls) \
		$(use_enable winapi) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output) \
		$(use_enable threads multi-threading-support) \
		$(use_enable unicode wide-character-type)

#		--with-libcdata --with-libcerror \
#		--with-libcnotify --with-libcthreads
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
