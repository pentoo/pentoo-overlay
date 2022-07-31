# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo proxy meta ebuild"
HOMEPAGE="http://www.pentoo.ch"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="java pentoo-extra pentoo-full"

#zap is ~250MB but we really need to fill this use case
PDEPEND="
	java? ( net-proxy/zaproxy )

	pentoo-full? (
		net-dns/dnscrypt-proxy
		net-misc/proxychains
		net-proxy/3proxy
		net-proxy/mitmproxy
		net-proxy/privoxy
		net-proxy/redsocks
		net-proxy/tsocks
		net-vpn/iodine
		net-vpn/tor
	)
	pentoo-extra? ( java? (
		|| ( net-proxy/burpsuite net-proxy/burpsuite-pro )
	) )
	"
