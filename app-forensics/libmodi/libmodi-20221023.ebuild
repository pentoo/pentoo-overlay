# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit autotools python-single-r1

DESCRIPTION="Library and tools to access the Mac OS disk image formats"
HOMEPAGE="https://github.com/libyal/libmodi"
SRC_URI="https://github.com/libyal/libmodi/releases/download/${PV}/${PN}-experimental-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="nls unicode python +fuse +threads debug"

REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
"

DEPEND="
	nls? (
		virtual/libiconv
		virtual/libintl
	)
	python? ( dev-lang/python:* )
	app-forensics/libbfio[nls=,unicode=,threads=]
	dev-libs/libcaes[nls=,python=]
	dev-libs/libcdata[nls=]
	dev-libs/libcdirectory[nls=,unicode=]
	dev-libs/libcerror[nls=]
	dev-libs/libcfile[nls=,unicode=]
	dev-libs/libclocale[nls=,unicode=]
	dev-libs/libcnotify[nls=]
	dev-libs/libcpath[nls=,unicode=]
	dev-libs/libcsplit[nls=,unicode=]
	dev-libs/libcthreads[nls=]
	dev-libs/libfcache[nls=]
	dev-libs/libfdata[nls=,threads=]
	dev-libs/libfguid[nls=]
	dev-libs/libfmos[nls=,threads=,python=]
	dev-libs/libfplist[nls=,threads=]
	dev-libs/libfvalue[nls=]
	dev-libs/libhmac[nls=,unicode=,threads=]
	dev-libs/libuna[nls=,unicode=]
	sys-libs/zlib
	dev-libs/openssl
	app-arch/bzip2
	app-arch/xz-utils
"
# app-arch/xz-utils provides liblzma
RDEPEND="
	${DEPEND}
	python? ( ${PYTHON_DEPS} )
	fuse? ( sys-fs/fuse )
"

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable unicode wide-character-type) \
		$(use_enable debug verbose-output ) \
		$(use_enable debug debug-output ) \
		$(use_enable threads multi-threading-support) \
		$(use_enable python) \
		$(use_enable python python3) \
		$(use_with fuse libfuse) \

}

src_install() {
	default
	# see https://projects.gentoo.org/qa/policy-guide/installed-files.html#pg0303
	find "${ED}" -name '*.la' -delete || die
}
