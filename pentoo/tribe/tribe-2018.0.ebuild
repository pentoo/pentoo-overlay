# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="amd64 x86 ~arm ~arm64 "
DESCRIPTION="Tribe meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE=""

DEPEND=""

RDEPEND="${DEPEND}
	net-wireless/aircrack-ng[airdrop-ng]
	app-crypt/veracrypt
	app-arch/p7zip
	net-irc/ngircd
	app-crypt/steghide
	virtual/jdk
	net-vpn/tor"
