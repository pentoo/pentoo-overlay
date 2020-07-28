# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Collection of NFC tools"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

PDEPEND="net-wireless/mfoc
	amd64? ( net-wireless/proxmark3 )
"
#	net-wireless/rfidler
	#app-crypt/acsccid
