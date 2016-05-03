# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 git-r3

DESCRIPTION="A tool to automate injection attacks and exploit weaknesses in NoSQL"
HOMEPAGE="http://www.nosqlmap.net"
EGIT_REPO_URI="https://github.com/tcstool/NoSQLMap.git"
EGIT_COMMIT="b2da8f535033ab8593ff5a4aec153881f230e2c1"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}
	>=dev-python/couchdb-python-1.0
	>=dev-python/httplib2-0.9
	>=dev-python/ipcalc-1.1.3
	>=dev-python/pbkdf2-1.3
	>=dev-python/pymongo-2.7.2
	>=dev-python/requests-2.5.0"
RDEPEND="${DEPEND}"
