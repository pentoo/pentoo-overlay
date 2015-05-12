# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A NSE vulnerability scanner which uses an offline version of different vulnerability databases"
HOMEPAGE="http://www.scip.ch/"
SRC_URI="http://www.computec.ch/mruef/software/nmap_nse_vulscan-${PV}.tar.gz"
#updated db: http://www.scip.ch/vuldb/scipvuldb.csv

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 arm"

DEPEND=""
RDEPEND="|| ( net-analyzer/nmap[lua] net-analyzer/nmap[nse] )"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/nmap/scripts/vulscan
	doins -r * || die "install failed"
}
