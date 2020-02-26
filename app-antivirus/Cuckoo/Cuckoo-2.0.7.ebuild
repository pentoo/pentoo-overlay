# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="Automated Malware Analysis System"
HOMEPAGE="https://cuckoosandbox.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"

#https://github.com/hatching/httpreplay/issues/19
#KEYWORDS="~amd64 ~x86"
KEYWORDS=""

IUSE="mongodb postgresql"

RDEPEND="
	>=dev-python/alembic-0.8.8[${PYTHON_USEDEP}]
	>=dev-util/androguard-3.0.1[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup-4.5.3[${PYTHON_USEDEP}]
	>=dev-python/chardet-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/click-6.6[${PYTHON_USEDEP}]
	>=dev-python/django-1.8.4[${PYTHON_USEDEP}]
	>=dev-python/django-extensions-1.6.7[${PYTHON_USEDEP}]
	>=dev-python/dpkt-1.8.7[${PYTHON_USEDEP}]
	>=dev-python/egghatch-0.2.3[${PYTHON_USEDEP}] <dev-python/egghatch-0.3
	>=dev-python/elasticsearch-py-5.3.0[${PYTHON_USEDEP}]
	>=dev-python/flask-0.12.2[${PYTHON_USEDEP}]
	>=dev-python/flask-sqlalchemy-2.1[${PYTHON_USEDEP}]
	>=dev-python/HTTPReplay-0.2.2[${PYTHON_USEDEP}] <dev-python/HTTPReplay-0.3
	>=dev-python/jinja-2.9.6[${PYTHON_USEDEP}]
	>=dev-python/jsbeautifier-1.6.2[${PYTHON_USEDEP}]
	>=dev-python/oletools-0.51[${PYTHON_USEDEP}]
	>=dev-python/peepdf-0.4.2[${PYTHON_USEDEP}] <dev-python/peepdf-0.5
	>=dev-python/pefile2-1.2.11[${PYTHON_USEDEP}]
	>=dev-python/pillow-3.2[${PYTHON_USEDEP}]
	>=dev-python/pyelftools-0.24[${PYTHON_USEDEP}]
	>=dev-python/pyguacamole-0.6[${PYTHON_USEDEP}]
	>=dev-python/pymisp-2.4.54[${PYTHON_USEDEP}]
	mongodb? ( >=dev-python/pymongo-3.0.3[${PYTHON_USEDEP}] )
	>=dev-python/python-dateutil-2.4.2[${PYTHON_USEDEP}]
	>=dev-python/python-magic-0.4.12[${PYTHON_USEDEP}]
	>=dev-python/roach-0.1.2[${PYTHON_USEDEP}] <dev-python/roach-0.2
	>=dev-python/sflock-0.3.5[${PYTHON_USEDEP}] <dev-python/sflock-0.4
	>=dev-python/sqlalchemy-1.0.8[${PYTHON_USEDEP}]
	>=dev-libs/unicorn-bindings-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/wakeonlan-0.2.2[${PYTHON_USEDEP}]
	>=dev-python/yara-python-3.6.3[${PYTHON_USEDEP}]

	virtual/libffi
	postgresql? ( dev-python/psycopg[${PYTHON_USEDEP}] )

	dev-python/requests[ssl,${PYTHON_USEDEP}]
	dev-python/gevent[${PYTHON_USEDEP}]
	net-analyzer/scapy[${PYTHON_USEDEP}]
"
#libssl
#libjpeg
#zlib1g
#swig

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
