# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1
DESCRIPTION="A flask application that allows for adding unittests.mock as view functions"
HOMEPAGE="https://github.com/threat9/threat9-test-bed"
SRC_URI="https://github.com/threat9/threat9-test-bed/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/faker[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	www-servers/gunicorn[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest
