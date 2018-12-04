# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Pentoo mobile meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="+android +ios pentoo-full"
KEYWORDS="amd64 arm x86"

#projects to add?
#https://github.com/504ensicslabs/lime
#https://github.com/mwrlabs/drozer
#https://github.com/JesusFreke/smali

PDEPEND="dev-util/frida-tools
	pentoo-full? (
		dev-util/objection
		dev-util/appmon
		dev-python/lief
	)
	android? ( !arm? ( dev-util/apktool
		dev-util/dex2jar
		dev-util/android-tools
		)
		pentoo-full? (
			!arm? ( app-misc/gplaycli
			dev-util/android-sdk-update-manager
			)
			dev-python/androguard
		)
	)
	ios? (
		app-pda/ideviceinstaller
		app-pda/ifuse
		app-pda/usbmuxd
		pentoo-full? ( sys-devel/clang )
	)"
