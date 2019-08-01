# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils

DESCRIPTION="A tool to automate injection attacks and exploit weaknesses in NoSQL"
HOMEPAGE="https://github.com/codingo/NoSQLMap"

HASH_COMMIT="0a281b34070b69abcdc18057c4cd3952c9735086" # snapshot: 20190530
SRC_URI="https://github.com/codingo/NoSQLMap/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/couchdb-python[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/ipcalc[${PYTHON_USEDEP}]
	dev-python/pbkdf2[${PYTHON_USEDEP}]
	dev-python/pymongo[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}"

S="${WORKDIR}/NoSQLMap-${HASH_COMMIT}"
