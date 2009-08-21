# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=2
inherit linux-info
DESCRIPTION="Tools to use Intel's WiMax cards"
HOMEPAGE="http://www.linuxwimax.org"
SRC_URI="http://kernel.org/pub/linux/kernel/people/inaky/wimax-tools-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/wimax-tools-${PV}

src_configure() {
	econf --with-i2400m="${KV_DIR}" || die "econf failed"
}

src_compile() {
	emake -j1 || die "Compile failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc README || die "Failed to find README"
}

