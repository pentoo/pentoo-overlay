# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 pypi

DESCRIPTION="The unofficial Google Bard API port"
HOMEPAGE="https://github.com/dsdanielpark/Bard-API"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE="test"

#httpx[http2] == dev-python/h2
RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/deep-translator[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/httpx[${PYTHON_USEDEP}]
	dev-python/h2[${PYTHON_USEDEP}]
	dev-python/google-cloud-translate[${PYTHON_USEDEP}]
	dev-python/browser-cookie3[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

distutils_enable_tests pytest
