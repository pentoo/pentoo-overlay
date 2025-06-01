# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A set of high-level abstractions for Django forms"
HOMEPAGE="https://django-formtools.readthedocs.io/en/latest/ https://django-filter.readthedocs.org"
SRC_URI="https://github.com/jazzband/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # it's using tox

RDEPEND=">=dev-python/django-3.2[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}/${P}-fix-pyproject.patch"
)

distutils_enable_sphinx docs
