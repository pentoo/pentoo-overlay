# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

KEYWORDS="x86 amd64"
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

DEPEND=""
RDEPEND="${DEPEND}
	dev-util/jd-gui-bin
	android? ( dev-util/apktool
		   dev-util/dex2jar
	)
	ios? ( app-pda/ideviceinstaller
	       app-pda/ifuse
	       app-pda/libimobiledevice
	)"
