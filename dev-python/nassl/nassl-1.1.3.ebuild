# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
inherit  distutils-r1 flag-o-matic

DESCRIPTION="Experimental Python wrapper for OpenSSL"
HOMEPAGE="https://github.com/nabla-c0d3/nassl"
#SRC_URI="https://github.com/nabla-c0d3/nassl/archive/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="http://dev.pentoo.ch/~blshkv/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#typing; python_version < '3.5'
#enum34; python_version < '3.4'
RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
  #dev-python/pipenv

distutils-r1_python_compile() {
	append-cflags -fno-strict-aliasing
	append-ldflags -Wl,-z,noexecstack
	esetup.py build
}
