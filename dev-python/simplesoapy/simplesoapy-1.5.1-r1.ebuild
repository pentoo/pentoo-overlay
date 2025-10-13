# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
PYPI_PN="SimpleSoapy"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Simple pythonic wrapper for SoapySDR library"
HOMEPAGE="https://github.com/xmikos/simplesoapy"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/numpy[${PYTHON_USEDEP}]
	net-wireless/soapysdr[python]"
