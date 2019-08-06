# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )

inherit python-r1

DESCRIPTION="This tool will parse a PDF document to identify the fundamental elements used"
HOMEPAGE="http://blog.didierstevens.com/programs/pdf-tools/"

MY_P=${PN}_V$(ver_rs 1- '_')
SRC_URI="http://www.didierstevens.com/files/software/${MY_P}.zip"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="unicode yara"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	yara? ( dev-python/yara-python[${PYTHON_USEDEP}] )"

S="${WORKDIR}"

src_prepare() {
	# Enable check maximum version of the python3
	sed -e 's/TestPythonVersion(enforceMaximumVersion=True)/# REM/' \
		-i pdf-parser.py || die 'sed failed!'

	# Fix encoding errors when reading files
	use unicode && eapply "${FILESDIR}/${PV}_define_encoding_format.patch"
	default
}

src_install() {
	python_foreach_impl python_doscript pdf-parser.py
}

pkg_postinst() {
	elog
	elog "See more: https://blog.didierstevens.com/2008/04/09/quickpost-about-the-physical-and-logical-structure-of-pdf-files/"
	elog
}
