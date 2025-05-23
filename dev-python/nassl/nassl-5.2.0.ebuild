# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 multiprocessing

# openssl system can be used optionally
# something to investigate in https://github.com/nabla-c0d3/sslyze/issues/101
# see tags in "build_tasks.py" file
MY_OPENSSL_MODERN="OpenSSL_1_1_1t"
MY_OPENSSL_LEGACY="OpenSSL_1_0_2e"
MY_ZLIB="zlib-1.2.13"

DESCRIPTION="Experimental OpenSSL wrapper for Python 3.7+ and SSLyze"
HOMEPAGE="https://github.com/nabla-c0d3/nassl"
SRC_URI="https://github.com/nabla-c0d3/nassl/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/openssl/openssl/archive/${MY_OPENSSL_LEGACY}.tar.gz -> openssl-${MY_OPENSSL_LEGACY}.tar.gz
	https://github.com/openssl/openssl/archive/${MY_OPENSSL_MODERN}.tar.gz -> openssl-${MY_OPENSSL_MODERN}.tar.gz
	https://zlib.net/${MY_ZLIB}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

#BDEPEND="app-arch/unzip"
DEPEND="${RDEPEND}
	>=dev-python/invoke-2.0.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	rm -r tests

	mkdir deps
	ln -s "${WORKDIR}/openssl-${MY_OPENSSL_LEGACY}" "${S}/deps"
	ln -s "${WORKDIR}/openssl-${MY_OPENSSL_MODERN}" "${S}/deps"
	ln -s "${WORKDIR}/${MY_ZLIB}" "${S}/deps"

	sed -i "s|ctx.run(\"make\")|ctx.run\(\"make -j$(makeopts_jobs)\"\)|g" build_tasks.py
	eapply_user
}

src_compile() {
	# FIXME: get rid of invoke and compile it using Gentoo env
	# https://github.com/nabla-c0d3/nassl/issues/42
	${EPYTHON} /usr/bin/invoke build.zlib --do-not-clean
	${EPYTHON} /usr/bin/invoke build.legacy-openssl --do-not-clean
	${EPYTHON} /usr/bin/invoke build.modern-openssl --do-not-clean
	distutils-r1_src_compile
}

python_compile() {
	MAKEOPTS="${MAKEOPTS} -j1"
	distutils-r1_python_compile build_ext
}
