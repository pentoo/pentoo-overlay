# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Crypto-currency wallet password recovery tool"
HOMEPAGE="https://github.com/glv2/bruteforce-wallet"
SRC_URI="https://github.com/glv2/bruteforce-wallet/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm ~x86"

DEPEND="
	dev-libs/openssl:*
	sys-libs/db:*"

RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	default
}
