# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit  distutils-r1 flag-o-matic

#something to investigate in https://github.com/nabla-c0d3/sslyze/issues/101
#can system packages be used?
MY_COMMIT="1f5878b8e25a785dde330bf485e6ed5a6ae09a1a"
MY_OPENSSL_LEGACY="openssl-1.0.2e"
MY_ZLIB="zlib-1.2.11"

DESCRIPTION="Experimental Python wrapper for OpenSSL"
HOMEPAGE="https://github.com/nabla-c0d3/nassl"
SRC_URI="https://github.com/nabla-c0d3/nassl/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/openssl/openssl/archive/${MY_COMMIT}.zip -> openssl-${MY_COMMIT}.zip
	https://ftp.openssl.org/source/old/1.0.2/${MY_OPENSSL_LEGACY}.tar.gz
	http://zlib.net/${MY_ZLIB}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/python-typing
	virtual/python-enum34"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare(){
	ln -s "${WORKDIR}/${MY_OPENSSL_LEGACY}" "${S}"/
	ln -s "${WORKDIR}/${MY_ZLIB}" "${S}/"
	ln -s "${WORKDIR}/openssl-${MY_COMMIT}" "${S}"/openssl-master
	./build_from_scratch.py
	eapply_user
}

distutils-r1_python_compile() {
	append-cflags -fno-strict-aliasing
	append-ldflags -Wl,-z,noexecstack
	esetup.py build
}
