# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Implementation of per object permissions for Django 1.2+"
HOMEPAGE="https://github.com/django-guardian/django-guardian"
SRC_URI="https://github.com/${PN}/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/django-3.2[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	test? (
		>=dev-python/django-environ-0.12.0[${PYTHON_USEDEP}]
		>=dev-python/mock-5.1.0[${PYTHON_USEDEP}]
		>=dev-python/pytest-django-4.9.0[${PYTHON_USEDEP}]
	)
"

# it's using mkdoc, FIXME
#distutils_enable_sphinx docs dev-python/sphinx-rtd-theme
distutils_enable_tests pytest
