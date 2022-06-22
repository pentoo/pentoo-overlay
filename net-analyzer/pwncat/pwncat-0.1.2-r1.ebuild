# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

DESCRIPTION="Netcat with IDS/IPS evasion, bind reverse shell and port forwarding magic"
HOMEPAGE="https://github.com/cytopia/pwncat"
SRC_URI="https://github.com/cytopia/pwncat/archive/v${PV/_/-}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

src_prepare() {
	distutils-r1_src_prepare

	#https://github.com/cytopia/pwncat/issues/113
	eapply "${FILESDIR}/setuptools-61.patch"
}
