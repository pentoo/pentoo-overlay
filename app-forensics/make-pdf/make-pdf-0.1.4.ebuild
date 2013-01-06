# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit python eutils

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

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	edos2unix mPDF.py "${PN}-javascript.py"
	insinto /usr/lib/python"$(python_get_version)"/site-packages/
	doins mPDF.py
	newbin "${PN}-javascript.py" "${PN}-javascript"
	newbin "${PN}-embedded.py" "${PN}-embedded"
}
