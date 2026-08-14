# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit python-single-r1

DESCRIPTION="Library and tools to access the Apple Partition Map (APM) volume system format"
HOMEPAGE="https://github.com/libyal/libvsapm"
SRC_URI="https://github.com/libyal/libvsapm/releases/download/${PV}/libvsapm-experimental-${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="debug python +threads"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="
	app-forensics/libbfio
	dev-libs/libcdata
	dev-libs/libcerror
	dev-libs/libcfile
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libcpath
	dev-libs/libcsplit
	dev-libs/libcthreads
	dev-libs/libfcache
	dev-libs/libfdata
	dev-libs/libuna
	python? ( dev-lang/python:* )
"
RDEPEND="
	${DEPEND}
	python? ( ${PYTHON_DEPS} )
"

src_configure() {
	econf \
		$(use_enable debug verbose-output) \
		$(use_enable debug debug-output) \
		$(use_enable threads multi-threading-support) \
		$(use_enable python)

#  --disable-shared-libs   disable shared library support
# not supported in the ebuild at the moment - kind of defeats the entire process

#  --enable-winapi         enable WINAPI support for cross-compilation
#                          [default=auto-detect]
# not supported in the ebuild at the moment - requires windows.h, does not make much sense for us
}

src_install() {
	default
	# see https://projects.gentoo.org/qa/policy-guide/installed-files.html#pg0303
	find "${ED}" -name '*.la' -delete || die
}
