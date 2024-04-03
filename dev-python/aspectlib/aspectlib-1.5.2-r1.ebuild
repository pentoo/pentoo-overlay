# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

MY_PN="python-${PN}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Aspect-oriented programming, monkey-patch and decorators library"
HOMEPAGE="https://github.com/ionelmc/python-aspectlib"
SRC_URI="https://github.com/ionelmc/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.gh.tar.gz"

S="${WORKDIR}/${MY_P}"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # fails with current tornado version

RDEPEND="dev-python/fields[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/process-tests[${PYTHON_USEDEP}]
		dev-python/tornado[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
