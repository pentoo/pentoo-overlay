# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Whois querying and parsing of domain registration information"
HOMEPAGE="https://github.com/richardpenman/pywhois"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RESTRICT="test"

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
