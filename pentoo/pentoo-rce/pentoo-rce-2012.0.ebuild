# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo rce meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="hardened"

DEPEND=""

#the tools
RDEPEND="${RDEPEND}
	hardened? ( sys-apps/paxctl )
	!hardened? ( sys-devel/prelink )
	dev-java/jad-bin
	!arm? ( dev-lang/nasm )
	dev-util/dissy
	dev-util/edb
	dev-util/ltrace
	dev-util/metasm
	dev-util/radare2
	dev-util/strace
	sys-devel/gdb"

#removed, doesn't build
#	app-antivirus/malheur

