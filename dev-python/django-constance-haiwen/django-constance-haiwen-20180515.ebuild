# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

#see seahub-<version>-server/requirements.txt
#branch: fix-sql patch2
HASH_COMMIT=8508ff29141732190faff51d5c2b5474da297732
DESCRIPTION="Django live settings with pluggable backends, including Redis"
HOMEPAGE="https://github.com/jazzband/django-constance https://django-filter.readthedocs.org"
#SRC_URI="https://github.com/haiwen/django-constance/archive/bde7f7c.zip"
SRC_URI="https://github.com/haiwen/django-constance/archive/${HASH_COMMIT}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+database redis"

CDEPEND=">=dev-python/django-1.8[${PYTHON_USEDEP}]
	database? ( dev-python/django-picklefield[${PYTHON_USEDEP}] )
	redis? ( dev-python/django-redis[${PYTHON_USEDEP}] )"

RDEPEND="${CDEPEND}"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/django-constance-${HASH_COMMIT}"
