# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="File-based locks for Python"
HOMEPAGE="
	https://github.com/mwilliamson/locket.py
	https://pypi.org/project/locket/
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
