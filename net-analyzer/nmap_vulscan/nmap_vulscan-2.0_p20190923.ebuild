# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

HASH_COMMIT="6beff39b5cc0f7a84c3cd0fe716f75b6f26b4ee8"

DESCRIPTION="A NSE vulnerability scanner which uses an offline version of scip VulDB"
HOMEPAGE="http://www.computec.ch/projekte/vulscan/"
SRC_URI="https://github.com/scipag/vulscan/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="net-analyzer/nmap[nse]"

S="${WORKDIR}/vulscan-${HASH_COMMIT}"

src_install() {
	rm -r utilities
	insinto /usr/share/nmap/scripts/vulscan
	doins -r * || die "install failed"
}
