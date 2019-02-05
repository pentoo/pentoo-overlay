# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pentoo footprint meta ebuild"
HOMEPAGE="https://www.pentoo.ch"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="amd64 ~arm x86"
IUSE="pentoo-full"

PDEPEND="
	net-analyzer/whatweb
	net-analyzer/wafw00f
	net-analyzer/amass

	pentoo-full? (
		net-analyzer/sublist3r
		net-analyzer/subfinder
		net-analyzer/fierce
		net-analyzer/dnsrecon
		net-analyzer/geoedge
		net-analyzer/metagoofil
		net-analyzer/ntp-fingerprint
		net-analyzer/p0f
		net-analyzer/recon-ng
		net-analyzer/scanssh
		net-analyzer/siphon
		net-analyzer/theHarvester
		net-analyzer/wfuzz
		net-analyzer/xprobe
	)"
