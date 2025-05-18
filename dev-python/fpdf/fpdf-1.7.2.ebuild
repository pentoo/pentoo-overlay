# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Simple PDF generation for Python"
HOMEPAGE="https://github.com/reingart/pyfpdf"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
