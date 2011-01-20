# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo rce meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE=""

DEPEND=""

#the tools
RDEPEND="${RDEPEND}
	hardened? ( app-misc/pax-utils
		    sys-apps/paxctl
		    sys-devel/prelink )
	app-antivirus/malheur
        dev-java/jad-bin
        dev-lang/nasm
	dev-util/dissy
	dev-util/edb
	dev-util/metasm
        dev-util/ltrace
        dev-util/radare
        dev-util/strace
        sys-devel/gdb"
