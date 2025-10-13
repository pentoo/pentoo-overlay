# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="A set of high-level abstractions for Django forms"
HOMEPAGE="https://django-formtools.readthedocs.io/en/latest/ https://django-filter.readthedocs.org"
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # it's using tox

RDEPEND=">=dev-python/django-4.2[${PYTHON_USEDEP}]"

distutils_enable_sphinx docs
