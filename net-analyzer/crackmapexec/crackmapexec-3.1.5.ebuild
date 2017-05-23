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

RDEPEND=">=dev-python/impacket-0.9.15
	>=dev-python/gevent-1.2.0
	dev-python/netaddr
	dev-python/pycrypto
	dev-python/pyasn1
	dev-python/termcolor
	dev-python/requests
	dev-python/pyopenssl
	dev-python/msgpack"

S="${WORKDIR}/CrackMapExec-${PV}"
