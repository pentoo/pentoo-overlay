# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
inherit autotools python-single-r1

DESCRIPTION="Library to access the Windows Shell Item format"
HOMEPAGE="https://github.com/libyal/libfwsi"
SRC_URI="https://github.com/libyal/libfwsi/releases/download/${PV}/${PN}-experimental-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="nls python +threads debug"

REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
"

DEPEND="
	nls? (
		virtual/libiconv
		virtual/libintl
	)
	python? ( dev-lang/python:* )
	dev-libs/libcdata[nls=]
	dev-libs/libcerror[nls=]
	dev-libs/libclocale[nls=]
	dev-libs/libcnotify[nls=]
	dev-libs/libcthreads[nls=]
	dev-libs/libfdatetime[nls=]
	dev-libs/libfguid[nls=]
	dev-libs/libfole[nls=]
	dev-libs/libfwps[nls=,threads=,python=]
	dev-libs/libuna[nls=]
"
RDEPEND="
	${DEPEND}
	python? ( ${PYTHON_DEPS} )
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
		$(use_enable debug verbose-output ) \
		$(use_enable debug debug-output ) \
		$(use_enable threads multi-threading-support) \
		$(use_enable python) \
		$(use_enable python python3) \

}

src_install() {
	default
	# see https://projects.gentoo.org/qa/policy-guide/installed-files.html#pg0303
	find "${ED}" -name '*.la' -delete || die
}
