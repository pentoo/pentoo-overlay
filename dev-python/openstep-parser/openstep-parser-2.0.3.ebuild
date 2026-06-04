# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="OpenStep plist reader into python objects"
HOMEPAGE="https://github.com/kronenthaler/openstep-parser"
SRC_URI="https://github.com/kronenthaler/openstep-parser/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

distutils_enable_tests pytest
