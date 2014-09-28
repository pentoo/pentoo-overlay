# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo forensics meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
IUSE="livecd minipentoo"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	app-admin/testdisk
	app-forensics/dff
	app-forensics/inception
	app-forensics/sleuthkit
	app-forensics/volatility
	sys-fs/ddrescue

	!minipentoo? (
		app-crypt/xor-analyze
		app-forensics/autopsy
		!arm? ( app-forensics/cmospwd )
		app-forensics/foremost
		app-forensics/galleta
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
		sys-fs/dd-rescue
	)"
