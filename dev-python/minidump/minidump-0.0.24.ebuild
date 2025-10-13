# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1 pypi

DESCRIPTION="parse Windows minidump file format"
HOMEPAGE="https://github.com/skelsec/minidump"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

DEPEND="${RDEPEND}"
