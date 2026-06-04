# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Small python module for reading /var/lib/dhcp/dhcpd.leases from isc-dhcp-server"
HOMEPAGE="https://github.com/MartijnBraam/python-isc-dhcp-leases"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
RESTRICT="!test? ( test )"
RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	test? (
		>=dev-python/freezegun-0.3.4[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
