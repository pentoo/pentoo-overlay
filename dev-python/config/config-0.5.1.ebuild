# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A hierarchical, easy-to-use, powerful configuration module for Python"
HOMEPAGE="https://docs.red-dove.com/cfg/python.html"
SRC_URI="https://github.com/vsajip/py-cfg-lib/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/py-cfg-lib-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

python_test() {
	"${EPYTHON}" test_config.py || die "Tests failed with ${EPYTHON}"
}
