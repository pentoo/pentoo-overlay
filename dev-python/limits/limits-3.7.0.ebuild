# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Rate limiting utilities"
HOMEPAGE="https://limits.readthedocs.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
RESTRICT="test"

#FIXME: review deps
RDEPEND="
	dev-python/deprecated[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
