# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="A NSE vulnerability scanner which uses an offline version of scip VulDB"
HOMEPAGE="http://www.computec.ch/projekte/vulscan/"
EGIT_REPO_URI="https://github.com/scipag/vulscan.git"
EGIT_COMMIT="cdb92c8cf816ddefecced16c84607bb1f247447e"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"

DEPEND=""
RDEPEND="net-analyzer/nmap[nse]"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/nmap/scripts/vulscan
	doins -r * || die "install failed"
}
