# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="A very simple, yet powerful, Django captcha application"
HOMEPAGE="https://github.com/mbi/django-simple-captcha https://django-filter.readthedocs.org"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="
	>=dev-python/django-4.2[${PYTHON_USEDEP}]
	>=dev-python/pillow-6.2.0[${PYTHON_USEDEP}]
	>=dev-python/django-ranged-response-0.2.0[${PYTHON_USEDEP}]
	!dev-python/captcha"
DEPEND="${RDEPEND}"
