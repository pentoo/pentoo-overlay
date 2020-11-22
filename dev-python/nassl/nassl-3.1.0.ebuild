# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

#openssl system can be used optionally
#something to investigate in https://github.com/nabla-c0d3/sslyze/issues/101
#see tags in "build_tasks.py" file
MY_OPENSSL_MODERN="OpenSSL_1_1_1h"
MY_OPENSSL_LEGACY="OpenSSL_1_0_2e"
MY_ZLIB="zlib-1.2.11"

DESCRIPTION="Experimental OpenSSL wrapper for Python 3.6+ and SSLyze"
HOMEPAGE="https://github.com/nabla-c0d3/nassl"
SRC_URI="https://github.com/nabla-c0d3/nassl/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/openssl/openssl/archive/${MY_OPENSSL_LEGACY}.zip -> openssl-${MY_OPENSSL_LEGACY}.zip
	https://github.com/openssl/openssl/archive/${MY_OPENSSL_MODERN}.zip -> openssl-${MY_OPENSSL_MODERN}.zip
	https://zlib.net/${MY_ZLIB}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/invoke[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	rm -r tests

	mkdir deps
	ln -s "${WORKDIR}/openssl-${MY_OPENSSL_LEGACY}" "${S}/deps"
	ln -s "${WORKDIR}/openssl-${MY_OPENSSL_MODERN}" "${S}/deps"
	ln -s "${WORKDIR}/${MY_ZLIB}" "${S}/deps"

	eapply_user
}

src_compile() {
	#https://github.com/nabla-c0d3/nassl/issues/42
	python3 /usr/bin/invoke build.zlib --do-not-clean
	python3 /usr/bin/invoke build.legacy-openssl --do-not-clean
	python3 /usr/bin/invoke build.modern-openssl --do-not-clean

	compile_python() {
		${EPYTHON} setup.py build_ext
		#https://github.com/nabla-c0d3/nassl/issues/63
		MAKEOPTS="${MAKEOPTS} -j1"
		distutils-r1_python_compile
	}
	python_foreach_impl compile_python
}
