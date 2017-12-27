# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

#inherit git-r3

DESCRIPTION="NSE script based on Vulners.com API"
HOMEPAGE="https://github.com/vulnersCom/nmap-vulners"
#EGIT_REPO_URI="https://github.com/vulnersCom/nmap-vulners.git"
#EGIT_COMMIT="6add677dceca02a7a2c3e8fd080f9f9d045eb03f"
SRC_URI="https://github.com/vulnersCom/nmap-vulners/archive/v${PV}-release.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"

DEPEND=""
RDEPEND="net-analyzer/nmap[nse]"

S="${WORKDIR}/${P}-release"

src_install() {
	insinto /usr/share/nmap/scripts/vulners
	doins vulners.nse
	dodoc README.md
}
