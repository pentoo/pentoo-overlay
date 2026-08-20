# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GITHUB_REPOSITORY="vulnersCom/nmap-vulners"
inherit github-archive

DESCRIPTION="NSE script based on Vulners.com API"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="net-analyzer/nmap[nse]"

src_install() {
	insinto /usr/share/nmap/scripts
	doins vulners.nse
	dodoc README.md
}
