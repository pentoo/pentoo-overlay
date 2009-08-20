# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Intel WiMAX Network Service has no description"
HOMEPAGE="http://linuxwimax.org/"
SRC_URI="http://www.linuxwimax.org/Download?action=AttachFile&do=get&target=Intel-WiMAX-Binary-Supplicant-${PV}.tar.bz2 -> WiMAX-Binary-Supplicant-${PV}.tar.bz2"

LICENSE="IFDBL" #legal to redistribute but not mess with
SLOT="0"
EAPI=2
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

S=${WORKDIR}/Intel-WiMAX-Binary-Supplicant-${PV}

src_install() {
	DESTDIR=${D} ./install_supplicant.sh install
	dodoc README
	dodir /etc/revdep-rebuild
	insinto /etc/revdep-rebuild
	doins ${FILESDIR}/50-intel-wimax-binary-supplicant
}
