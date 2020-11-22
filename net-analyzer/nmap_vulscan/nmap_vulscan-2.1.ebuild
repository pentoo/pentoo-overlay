# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A NSE vulnerability scanner which uses an offline version of scip VulDB"
HOMEPAGE="http://www.computec.ch/projekte/vulscan/"
SRC_URI="https://github.com/scipag/vulscan/archive/${PV}.tar.gz -> ${P}.tar.gz"
#updated db at http://www.computec.ch/projekte/vulscan/download/scipvuldb.csv

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

DEPEND=""
RDEPEND="net-analyzer/nmap[nse]"

S="${WORKDIR}"

src_install() {
	rm -r utilities
	insinto /usr/share/nmap/scripts/vulscan
	doins -r * || die "install failed"
}
