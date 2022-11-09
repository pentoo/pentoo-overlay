# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..11} )
inherit python-single-r1 eutils autotools

DESCRIPTION="Library and tools to support the Volume Shadow Snapshot (VSS) format."
HOMEPAGE="https://github.com/libyal/libvshadow"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#unicode: https://github.com/libyal/libvshadow/issues/17
IUSE="debug python nls unicode"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="nls? ( virtual/libintl
		virtual/libiconv
	)
	python? ( dev-lang/python:* )
	sys-fs/fuse:*
	app-forensics/libbfio

	>=dev-libs/libcdata-20190112
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
	#upstream does not support its own shared libraries, let's fix that
	eapply "${FILESDIR}/${PN}"_2019_autoconfig.patch

	#workaround, see https://github.com/libyal/libvshadow/issues/10
#	echo "#define HAVE_ERRNO_H 1" >> common/config.h.in

	#makefile was created with 1.16, let's regenerate it
	eautoreconf
	eapply_user
}

src_configure() {
	econf $(use_enable python) \
		$(use_enable python python3) \
		$(use_enable unicode wide-character-type) \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output)
# \
#		--with-libcdata --with-libcerror --with-libcfile \
#		--with-libclocale --with-libcnotify --with-libcpath \
#		--with-libcsplit --with-libcthreads --with-libfdatetime \
#		--with-libfguid --with-libuna
}
