# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo RCE meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="hardened minipentoo"
KEYWORDS="amd64 arm x86"

DEPEND=""
RDEPEND="${RDEPEND}
	hardened? ( sys-apps/paxctl )
	sys-devel/gdb
	dev-java/jad-bin

	!minipentoo? (
		!hardened? ( sys-devel/prelink )
		!arm? ( dev-lang/nasm
			dev-util/radare2
			dev-util/edb-debugger
		)
		amd64? ( dev-util/emilpro )
		app-misc/flasm
		dev-util/ltrace
		dev-util/metasm
		dev-util/strace
	)"
