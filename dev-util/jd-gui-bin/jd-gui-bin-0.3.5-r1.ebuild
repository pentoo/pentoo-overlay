# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils multilib

DESCRIPTION="A standalone graphical utility that displays Java source codes of .class file"
HOMEPAGE="http://jd.benow.ca/"
SRC_URI="http://jd.benow.ca/jd-gui/downloads/jd-gui-${PV}.linux.i686.tar.gz"

LICENSE="Unknown"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND="x11-libs/gtk+:2[abi_x86_32]"

S="${WORKDIR}"

src_prepare() {
	#remove gnome related stuff (nautilus)
	rm -rf contrib
}

src_install() {
	exeinto "/usr/bin"
	doexe "${WORKDIR}/jd-gui"
	dodoc readme.txt
}

pkg_postinst() {
		einfo "JD-GUI is free for non-commercial use."
		einfo "This means that JD-GUI shall not be included or embedded into commercial software products. "
		einfo "Nevertheless, JD-GUI may be freely used for personal needs in a commercial or non-commercial environments."
		ewarn "JD-GUI creates a jd-gui.cfg file in the current working directory."
		ewarn "Make sure you run it in a directory you can remove afterwards"
}
