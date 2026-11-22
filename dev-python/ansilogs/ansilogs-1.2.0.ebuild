# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_VERIFY_REPO=https://github.com/doronz88/ansilogs

inherit distutils-r1 pypi

DESCRIPTION="Colored, single-line log output for command-line tools"
HOMEPAGE="
	https://pypi.org/project/ansilogs/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

#RDEPEND="
#"
#BDEPEND="
#	test? (
#	)
#"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
