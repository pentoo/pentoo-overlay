# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo forensics meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE=""

DEPEND=""

RDEPEND="${DEPEND}
	app-crypt/xor-analyze
	app-forensics/autopsy
	app-forensics/cmospwd
	app-forensics/galleta
	app-forensics/make-pdf
	app-forensics/memdump
	app-forensics/origami
	app-forensics/pasco
	app-forensics/pdfid
	app-forensics/pdf-parser
	app-forensics/sleuthkit
	sys-apps/dcfldd
	sys-fs/dd-rescue
	sys-fs/ddrescue"
#FAILS
#	app-forensics/rdd

