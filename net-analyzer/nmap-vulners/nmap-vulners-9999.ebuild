# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vulnersCom/nmap-vulners.git"
	KEYWORDS=""
elif [[ $(ver_cut 3) == "beta"  ]]; then
	MY_PV=$(ver_rs 2 -)
	SRC_URI="https://github.com/vulnersCom/nmap-vulners/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${MY_PV}"
else
	SRC_URI="https://github.com/vulnersCom/nmap-vulners/archive/v${PV}-release.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${P}-release"
fi

DESCRIPTION="NSE script based on Vulners.com API"
HOMEPAGE="https://github.com/vulnersCom/nmap-vulners"
LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="net-analyzer/nmap[nse]"

src_install() {
	insinto /usr/share/nmap/scripts/vulners
	doins vulners.nse
	dodoc README.md
}
