# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Access zip file content hosted remotely without downloading the full file."
HOMEPAGE="https://github.com/gtsystem/python-remotezip"
SRC_URI="https://github.com/gtsystem/python-remotezip/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/python-${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
"

BDEPEND="
	${RDEPEND}
	test? (
		dev-python/requests-mock
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
