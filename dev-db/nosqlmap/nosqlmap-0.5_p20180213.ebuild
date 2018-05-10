# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 git-r3

DESCRIPTION="A tool to automate injection attacks and exploit weaknesses in NoSQL"
HOMEPAGE="http://www.nosqlmap.net"
EGIT_REPO_URI="https://github.com/tcstool/NoSQLMap.git"
EGIT_COMMIT="e9d0506f78ba8d565226ef6cbc63c40cdb5e80b9"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/couchdb-python-1.0[${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.9[${PYTHON_USEDEP}]
	>=dev-python/ipcalc-1.1.3[${PYTHON_USEDEP}]
	>=dev-python/pbkdf2-1.3[${PYTHON_USEDEP}]
	>=dev-python/pymongo-2.7.2[${PYTHON_USEDEP}]
	>=dev-python/requests-2.5.0[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
