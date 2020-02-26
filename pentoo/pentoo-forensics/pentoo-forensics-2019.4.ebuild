# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo forensics meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
IUSE="pentoo-full"
KEYWORDS="~amd64 ~x86"

PDEPEND="
	sys-fs/extundelete
	app-forensics/sleuthkit
	app-forensics/volatility
	sys-fs/ddrescue

	pentoo-full? (
		app-admin/testdisk
		app-crypt/xor-analyze
		!arm? ( app-forensics/cmospwd )
		app-forensics/foremost
		app-forensics/galleta
		app-forensics/inception
		app-forensics/libvshadow
		app-forensics/make-pdf
		app-forensics/memdump
		app-forensics/origami-pdf
		app-forensics/pasco
		app-forensics/pdf-parser
		app-forensics/pdfid
		app-forensics/rdd
		app-misc/hivex
		sys-apps/dcfldd
		sys-block/partimage
		sys-fs/dd-rescue
	)"

#https://github.com/arxsys/dff/issues/23
#	app-forensics/dff
