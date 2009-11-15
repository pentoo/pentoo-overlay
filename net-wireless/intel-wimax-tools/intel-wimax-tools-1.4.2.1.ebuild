# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit linux-info

MY_P="wimax-tools-${PV}"
DESCRIPTION="Tools to use Intel's WiMax cards"
HOMEPAGE="http://www.linuxwimax.org"
SRC_URI="http://kernel.org/pub/linux/kernel/people/inaky/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_configure() {
       linux-mod_pkg_setup
        kernel_is -ge 2 6 31 && die "kernel 2.6.31 or higher are not supported by this version"
	econf --with-i2400m="${KV_DIR}"
}

src_compile() {
	emake -j1 || die "Compile failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc README || die "Failed to find README"
}

