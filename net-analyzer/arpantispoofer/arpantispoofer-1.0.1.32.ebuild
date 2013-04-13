# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="An utility to detect and resist arp spoofing"
HOMEPAGE="http://sourceforge.net/projects/arpantispoofer/"
SRC_URI="mirror://sourceforge/$PN/$PN-linux-$PV.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="gnome-base/libgnomeui"

S="${WORKDIR}"

src_prepare() {
	sed -i "s|-O2|$CFLAGS|g" Makefile || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install
	# remove broken symlink
	rm -rf "${D}"/usr/bin
}
