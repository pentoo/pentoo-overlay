# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 eutils

DESCRIPTION="A swiss army knife for pentesting Windows/Active Directory environments"
HOMEPAGE="https://github.com/byt3bl33d3r/CrackMapExec/releases"
SRC_URI="https://github.com/byt3bl33d3r/CrackMapExec/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
SLOT="0"

RDEPEND=">=dev-python/impacket-0.9.15[${PYTHON_USEDEP}]
	>=dev-python/gevent-1.2.0[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	|| ( dev-python/pycryptodome[${PYTHON_USEDEP}] dev-python/pycrypto[${PYTHON_USEDEP}] )
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/msgpack"[${PYTHON_USEDEP}]

S="${WORKDIR}/CrackMapExec-${PV}"
