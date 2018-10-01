# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6} )
inherit eutils distutils-r1 flag-o-matic

#something to investigate in https://github.com/nabla-c0d3/sslyze/issues/101
#can system packages be used?
MY_OPENSSL_MODERN="OpenSSL_1_1_1"
MY_OPENSSL_LEGACY="OpenSSL_1_0_2e"
MY_ZLIB="zlib-1.2.11"

DESCRIPTION="Experimental Python wrapper for OpenSSL"
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
	virtual/python-enum34[${PYTHON_USEDEP}]
	dev-python/invoke[${PYTHON_USEDEP}]"
#test? pytest
#mypy
#flake8

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
