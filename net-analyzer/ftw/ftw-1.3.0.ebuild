# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Framework for Testing WAFs"
HOMEPAGE="https://github.com/coreruleset/ftw"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"

RDEPEND="
	>=app-arch/brotli-1.0.9[python,${PYTHON_USEDEP}]
	>=dev-python/ipy-1.01[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.8.2[${PYTHON_USEDEP}]"
#	>=dev-python/pytest-6.2.5[${PYTHON_USEDEP}]
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

distutils_enable_tests pytest
