# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Pentoo mobile meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="+android +ios"
KEYWORDS="amd64 arm x86"

#projects to add?
#https://github.com/mwrlabs/mercury
#http://code.google.com/p/androguard/
#http://code.google.com/p/smali/
#https://code.google.com/p/lime-forensics/downloads/list

#https://github.com/iSECPartners/android-ssl-bypass
#https://github.com/iSECPartners/ios-ssl-kill-switch

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/frida-python
	android? ( !arm? ( dev-util/apktool
		dev-util/jd-gui-bin
		dev-util/jadx-bin
		dev-util/dex2jar
		dev-util/android-tools
		dev-util/android-sdk-update-manager
		app-misc/gplaycli
		)
	)
	ios? ( sys-devel/clang
		app-pda/ideviceinstaller
		app-pda/ifuse
		app-pda/usbmuxd
	)"
