# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 eutils 
#python-utils-r1

MY_P="${PN}_V${PV//./_}"
SRC_URI="http://www.didierstevens.com/files/software/${MY_P}.zip"
DESCRIPTION="This tool will embed javascript inside a PDF document"
HOMEPAGE="http://blog.didierstevens.com/programs/pdf-tools/"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""
RDEPEND=""
DEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	edos2unix mPDF.py "${PN}-javascript.py"
	insinto "$(python_get_sitedir)"
	doins mPDF.py
	python_fix_shebang "${PN}-javascript.py" "${PN}-embedded.py"
	newbin "${PN}-javascript.py" "${PN}-javascript"
	newbin "${PN}-embedded.py" "${PN}-embedded"
}
