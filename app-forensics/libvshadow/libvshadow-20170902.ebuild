# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#FIXME: add python3 support
PYTHON_COMPAT=( python2_{6,7} )
inherit python-single-r1

DESCRIPTION="Library and tools to support the Volume Shadow Snapshot (VSS) format."
HOMEPAGE="https://github.com/libyal/libvshadow"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug python nls unicode"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="nls? (
	virtual/libintl
	virtual/libiconv
	)
	python? ( dev-lang/python:* )
	sys-fs/fuse:*
	app-forensics/libbfio

	dev-libs/libcdata
	dev-libs/libcerror
	dev-libs/libcfile
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libcpath
	dev-libs/libcsplit
	dev-libs/libcthreads
	dev-libs/libfdatetime
	dev-libs/libfguid
	dev-libs/libuna
"

RDEPEND="${DEPEND}
	python? ( ${PYTHON_DEPS} )
	sys-fs/fuse"

src_prepare() {
	#https://github.com/libyal/libcthreads/issues/6
	#sed -i -e '/libcerror\/Makefile/d' configure.ac
	#sed -i -e '/libcerror/d' Makefile.am

	#workaround, see https://github.com/libyal/libvshadow/issues/10
	echo "#define HAVE_ERRNO_H 1" >> common/config.h.in

	eapply_user
}

src_configure() {
	econf $(use_enable python) \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable unicode wide-character-type) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output) \
		--with-libcdata --with-libcerror --with-libcfile \
		--with-libclocale --with-libcnotify --with-libcpath \
		--with-libcsplit --with-libcthreads --with-libfdatetime \
		--with-libfguid --with-libuna
}
