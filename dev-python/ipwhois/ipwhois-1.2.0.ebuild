# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Retrieve and parse whois data for IPv4 and IPv6 addresses"
HOMEPAGE="https://github.com/secynic/ipwhois"
SRC_URI="https://github.com/secynic/ipwhois/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RESTRICT="test"

RDEPEND="${PYTHON_DEPS}
	=dev-python/dnspython-2*[${PYTHON_USEDEP}]"

PATCHES=(
	#https://github.com/secynic/ipwhois/issues/303
	"${FILESDIR}"/302_fixed.patch
)
