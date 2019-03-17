# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit autotools flag-o-matic python-single-r1

DESCRIPTION="The hashdb block hash database tool and API"
HOMEPAGE="https://github.com/NPS-DEEP/hashdb"
SRC_URI="https://github.com/NPS-DEEP/hashdb/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~hppa ~ppc ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos"
LICENSE="Unlicense"
RESTRICT="mirror"
SLOT="0"
IUSE="python static-libs"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	app-forensics/libewf
	dev-libs/icu
	dev-libs/openssl:0=
	python? ( ${PYTHON_DEPS} )
	sys-libs/zlib"

DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	sys-devel/libtool"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_prepare() {
	eapply "${FILESDIR}"/fix_undefined_reference_to_libewf_handle_read_random.patch

	eautoreconf
	eapply_user
}

src_configure() {
	append-cxxflags -std=c++11
	econf \
		--without-o3 \
		$(use_enable python SWIG_Python) \
		$(use_enable static-libs static)
}

src_install() {
	default

	if use python; then
		rm -f "${D%/}$(python_get_sitedir)"/*.a || die
	fi
	if ! use static-libs; then
		find "${D}" -name '*.la' -delete || die
	fi
}
