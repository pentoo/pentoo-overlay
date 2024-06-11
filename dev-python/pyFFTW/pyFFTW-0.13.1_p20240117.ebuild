# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

if [[ ${PV} == "9999" ]] ; then
	EGIT_BRANCH="master"
	EGIT_REPO_URI="https://github.com/pyFFTW/pyFFTW.git"
	inherit git-r3
else
	HASH_COMMIT="82ae9eafac5fdd411f38852a1d379bb013526460"

	SRC_URI="https://github.com/pyFFTW/pyFFTW/archive/${HASH_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="amd64 ~arm64 ~x86"
	S="${WORKDIR}"/${PN}-${HASH_COMMIT}
	PATCHES=( "${FILESDIR}/370_python312.patch" )

fi

DESCRIPTION="A pythonic python wrapper around FFTW"
HOMEPAGE="
	https://github.com/pyFFTW/pyFFTW/
	https://pypi.org/project/pyFFTW/
"

LICENSE="BSD"
SLOT="0"

DEPEND="
	>=dev-python/numpy-1.20[${PYTHON_USEDEP}]
	>=sci-libs/fftw-3.3:3.0=[threads]
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	>=dev-python/cython-3[${PYTHON_USEDEP}]
	test? (
		>=dev-python/dask-1.0[${PYTHON_USEDEP}]
		>=dev-python/scipy-1.8.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests unittest

src_configure() {
	# otherwise it'll start with -L/usr/lib, sigh
	export PYFFTW_INCLUDE_DIR="${EPREFIX}/usr/include"
	export PYFFTW_LIB_DIR="${EPREFIX}/usr/$(get_libdir)"
}

python_test() {
	cp -r -l -n tests/ "${BUILD_DIR}/lib" || die
	cd "${BUILD_DIR}/lib" || die
	eunittest
	rm -r tests/ || die
}
