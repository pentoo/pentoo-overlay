# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo proxy meta ebuild"
HOMEPAGE="https://www.pentoo.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="java pentoo-extra pentoo-full"

PDEPEND="
	java? ( || ( net-proxy/burpsuite net-proxy/burpsuite-pro ) )

	pentoo-full? (
		net-dns/dnscrypt-proxy
		net-misc/proxychains
		net-proxy/3proxy
		net-proxy/privoxy
		net-proxy/redsocks
		net-vpn/iodine
		net-vpn/tor
	)
	pentoo-extra? (
		java? ( net-proxy/zaproxy )
	)
	"
