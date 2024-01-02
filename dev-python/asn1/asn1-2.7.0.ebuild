# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="a simple ASN.1 encoder and decoder"
HOMEPAGE="https://github.com/andrivet/python-asn1"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"
