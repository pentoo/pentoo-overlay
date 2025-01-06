# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} pypy3 )

inherit distutils-r1

DESCRIPTION="GPX file parser and GPS track manipulation library"
HOMEPAGE="
	https://github.com/tkrajina/gpxpy
	https://pypi.org/project/gpxpy/
"
SRC_URI="https://github.com/tkrajina/gpxpy/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

KEYWORDS="amd64 ~arm64 ~x86"
LICENSE="Apache-2.0"
SLOT="0"

distutils_enable_tests unittest
