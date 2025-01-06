# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Small library to parse TLS records."
HOMEPAGE="https://github.com/nabla-c0d3/tls_parser"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"

DEPEND="${RDEPEND}
	test? ( dev-python/pytest )"

distutils_enable_tests pytest
