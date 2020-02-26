# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )

inherit distutils-r1

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/cr0hn/enteletaor"
else
	HASH_COMMIT="${PV}"
	SRC_URI="https://github.com/cr0hn/enteletaor/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Message Queue & Broker Injection tool"
HOMEPAGE="https://github.com/cr0hn/enteletaor"

LICENSE="Unlicense"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="
	dev-python/celery[${PYTHON_USEDEP}]
	dev-python/colorlog[${PYTHON_USEDEP}]
	dev-python/eventlet[${PYTHON_USEDEP}]
	dev-python/ipaddress[${PYTHON_USEDEP}]
	dev-python/kombu[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/pyzmq[${PYTHON_USEDEP}]
	dev-python/redis-py[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/wtforms[${PYTHON_USEDEP}]
	dev-ruby/amqp"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
