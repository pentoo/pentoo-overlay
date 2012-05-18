# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo forensics meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="livecd"

DEPEND=""

RDEPEND="${DEPEND}
	app-crypt/xor-analyze
	app-forensics/autopsy
	app-forensics/cmospwd
	app-forensics/dff
	app-forensics/galleta
	app-forensics/make-pdf
	app-forensics/memdump
	app-forensics/origami
	app-forensics/pasco
	app-forensics/pdfid
	app-forensics/pdf-parser
	app-forensics/rdd
	app-forensics/sleuthkit
	app-forensics/volatility
	sys-apps/dcfldd
	sys-fs/dd-rescue
	sys-fs/ddrescue"

#need to test unmasking python3 before allowing this
#	!livecd? ( app-forensics/inception )"

