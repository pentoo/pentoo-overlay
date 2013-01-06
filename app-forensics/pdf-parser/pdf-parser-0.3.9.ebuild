# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit python

MY_P="${PN}_V${PV//./_}"
SRC_URI="http://www.didierstevens.com/files/software/${MY_P}.zip"
DESCRIPTION="This tool will parse a PDF document to identify the fundamental elements used"
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

src_prepare() {
	sed -e 's/TestPythonVersion(enforceMaximumVersion=True)/# REM/' -i pdf-parser.py
}

src_install() {
	newbin "${PN}.py" "${PN}"
}
