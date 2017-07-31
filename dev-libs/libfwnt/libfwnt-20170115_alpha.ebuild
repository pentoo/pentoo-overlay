# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit versionator python-r1

MY_PV="$(get_major_version)"
MY_PV2="$(get_after_major_version)"

DESCRIPTION="Library for Windows NT data types"
HOMEPAGE="https://github.com/libyal/${PN}"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${MY_PV}/${PN}-${MY_PV2}-${MY_PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="debug nls python +threads winapi"

DEPEND="dev-libs/libcdata
	dev-libs/libcerror
	dev-libs/libcnotify
	dev-libs/libcthreads"
RDEPEND="${DEPEND}"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

S="${WORKDIR}/${PN}-${MY_PV}"

CMAKE_IN_SOURCE_BUILD=1

src_configure() {

	local myconf=(
		$(use_enable python) \
		$(use_enable nls) \
		$(use_with nls libiconv-prefix) \
		$(use_with nls libintl-prefix) \
		$(use_enable debug debug-output) \
		$(use_enable debug verbose-output) \
		$(use_enable winapi) \
		$(use_enable threads multi-threading-support)
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
