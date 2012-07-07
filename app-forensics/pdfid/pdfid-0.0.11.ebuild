# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="2"

MY_P="${PN}_v${PV//./_}"
SRC_URI="http://www.didierstevens.com/files/software/${MY_P}.zip"
DESCRIPTION="This tool will scan a PDF document looking for certain keyword"
HOMEPAGE="http://blog.didierstevens.com/programs/pdf-tools/"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 arm ppc ppc64 x86"
IUSE=""
RDEPEND=""
DEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	newbin "${PN}.py" "${PN}"
}
