# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Django live settings with pluggable backends, including Redis"
HOMEPAGE="http://github.com/jazzband/django-constance https://django-filter.readthedocs.org"
SRC_URI="https://github.com/haiwen/django-constance/archive/bde7f7c.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#https://django-constance.readthedocs.io/en/latest/
IUSE="database +redis"

CDEPEND=">=dev-python/django-1.8[${PYTHON_USEDEP}]
	database? ( dev-python/django-picklefield[${PYTHON_USEDEP}] )
	redis? ( dev-python/django-redis[${PYTHON_USEDEP}] )"

RDEPEND="${CDEPEND}"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
