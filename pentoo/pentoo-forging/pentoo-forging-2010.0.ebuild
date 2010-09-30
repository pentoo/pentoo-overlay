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
	net-analyzer/fragroute
	net-analyzer/gspoof
	net-analyzer/hping
	net-analyzer/isic
	net-analyzer/netwag
	net-analyzer/packit
	net-analyzer/rain
	net-misc/ipsorcery
	net-misc/nemesis"
