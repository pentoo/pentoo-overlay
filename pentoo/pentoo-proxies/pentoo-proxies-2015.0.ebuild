# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Pentoo proxy meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="java minipentoo"

DEPEND=""

RDEPEND="${DEPEND}
	java? ( net-proxy/burpsuite
		net-proxy/zaproxy )

	!minipentoo? (
		x86? ( net-proxy/httpush )
		net-proxy/3proxy
		net-misc/iodine
		net-misc/proxychains
		net-proxy/mitmproxy
		net-proxy/privoxy
		net-proxy/ratproxy
		net-proxy/redsocks
		net-misc/tor
		net-proxy/tsocks
	)"
