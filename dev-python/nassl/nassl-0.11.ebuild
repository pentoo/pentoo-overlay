# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit  python-r1 python-utils-r1 flag-o-matic

DESCRIPTION="Experimental Python wrapper for OpenSSL"
HOMEPAGE="https://github.com/nabla-c0d3/nassl"
SRC_URI="https://github.com/nabla-c0d3/nassl/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/openssl
	sys-libs/zlib"
RDEPEND=""

#FIXME: python eclass must be used instead
src_prepare() {
	dodir "src/_nassl/openssl-internal"
	cp -r "${FILESDIR}/openssl-1.0.1i/" "${S}/src/_nassl/openssl-internal/"
	append-cflags -fno-strict-aliasing
	python2.7 setup_unix.py build
}

src_install() {
	MY_ARCH=$(uname -m)
	python_moduleinto nassl
	python_foreach_impl python_domodule "${S}/build/lib.linux-${MY_ARCH}-2.7/${PN}"/*
}
