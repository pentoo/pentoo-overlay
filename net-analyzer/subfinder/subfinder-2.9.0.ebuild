# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="A subdomain discovery tool that discovers valid subdomains for websites"
HOMEPAGE="https://github.com/projectdiscovery/subfinder"

SRC_URI="https://github.com/projectdiscovery/subfinder/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/${P}-vendor.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~x86"

PATCHES=( "${FILESDIR}"/options.patch )

src_install() {
	dobin subfinder
}
