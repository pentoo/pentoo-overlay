# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo rce meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="hardened"
KEYWORDS="amd64 arm x86"

DEPEND=""
RDEPEND="${RDEPEND}
	hardened? ( sys-apps/paxctl )
	!hardened? ( sys-devel/prelink )
	dev-java/jad-bin
	!arm? ( dev-lang/nasm )
	amd64? ( dev-util/emilpro )
	!arm? ( dev-util/edb )
	dev-util/ltrace
	dev-util/metasm
	!arm? ( dev-util/radare2 )
	dev-util/strace
	sys-devel/gdb"
