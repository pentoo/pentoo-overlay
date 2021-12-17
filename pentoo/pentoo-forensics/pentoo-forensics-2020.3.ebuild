# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo forensics meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
IUSE="ieee1394 pentoo-full"
ieee1394KEYWORDS="~amd64 ~x86"

PDEPEND="
	sys-fs/extundelete
	app-forensics/sleuthkit
	sys-fs/ddrescue

	pentoo-full? (
		app-admin/testdisk
		app-crypt/xor-analyze
		!arm? ( app-forensics/cmospwd )
		app-forensics/foremost
		app-forensics/galleta
		ieee1394? ( app-forensics/inception )
		app-forensics/libvshadow
		app-forensics/make-pdf
		app-forensics/memdump
		amd64? ( app-forensics/origami-pdf )
		app-forensics/pasco
		app-forensics/pcileech
		app-forensics/pdf-parser
		app-forensics/pdfid
		app-forensics/volatility3
		app-misc/hivex
		sys-apps/dcfldd
		sys-block/partimage
		sys-fs/dd-rescue
	)"
