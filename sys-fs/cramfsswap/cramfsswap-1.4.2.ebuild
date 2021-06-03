# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="swap endianness of a cram filesystem (cramfs)"
HOMEPAGE="https://packages.debian.org/buster/cramfsswap"

SRC_URI="http://deb.debian.org/debian/pool/main/c/${PN}/${PN}_${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

src_compile() {
	emake cramfsswap
}

src_install() {
	mkdir --parents "${D}/usr/bin"
	emake DESTDIR="${D}" install
	doman cramfsswap.1
	dodoc README
}
