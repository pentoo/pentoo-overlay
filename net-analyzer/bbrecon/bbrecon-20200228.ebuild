# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Automated reconnaissance and information gathering (fork)"
HOMEPAGE="https://gitlab.com/0bs1d1an/bbrecon"

HASH_COMMIT="20347e8be4b9bee9a852a9adcd256d67022a8b4b"
SRC_URI="https://gitlab.com/0bs1d1an/bbrecon/repository/${HASH_COMMIT}/archive.tar.bz2 -> ${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	app-dicts/seclists
	app-misc/jq
	app-shells/bash
	app-text/unfurl
	net-analyzer/aquatone
	net-analyzer/dirsearch
	net-analyzer/massdns
	net-analyzer/nmap
	net-analyzer/sublist3r
	net-dns/bind-tools
	net-misc/httprobe
	net-misc/waybackurls
	sys-apps/coreutils
	sys-apps/findutils
	sys-apps/grep
	sys-apps/sed
	sys-libs/ncurses
	virtual/awk
	www-client/chromium
"

src_install() {
	insinto "/usr/share/${PN}"
	doins clean-jhaddix-dns.txt
	newbin "${PN}.sh" "${PN}"
	dodoc README.md
}

S="${WORKDIR}/${PN}-${HASH_COMMIT}-${HASH_COMMIT}"
