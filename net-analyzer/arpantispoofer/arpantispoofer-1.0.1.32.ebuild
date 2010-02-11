# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="a utility to detect and resist arp spoofing"
HOMEPAGE="http://sourceforge.net/projects/arpantispoofer/"
SRC_URI="mirror://sourceforge/$PN/$PN-linux-$PV.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="gnome-base/libgnomeui"

src_prepare() {
	sed -i "s|-O2|$CFLAGS|g" Makefile || die "sed failed"
}

src_install() {
	DESTDIR="${D}" emake install
	# remove broken symlink
	rm -rf "${D}"/usr/bin
}
