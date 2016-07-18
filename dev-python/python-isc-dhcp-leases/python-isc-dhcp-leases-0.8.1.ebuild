# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

MY_P=python-isc-dhcp-leases-"${PV}"

inherit distutils


DESCRIPTION="Small python module for reading /var/lib/dhcp/dhcpd.leases from isc-dhcp-server"
HOMEPAGE="https://github.com/MartijnBraam/python-isc-dhcp-leases"
SRC_URI="https://github.com/MartijnBraam/python-isc-dhcp-leases/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~amd64"
SLOT="0"
IUSE=""


PYTHON_MODNAME="python-isc-dhcp-leases"
