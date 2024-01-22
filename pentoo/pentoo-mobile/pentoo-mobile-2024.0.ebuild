# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo mobile meta ebuild"
HOMEPAGE="https://www.pentoo.org"
SLOT="0"
LICENSE="GPL-3"
IUSE="+android +ios pentoo-extra pentoo-full"
KEYWORDS="~amd64 ~x86"

#projects to add?
#https://github.com/504ensicslabs/lime
#https://github.com/mwrlabs/drozer
#https://github.com/mwrlabs/needle
#https://github.com/JesusFreke/smali

#dev-util/qark

PDEPEND="dev-util/frida-tools
	pentoo-full? (
		dev-debug/dwarf-debugger
		dev-util/objection
		dev-util/lief
	)
	android? ( dev-util/apktool
		dev-util/dex2jar
		dev-util/android-tools
		pentoo-full? (
			dev-util/appmon
			dev-python/apkid
			app-misc/gplaycli
			dev-util/androguard
		)
	)
	ios? (
		app-pda/ideviceinstaller
		app-pda/ifuse
		app-pda/usbmuxd
		pentoo-full? ( sys-devel/clang )
	)"
