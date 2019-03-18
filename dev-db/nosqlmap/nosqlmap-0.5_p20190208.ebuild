# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 eutils

DESCRIPTION="A tool to automate injection attacks and exploit weaknesses in NoSQL"
HOMEPAGE="https://github.com/codingo/NoSQLMap"
HASH_COMMIT="ba39e50ccb784d37aa04554eeb2f082b7475dc37"
SRC_URI="https://github.com/codingo/NoSQLMap/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="~dev-python/couchdb-python-1.0[${PYTHON_USEDEP}]
	~dev-python/httplib2-0.9[${PYTHON_USEDEP}]
	~dev-python/ipcalc-1.1.3[${PYTHON_USEDEP}]
	~dev-python/pbkdf2-1.3[${PYTHON_USEDEP}]
	~dev-python/pymongo-2.7.2[${PYTHON_USEDEP}]
	~dev-python/requests-2.5.0[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/NoSQLMap-${HASH_COMMIT}"

#python_prepare_all() {
#	epatch ${FILESDIR}/${PN}-setup.patch
#	distutils-r1_python_prepare_all
#}
