# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 eutils

DESCRIPTION="Python bidings for TRE library"
HOMEPAGE="http://laurikari.net/tre/ https://github.com/laurikari/tre/"
SRC_URI="http://laurikari.net/tre/tre-${PV}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"

RDEPEND="dev-libs/tre"
DEPEND="${RDEPEND}"

S="${WORKDIR}/tre-${PV}/python"

python_prepare() {
	epatch "${FILESDIR}"/${PV}-python.patch
}
