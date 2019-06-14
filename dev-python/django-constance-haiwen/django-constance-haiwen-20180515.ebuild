# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

#see seahub-<version>-server/requirements.txt
#branch: fix-sql patch2
HASH_COMMIT=8508ff29141732190faff51d5c2b5474da297732
DESCRIPTION="Django live settings with pluggable backends, including Redis"
HOMEPAGE="http://github.com/jazzband/django-constance https://django-filter.readthedocs.org"
#SRC_URI="https://github.com/haiwen/django-constance/archive/bde7f7c.zip"
SRC_URI="https://github.com/haiwen/django-constance/archive/${HASH_COMMIT}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+database redis"

CDEPEND=">=dev-python/django-1.8[${PYTHON_USEDEP}]
	database? ( dev-python/django-picklefield[${PYTHON_USEDEP}] )
	redis? ( dev-python/django-redis[${PYTHON_USEDEP}] )"

RDEPEND="${CDEPEND}"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/django-constance-${HASH_COMMIT}"
