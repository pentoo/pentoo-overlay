# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vulnersCom/nmap-vulners.git"
	KEYWORDS=""
elif [[ $(ver_cut 3) == "beta"  ]]; then
	MY_PV=$(ver_rs 2 -)
	SRC_URI="https://github.com/vulnersCom/nmap-vulners/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${MY_PV}"
elif [[ ${PV} == "1.4_p20250927"  ]]; then
	HASH_COMMIT="0555294abe71857c581afc2ef62ea3ca5c7b7145"
#https://github.com/vulnersCom/nmap-vulners/archive/0555294abe71857c581afc2ef62ea3ca5c7b7145.zip
	SRC_URI="https://github.com/vulnersCom/nmap-vulners/archive/${HASH_COMMIT}.zip -> ${P}.zip"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
else
	SRC_URI="https://github.com/vulnersCom/nmap-vulners/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="amd64 x86"
#	S="${WORKDIR}/${P}-release"
fi

DESCRIPTION="NSE script based on Vulners.com API"
HOMEPAGE="https://github.com/vulnersCom/nmap-vulners"
LICENSE="GPL-3"
SLOT="0"

DEPEND=""
RDEPEND="net-analyzer/nmap[nse]"

src_install() {
	insinto /usr/share/nmap/scripts/vulners
	doins http-vulners-regex.nse
	doins vulners.nse
	doins vulners_enterprise.nse
	dodoc README.md
}
