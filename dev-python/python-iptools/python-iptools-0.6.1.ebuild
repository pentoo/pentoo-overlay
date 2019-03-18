# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/bd808/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

DESCRIPTION="A package is a collection of utilities for dealing with IP addresses"
HOMEPAGE="https://github.com/bd808/python-iptools"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
