# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 python-utils-r1

MY_P="${PN}_v${PV//./_}"
DESCRIPTION="This tool will scan a PDF document looking for certain keyword"
HOMEPAGE="http://blog.didierstevens.com/programs/pdf-tools/"
SRC_URI="https://www.didierstevens.com/files/software/${MY_P}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""
RDEPEND=""
DEPEND="app-arch/unzip"

S="${WORKDIR}"

src_prepare() {
	python_fix_shebang .
	default
}

src_install() {
	newbin "${PN}.py" "${PN}"
}
