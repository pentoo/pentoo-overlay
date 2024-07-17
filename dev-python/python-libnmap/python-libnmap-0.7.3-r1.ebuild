# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="A python library enabling python developers to manipulate nmap process and data"
HOMEPAGE="https://pypi.org/project/python-libnmap/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="boto defusedxml mongodb sqlalchemy"

RDEPEND="${PYTHON_DEPS}
	defusedxml? ( dev-python/defusedxml[${PYTHON_USEDEP}] )
	sqlalchemy? ( dev-python/sqlalchemy[${PYTHON_USEDEP}] )
	mongodb? ( dev-python/pymongo[${PYTHON_USEDEP}] )
	boto? ( dev-python/boto3[${PYTHON_USEDEP}] )
"
