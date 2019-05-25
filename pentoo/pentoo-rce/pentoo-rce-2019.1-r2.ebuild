# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo RCE meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="hardened pentoo-full"
KEYWORDS="amd64 arm x86"

PDEPEND="hardened? ( sys-apps/paxctl )
	sys-devel/gdb
	dev-util/redasm
	|| ( dev-util/jd-gui dev-util/jd-gui-bin )
	dev-util/jadx-bin
	pentoo-full? (
		dev-util/ghidra
		!hardened? ( sys-devel/prelink )
		!arm? ( dev-lang/nasm
			dev-util/edb-debugger
		)
		amd64? ( dev-util/radare2
			dev-util/cutter
		)
		dev-util/ltrace
		dev-util/strace
	)"
