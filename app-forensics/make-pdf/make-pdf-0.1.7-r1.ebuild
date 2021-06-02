# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit python-r1 unpacker

DESCRIPTION="This tool will embed javascript inside a PDF document"
HOMEPAGE="https://blog.didierstevens.com/programs/pdf-tools/"

MY_P="${PN}_V$(ver_rs 1- '_')"
SRC_URI="https://www.didierstevens.com/files/software/${MY_P}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND=""
DEPEND="${PYTHON_DEPS}
	$(unpacker_src_uri_depends)"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S="${WORKDIR}"

src_prepare() {
	sed -e "1i #!\/usr\/bin\/python\\n" \
		-i make-pdf-helloworld.py || die

	default
}

src_install() {
	python_foreach_impl python_domodule mPDF.py

	for x in make-pdf-*.py; do
		python_foreach_impl python_newscript $x ${x%.py}
	done
}
