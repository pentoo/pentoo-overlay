# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

inherit python

MY_P="${PN}_V${PV//./_}"
SRC_URI="http://www.didierstevens.com/files/software/${MY_P}.zip"
DESCRIPTION="This tool will embed javascript inside a PDF document"
HOMEPAGE="http://blog.didierstevens.com/programs/pdf-tools/"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 arm ppc ppc64 x86"
IUSE=""
EAPI="2"
RDEPEND="virtual/python"
DEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	python_version
	insinto /usr/lib/python"${PYVER}"/site-packages/
	doins mPDF.py
	newbin "${PN}-javascript.py" "${PN}-javascript"
}
