# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

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
		net-dns/dnscrypt-proxy
		net-misc/proxychains
		net-proxy/3proxy
		net-proxy/mitmproxy
		net-proxy/privoxy
		net-proxy/ratproxy
		net-proxy/redsocks
		net-proxy/tsocks
		net-vpn/iodine
		net-vpn/tor
	)"
