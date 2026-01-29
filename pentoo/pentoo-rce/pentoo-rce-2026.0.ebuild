# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo RCE meta ebuild"
HOMEPAGE="https://www.pentoo.org"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="hardened pentoo-extra pentoo-full X"

PDEPEND="hardened? ( sys-apps/paxctl )
	app-arch/upx
	dev-debug/gdb
	dev-debug/gef
	sys-devel/gdb-dashboard
	amd64? ( ||
				(
					dev-util/jd-gui-bin
					dev-util/jd-gui
				)
			)
	dev-util/jadx-bin
	X? (
		app-editors/wxhexeditor
	)
	pentoo-full? (
		dev-util/vbindiff
		X? (
			app-editors/gedit
			app-editors/ghex
		)
		!arm? ( dev-lang/nasm
		)
		amd64? ( dev-util/cutter
		)
		dev-debug/ltrace
		dev-debug/strace
	)
	pentoo-extra? (
		amd64? ( dev-util/radare2 )
		dev-debug/dwarf-debugger
	)
	"
