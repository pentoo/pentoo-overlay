# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1 eutils

DESCRIPTION="16 different honeypots "swissarmy-knife" in a single PyPI package for monitoring network traffic"
HOMEPAGE="https://github.com/qeeqbox/honeypots"
## also has varrious python OSINT tools github.com/qeeqbox/ ..... 

SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
# EGIT_REPO_URI=="https://github.com/qeeqbox/honeypots.git"

LICENSE="AGPL-3.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""

#### dev-python/psycopg2 https://pypi.org/project/psycopg2/ , https://github.com/psycopg/psycopg2/
 # dev-python/psycopg2cffi::tgbugs-overlay , mplementation of the psycopg2 module using cffi. Compatible with Psycopg 2.5.
RDEPEND="${PYTHON_DEPS}
	dev-python/pipenv
	dev-python/twisted
    dev-python/psutil
    dev-python/psycopg2
   	dev-python/dnspython
    dev-python/requests[socks]
    dev-python/impacket
    dev-python/paramiko
    dev-python/redis-py
    dev-python/mysql-connector-python
    dev-python/pycryptodome
    dev-python/vncdotool
    dev-python/service_identity
    dev-python/PySocks
     dev-python/pygments
DEPEND="${RDEPEND}"



src_compile() {
	compile_python() {
		distutils-r1_python_compile --dynamic-linking
	}
	python_foreach_impl compile_python
}
