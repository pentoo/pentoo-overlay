# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 multiprocessing

MY_OPENSSL_MODERN="OpenSSL_1_1_1w"
MY_OPENSSL_LEGACY="OpenSSL_1_0_2e"

DESCRIPTION="Experimental OpenSSL wrapper for Python 3.7+ and SSLyze"
HOMEPAGE="https://github.com/nabla-c0d3/nassl"
SRC_URI="https://github.com/nabla-c0d3/nassl/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/openssl/openssl/archive/${MY_OPENSSL_LEGACY}.tar.gz -> openssl-${MY_OPENSSL_LEGACY}.tar.gz
	https://github.com/openssl/openssl/archive/${MY_OPENSSL_MODERN}.tar.gz -> openssl-${MY_OPENSSL_MODERN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

#BDEPEND="app-arch/unzip"
DEPEND="${RDEPEND}
	>=dev-python/invoke-2.0.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	virtual/pkgconfig
	virtual/zlib"

PATCHES=( "${FILESDIR}/${PN}-5.4.0-system-zlib.patch" )

src_prepare() {
	rm -r tests || die

	mkdir deps || die
	ln -s "${WORKDIR}/openssl-${MY_OPENSSL_LEGACY}" "${S}/deps" || die
	ln -s "${WORKDIR}/openssl-${MY_OPENSSL_MODERN}" "${S}/deps" || die

	default

	sed -i "s|ctx\.run(\"make\")  # Only build|ctx.run(\"make -j$(makeopts_jobs)\")  # Only build|" \
		build_config.py || die
}

src_compile() {
	# FIXME: get rid of invoke and compile it using Gentoo env
	# https://github.com/nabla-c0d3/nassl/issues/42
	# invoke inherits the full environment; strip -Werror flags that break
	# the bundled OpenSSL 1.0.2e build with strict compilers (bug #1544)
	local -x CFLAGS="${CFLAGS//-Werror=implicit-function-declaration/}"
	local -x CFLAGS="${CFLAGS//-Werror=implicit-int/}"
	local -x CXXFLAGS="${CXXFLAGS//-Werror=implicit-function-declaration/}"
	local -x CXXFLAGS="${CXXFLAGS//-Werror=implicit-int/}"
	${EPYTHON} /usr/bin/invoke build.legacy-openssl --do-not-clean || die
	${EPYTHON} /usr/bin/invoke build.modern-openssl --do-not-clean || die
	distutils-r1_src_compile
}

python_compile() {
	MAKEOPTS="${MAKEOPTS} -j1"
	distutils-r1_python_compile build_ext
}
