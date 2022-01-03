# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

DESCRIPTION="Small python module for reading /var/lib/dhcp/dhcpd.leases from isc-dhcp-server"
HOMEPAGE="https://github.com/MartijnBraam/python-isc-dhcp-leases"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="amd64 ~arm64 x86"
SLOT="0"
