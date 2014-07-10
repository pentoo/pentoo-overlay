# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

KEYWORDS="amd64 arm x86"
DESCRIPTION="Pentoo mobile meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"
IUSE="+android +ios"

#projects to add?
#https://github.com/mwrlabs/mercury
#http://code.google.com/p/androguard/
#http://code.google.com/p/smali/
#https://code.google.com/p/lime-forensics/downloads/list

#https://github.com/iSECPartners/android-ssl-bypass
#https://github.com/iSECPartners/ios-ssl-kill-switch

DEPEND=""
RDEPEND="${DEPEND}
	android? ( !arm? ( dev-util/apktool
		dev-util/jd-gui-bin
		dev-util/dex2jar )
	)
	ios? ( sys-devel/clang
		app-pda/ideviceinstaller
		app-pda/ifuse
		app-pda/usbmuxd
	)"
