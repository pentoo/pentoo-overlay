# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1  #eutils

DESCRIPTION="16 different honeypots 'swissarmy-knife' in a single PyPI package for monitoring network traffic"
HOMEPAGE="https://github.com/qeeqbox/honeypots"
## also has varrious python OSINT tools github.com/qeeqbox/ ..... 

SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI=="https://github.com/qeeqbox/honeypots.git"
		case "${PVR}" in
		9999) EGIT_BRANCH=main ;;
	esac
fi

LICENSE="AGPL-3.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE=""


RDEPEND="${PYTHON_DEPS} ${DEPEND}"
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
	DEPEND="|| ( dev-python/psycopg dev-python/psycopg2cffi  )"
# dev-python/psycopg in gentoo / psycopg2cffi rappid c++ extensions either should run. 
# dev-python/psycopg2cffi::tgbugs-overlay , implementation of the psycopg2 module using cffi. Compatible with Psycopg 2.5.

SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"

S="${WORKDIR}/${PN}-${MY_PV}"

einfo "https://pypi.org/project/honeypots/ https://github.com/qeeqbox/honeypots for wiki/directions" 
