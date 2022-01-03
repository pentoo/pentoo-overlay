# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

DESCRIPTION="pwning IPv4 via IPv6"
HOMEPAGE="https://github.com/CoreSecurity/impacket"
SRC_URI="https://github.com/fox-it/mitm6/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=net-analyzer/scapy-2.4[${PYTHON_USEDEP}]
	dev-python/twisted[${PYTHON_USEDEP}]
	!=dev-python/twisted-17.1.0-r2
	dev-python/netifaces[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
