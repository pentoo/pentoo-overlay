# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit autotools python-single-r1

DESCRIPTION="Library and tools to access the VMware Virtual Disk (VMDK) format"
HOMEPAGE="https://github.com/libyal/libvmdk"

MY_PV="${PV%_alpha}"
SRC_URI="https://github.com/libyal/libvmdk/releases/download/${MY_PV}/libvmdk-alpha-${MY_PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="amd64 ~arm64 x86"
LICENSE="LGPL-3"
SLOT="0"
IUSE="debug +fuse unicode python nls static static-libs +threads"

REQUIRED_USE="
	static? ( static-libs )
	python? ( ${PYTHON_REQUIRED_USE} )
"

DEPEND="
	app-forensics/libbfio[nls=,unicode=]
	dev-libs/libcdata[nls=]
	dev-libs/libcerror[nls=]
	dev-libs/libcfile[nls=,unicode=]
	dev-libs/libclocale[nls=,unicode=]
	dev-libs/libcnotify[nls=]
	dev-libs/libcpath[nls=,unicode=]
	dev-libs/libcsplit[nls=,unicode=]
	dev-libs/libcthreads[nls=]
	dev-libs/libfcache[nls=]
	dev-libs/libfdata[nls=]
	dev-libs/libfguid[nls=]
	dev-libs/libfvalue[nls=]
	dev-libs/libuna[nls=,unicode=]
	nls? (
		virtual/libiconv
		virtual/libintl
	)
	python? ( dev-lang/python:* )
	sys-libs/zlib
"
RDEPEND="
	${DEPEND}
	python? ( ${PYTHON_DEPS} )
	fuse? ( sys-fs/fuse:0=[static-libs?] )
"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}"/${PN}-${MY_PV}

src_prepare() {
	#makefile was created with 1.16, let's regenerate it
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable static-libs static) \
		$(use_enable static static-executables) \
		$(use_enable unicode wide-character-type) \
		$(use_enable debug verbose-output ) \
		$(use_enable debug debug-output ) \
		$(use_enable threads multi-threading-support) \
		$(use_enable python) \
		$(use_enable python python3) \
		$(use_with fuse libfuse)

# static-libs is not yet implemented in any other libyal package in Pentoo,
# but it is in Gentoo main...

#  --disable-shared-libs   disable shared library support
# not supported in the ebuild at the moment - kind of defeats the entire process

#  --enable-winapi         enable WINAPI support for cross-compilation
#                          [default=auto-detect]
# not supported in the ebuild at the moment - requires windows.h, does not make much sense for us
}
