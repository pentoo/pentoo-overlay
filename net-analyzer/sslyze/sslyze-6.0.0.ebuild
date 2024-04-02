# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
inherit distutils-r1

DESCRIPTION="Fast and full-featured SSL scanner"
HOMEPAGE="https://github.com/nabla-c0d3/sslyze"
SRC_URI="https://github.com/nabla-c0d3/sslyze/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

IUSE="test"

RDEPEND=">=dev-python/nassl-5.1.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-42.0.0[${PYTHON_USEDEP}]
	>=dev-python/tls_parser-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.2[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
BDEPEND="test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/Faker[${PYTHON_USEDEP}]
	)"

#It takes really long, so be patient
distutils_enable_tests pytest
