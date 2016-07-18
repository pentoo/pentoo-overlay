# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_3,3_4} )
inherit distutils-r1

DESCRIPTION="Small python module for reading /var/lib/dhcp/dhcpd.leases from isc-dhcp-server"
HOMEPAGE="https://github.com/MartijnBraam/python-isc-dhcp-leases"
SRC_URI="https://github.com/MartijnBraam/python-isc-dhcp-leases/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""
