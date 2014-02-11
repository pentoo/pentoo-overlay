# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

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

#FIXME add python3 support too

src_prepare() {
	sed -e 's/TestPythonVersion(enforceMaximumVersion=True)/# REM/' -i pdf-parser.py
}

src_install() {
	newbin "${PN}.py" "${PN}"
	python_fix_shebang "${ED}"usr/bin
}
