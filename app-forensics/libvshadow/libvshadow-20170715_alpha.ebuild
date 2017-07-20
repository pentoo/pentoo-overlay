# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_{6,7} )
inherit versionator python-single-r1 autotools

MY_PV="$(get_major_version)"

DESCRIPTION="Library and tools to support the Volume Shadow Snapshot (VSS) format."
HOMEPAGE="https://github.com/libyal/libvshadow"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${MY_PV}/${PN}-alpha-${MY_PV}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug python nls unicode"

DEPEND="nls? (
	virtual/libintl
	virtual/libiconv
	)
	python? ( dev-lang/python )
	sys-fs/fuse
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
	sys-fs/fuse"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	epatch ${FILESDIR}/20170715-header.patch 
#	eautoreconf
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
