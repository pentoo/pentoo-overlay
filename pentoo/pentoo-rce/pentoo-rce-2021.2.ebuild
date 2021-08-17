# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo RCE meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="hardened pentoo-full X"
KEYWORDS="amd64 arm x86"

PDEPEND="hardened? ( sys-apps/paxctl )
	app-arch/upx
	sys-devel/gdb
	sys-devel/gdb-dashboard
	amd64? ( dev-util/redasm )
	amd64? ( dev-util/jd-gui )
	dev-util/jadx-bin
	X? (
		app-editors/wxhexeditor
	)
	pentoo-full? (
		app-editors/dhex
		dev-util/vbindiff
		X? (
			app-editors/gedit
			app-editors/ghex
		)
		!hardened? ( sys-devel/prelink )
		!arm? ( dev-lang/nasm
			dev-util/edb-debugger
		)
		amd64? ( dev-util/radare2
			dev-util/cutter
			dev-util/ghidra
		)
		dev-util/ltrace
		dev-util/strace
	)"
