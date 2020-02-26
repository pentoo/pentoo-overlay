# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo mobile meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="+android +ios pentoo-full"
KEYWORDS="amd64 arm x86"

#projects to add?
#https://github.com/504ensicslabs/lime
#https://github.com/mwrlabs/drozer
#https://github.com/mwrlabs/needle
#https://github.com/JesusFreke/smali

#dev-util/qark

#python2 only:
#dev-util/appmon

PDEPEND="dev-util/frida-tools
	pentoo-full? (
		dev-util/objection
		!arm? ( dev-util/lief )
	)
	android? ( !arm? ( dev-util/apktool
		dev-util/dex2jar
		dev-util/android-tools
		)
		pentoo-full? (
			!arm? ( app-misc/gplaycli
			dev-util/android-sdk-update-manager
			)
			dev-util/androguard
		)
	)
	ios? (
		app-pda/ideviceinstaller
		app-pda/ifuse
		app-pda/usbmuxd
		pentoo-full? ( sys-devel/clang )
	)"
