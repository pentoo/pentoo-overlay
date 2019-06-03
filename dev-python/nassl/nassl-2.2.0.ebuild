# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7} )
inherit eutils distutils-r1 flag-o-matic

#openssl system can be used optionally
#something to investigate in https://github.com/nabla-c0d3/sslyze/issues/101
#see tags in "build_tasks.py" file
MY_OPENSSL_MODERN="OpenSSL_1_1_1"
MY_OPENSSL_LEGACY="OpenSSL_1_0_2e"
MY_ZLIB="zlib-1.2.11"

DESCRIPTION="Experimental OpenSSL wrapper for Python 3.6+ and SSLyze"
HOMEPAGE="https://github.com/nabla-c0d3/nassl"
SRC_URI="https://github.com/nabla-c0d3/nassl/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/openssl/openssl/archive/${MY_OPENSSL_LEGACY}.zip -> openssl-${MY_OPENSSL_LEGACY}.zip
	https://github.com/openssl/openssl/archive/${MY_OPENSSL_MODERN}.zip -> openssl-${MY_OPENSSL_MODERN}.zip
	http://zlib.net/${MY_ZLIB}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/python-typing[${PYTHON_USEDEP}]
	dev-python/invoke[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare(){
	mkdir deps
	ln -s "${WORKDIR}/openssl-${MY_OPENSSL_LEGACY}" "${S}/deps"
	ln -s "${WORKDIR}/openssl-${MY_OPENSSL_MODERN}" "${S}/deps"
	ln -s "${WORKDIR}/${MY_ZLIB}" "${S}/deps"

	#https://github.com/nabla-c0d3/nassl/issues/42
	python3 /usr/bin/invoke build.zlib --do-not-clean
	python3 /usr/bin/invoke build.legacy-openssl --do-not-clean
	python3 /usr/bin/invoke build.modern-openssl --do-not-clean

	eapply_user
}
