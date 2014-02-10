# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
KEYWORDS=""
DESCRIPTION="Pentoo proxy meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE="java qt4"

DEPEND=""

RDEPEND="${DEPEND}
	net-proxy/3proxy
	java? ( net-proxy/burpsuite
		net-proxy/zaproxy )
	x86? ( net-proxy/httpush )
	net-misc/iodine
	net-misc/proxychains
	qt4? ( net-misc/vidalia )
	net-proxy/mitmproxy
	net-proxy/privoxy
	net-proxy/ratproxy
	net-proxy/redsocks
	net-misc/tor
	net-proxy/tsocks"
