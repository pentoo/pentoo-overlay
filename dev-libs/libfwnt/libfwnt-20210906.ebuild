# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )

inherit python-single-r1 autotools

DESCRIPTION="Library for Windows NT data types"
HOMEPAGE="https://github.com/libyal/libfwnt"
SRC_URI="https://github.com/libyal/libfwnt/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="debug nls python +threads"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="
	dev-libs/libcdata[nls=]
	dev-libs/libcerror[nls=]
	dev-libs/libcnotify[nls=]
	dev-libs/libcthreads[nls=]
	nls? (
		virtual/libiconv
		virtual/libintl
	)
	python? ( dev-lang/python:* )
"
RDEPEND="
	${DEPEND}
	python? ( ${PYTHON_DEPS} )
"

CMAKE_IN_SOURCE_BUILD=1

src_prepare() {
	# workaround for missing files in distribution package, see https://github.com/libyal/libfwnt/issues/12
	# should not be required any more in releases after 20220922
	cp "${FILESDIR}/2022-11-pyfwnt_test_access_control_entry.py" "${WORKDIR}/${P}/tests/pyfwnt_test_access_control_entry.py"
	cp "${FILESDIR}/2022-11-pyfwnt_test_access_control_list.py"  "${WORKDIR}/${P}/tests/pyfwnt_test_access_control_list.py"
	cp "${FILESDIR}/2022-11-pyfwnt_test_lzx.py"                  "${WORKDIR}/${P}/tests/pyfwnt_test_lzx.py"

	#makefile was created with 1.16, let's regenerate it
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable debug verbose-output) \
		$(use_enable debug debug-output) \
		$(use_enable threads multi-threading-support) \
		$(use_enable python) \
		$(use_enable python python3)

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
