# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A NSE vulnerability scanner which uses an offline version of scip VulDB"
HOMEPAGE="http://www.computec.ch/projekte/vulscan/"
SRC_URI="http://www.computec.ch/projekte/vulscan/download//nmap_nse_vulscan-${PV}.tar.gz"
#updated db at http://www.computec.ch/projekte/vulscan/download/scipvuldb.csv

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 arm"

DEPEND=""
RDEPEND="|| ( net-analyzer/nmap[lua] net-analyzer/nmap[nse] )"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/nmap/scripts/vulscan
	doins -r * || die "install failed"
}
