# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit python-r1 unpacker

DESCRIPTION="This tool will scan a PDF document looking for certain keyword"
HOMEPAGE="https://blog.didierstevens.com/programs/pdf-tools/"

MY_P="${PN}_v$(ver_rs 1- '_')"
SRC_URI="https://www.didierstevens.com/files/software/${MY_P}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

DEPEND="${PYTHON_DEPS}
	$(unpacker_src_uri_depends)"

RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}_pentoo.patch )

S="${WORKDIR}"

src_install() {
	insinto "/etc/${PN}"
	doins pdfid.ini

	insinto "/usr/share/${PN}"
	doins plugin_*

	python_foreach_impl python_newscript pdfid.py pdfid
}
