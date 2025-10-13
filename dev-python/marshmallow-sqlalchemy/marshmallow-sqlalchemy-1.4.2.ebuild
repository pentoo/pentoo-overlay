# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=(  python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="SQLAlchemy integration with the marshmallow (de)serialization library"
HOMEPAGE="https://github.com/marshmallow-code/marshmallow-sqlalchemy"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	<dev-python/sqlalchemy-3.0[${PYTHON_USEDEP}]
	>=dev-python/marshmallow-3.18.0[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-1.4.40[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	test? (
		dev-python/pytest-lazy-fixtures[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
