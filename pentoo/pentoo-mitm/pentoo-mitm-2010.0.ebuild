# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
KEYWORDS="-*"
DESCRIPTION="Pentoo mitm meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="wireless"

DEPEND=""

RDEPEND="${DEPEND}
	net-analyzer/dsniff
	net-analyzer/ettercap
	net-analyzer/sslstrip
	net-analyzer/sslsniff
	net-misc/bridge-utils
	wireless? ( net-wireless/karmetasploit )"
