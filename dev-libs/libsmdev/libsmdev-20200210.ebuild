# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit autotools python-r1

DESCRIPTION="Library to access to storage media device"
HOMEPAGE="https://github.com/libyal/${PN}"
SRC_URI="https://github.com/libyal/${PN}/releases/download/${PV}/${PN}-alpha-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="nls unicode python +threads"

DEPEND="python? ( ${PYTHON_DEPS} )
	dev-libs/libcdata
	dev-libs/libcerror
	dev-libs/libcfile
	dev-libs/libclocale
	dev-libs/libcnotify
	dev-libs/libcthreads
	dev-libs/libuna
	"

RDEPEND="${DEPEND}"

pkg_setup() {
	if use python; then
		python_setup
	fi
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
#	econf $(use_enable nls) \
	local myconf=(
		$(use_with nls libiconv-prefix)
		$(use_with nls libintl-prefix)
		$(use_enable unicode wide-character-type)
		$(use_enable threads multi-threading-support)
	)

	if use python ; then
		prepare_python() {
			if python_is_python3; then
				myconf+=( --enable-python3 )
			fi
		}
		python_foreach_impl run_in_build_dir prepare_python
	fi

	econf ${myconf[@]}
}
