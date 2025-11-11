# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A basic implementation of the __geo_interface__"
HOMEPAGE="https://pypi.org/project/pygeoif/"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # the tests are using a deprecated Python function
