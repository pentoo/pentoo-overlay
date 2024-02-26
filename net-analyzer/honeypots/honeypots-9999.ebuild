# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="16 different honeypots for monitoring network traffic"
HOMEPAGE="https://github.com/qeeqbox/honeypots"

if [ "${PV#9999}" != "${PV}" ] ; then
	SCM="git-r3"
	EGIT_REPO_URI=="https://github.com/qeeqbox/honeypots.git"
else
	inherit pypi
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

LICENSE="AGPL-3"
SLOT="0"
RESTRICT="test"

RDEPEND="
	dev-python/twisted[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	( dev-python/psycopg[${PYTHON_USEDEP}] dev-python/psycopg2cffi[${PYTHON_USEDEP}] )
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/requests[socks5,${PYTHON_USEDEP}]
	dev-python/impacket[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	net-analyzer/scapy[${PYTHON_USEDEP}]
	dev-python/service-identity[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]
"
#	dev, optional:
#	dev-python/dnspython[${PYTHON_USEDEP}]
#	dev-python/redis-py[${PYTHON_USEDEP}]
#	dev-python/mysql-connector-python[${PYTHON_USEDEP}]
#	dev-python/vncdotool[${PYTHON_USEDEP}]
#	dev-python/PySocks[${PYTHON_USEDEP}]
#	dev-python/pygments[${PYTHON_USEDEP}]
#"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# dev-python/psycopg in gentoo / psycopg2cffi rappid c++ extensions either should run.
# dev-python/psycopg2cffi::tgbugs-overlay , implementation of the psycopg2 module using cffi.
# Compatible with Psycopg 2.5.
