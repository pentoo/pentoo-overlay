# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=(python3_{7..9} )

inherit distutils-r1

DESCRIPTION="A streaming multipart parser for Python"
HOMEPAGE="
	https://andrew-d.github.io/python-multipart
	https://github.com/andrew-d/python-multipart"
SRC_URI="https://github.com/andrew-d/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# RuntimeError: Unsafe load() call disabled by Gentoo. See bug #659348
RESTRICT="test"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"

DEPEND="test? ( dev-python/pyyaml[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

distutils_enable_sphinx docs/source dev-python/sphinx-bootstrap-theme
