# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit distutils-r1

DESCRIPTION="Implementation of per object permissions for Django 1.2+"
HOMEPAGE="https://github.com/lukaszb/django-guardian"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

CDEPEND=">=dev-python/django-1.2[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]"

RDEPEND="${CDEPEND}"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]"
