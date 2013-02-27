# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Pentoo forensics meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL"
SLOT="0"
IUSE="livecd"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	app-admin/testdisk
	app-crypt/xor-analyze
	app-forensics/autopsy
	app-forensics/cmospwd
	app-forensics/dff
	app-forensics/foremost
	app-forensics/galleta
	app-forensics/inception
	app-forensics/libvshadow
	app-forensics/make-pdf
	app-forensics/memdump
	app-forensics/origami
	app-forensics/pasco
	app-forensics/pdf-parser
	app-forensics/pdfid
	app-forensics/rdd
	app-forensics/sleuthkit
	app-forensics/volatility
	app-misc/hivex
	sys-apps/dcfldd
	sys-fs/dd-rescue
	sys-fs/ddrescue"
