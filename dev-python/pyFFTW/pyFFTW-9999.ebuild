# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
#wait for the fix: https://github.com/pyFFTW/pyFFTW/issues/372
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1

if [[ ${PV} == "9999" ]] ; then
	EGIT_BRANCH="master"
	#lock to a current commit temporary until python 3.12 patch is merged
#	EGIT_OVERRIDE_COMMIT_PYFFTW_PYFFTW="82ae9eafac5fdd411f38852a1d379bb013526460"
	EGIT_REPO_URI="https://github.com/pyFFTW/pyFFTW.git"
	inherit git-r3
#	PATCHES=( "{FILESDIR}/370_python312.patch" )
else
	PYPI_NO_NORMALIZE=1
	inherit pypi
	KEYWORDS="amd64 ~arm64 ~x86"
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
