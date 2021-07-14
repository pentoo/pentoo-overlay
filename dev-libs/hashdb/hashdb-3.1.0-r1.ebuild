# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit autotools flag-o-matic python-single-r1

DESCRIPTION="The hashdb block hash database tool and API"
HOMEPAGE="https://github.com/NPS-DEEP/hashdb"
SRC_URI="https://github.com/NPS-DEEP/hashdb/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~hppa ~ppc ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
LICENSE="GPL-3 public-domain"
SLOT="0"

IUSE="python static-libs test"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	app-forensics/libewf
	dev-libs/icu
	dev-libs/openssl:0=
	python? ( ${PYTHON_DEPS} )
	sys-libs/zlib"

DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	sys-devel/libtool
	test? (
		dev-util/valgrind
		$(python_gen_cond_dep 'dev-python/matplotlib[${PYTHON_MULTI_USEDEP}]')
	)"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	eapply "${FILESDIR}"/fix_undefined_reference_to_libewf_handle_read_random.patch

	# https://github.com/NPS-DEEP/hashdb/issues/6
	if has_version ">=dev-libs/openssl-1.1.0"; then
		eapply "${FILESDIR}"/fix_configure_openssl-1.1.0_detection.patch
	fi

	python_fix_shebang "${S}"

	eautoreconf
	default
}

src_configure() {
	append-cxxflags -std=c++11
	econf \
		$(use_enable python SWIG_Python) \
		$(use_enable static-libs static)
}

src_test() {
	pushd test/ >/dev/null || die
	./memory_analysis.sh || die
	popd >/dev/null || die

	emake -j1 check
}

src_install() {
	default
	find "${D}" -name '*.la' -delete || die

	if use python && ! use static-libs; then
		rm -f "${D}$(python_get_sitedir)"/*.a || die
	fi
}
