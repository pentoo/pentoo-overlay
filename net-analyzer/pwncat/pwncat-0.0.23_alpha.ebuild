# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6,7} )
inherit eutils distutils-r1

DESCRIPTION="netcat with Firewall, IDS/IPS evasion, bind and reverse shell, self-injecting shell and port forwarding magic"
HOMEPAGE="https://github.com/cytopia/pwncat"
SRC_URI="https://github.com/cytopia/pwncat/archive/v${PV/_/-}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${P/_/-}"
