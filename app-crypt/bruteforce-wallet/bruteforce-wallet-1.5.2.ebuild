# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Try to find the password of an encrypted Peercoin (or Bitcoin, Litecoin, etc...) wallet file"
HOMEPAGE="https://github.com/glv2/${PN}"
SRC_URI="https://github.com/glv2/${PN}/releases/download/${PV}/${P}.tar.xz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-libs/openssl:*
	sys-libs/db:*"

RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	default
}
