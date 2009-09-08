# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

MY_P=Intel-WiMAX-Binary-Supplicant-${PV}
DESCRIPTION="Authentication information for WiMax Networks"
HOMEPAGE="http://www.linuxwimax.org/"
SRC_URI="http://www.linuxwimax.org/Download?action=AttachFile&do=get&target=${MY_P}.tar.bz2 -> ${MY_P}.tar.bz2"
LICENSE="IFDBL"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/install-to-usr-lib.patch
}

src_install() {
	DESTDIR=${D} ./install_supplicant.sh install || dir "install_supplicant.sh failed"
	dodoc README || die "Failed to find README"
	insinto /etc/revdep-rebuild
	doins "${FILESDIR}"/50-intel-wimax-binary-supplicant || die "failed to install revdep-rebuild fix"
}
