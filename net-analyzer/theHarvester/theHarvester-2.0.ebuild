# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

SUPPORT_PYTHON_ABIS="1"

inherit python

DESCRIPTION="The Harvester is a tool designed to collect email accounts of the target domain"
HOMEPAGE="http://www.edge-security.com/theHarvester.php"
SRC_URI="http://www.edge-security.com/soft/${PN}-ng-${PV}.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}"/"${PN}-ng"

src_prepare() {
	python_convert_shebangs 2 theHarvester.py;

	# Default parser should not be overloaded. Bug in theHarvester, reported
	# upstream, but workaround for now.
	sed -i s/'import parser'/'import theHarvesterparser'/ "${S}/discovery/bingsearch.py"
	sed -i s/'parser.parser'/'theHarvesterparser.theHarvesterparser'/ "${S}/discovery/bingsearch.py"
	sed -i s/'import parser'/'import theHarvesterparser'/ "${S}/discovery/exaleadsearch.py"
	sed -i s/'parser.parser'/'theHarvesterparser.theHarvesterparser'/ "${S}/discovery/exaleadsearch.py"
	sed -i s/'import parser'/'import theHarvesterparser'/ "${S}/discovery/googlesearch.py"
	sed -i s/'parser.parser'/'theHarvesterparser.theHarvesterparser'/ "${S}/discovery/googlesearch.py"
	sed -i s/'import parser'/'import theHarvesterparser'/ "${S}/discovery/linkedinsearch.py"
	sed -i s/'parser.parser'/'theHarvesterparser.theHarvesterparser'/ "${S}/discovery/linkedinsearch.py"
	sed -i s/'import parser'/'import theHarvesterparser'/ "${S}/discovery/pgpsearch.py"
	sed -i s/'parser.parser'/'theHarvesterparser.theHarvesterparser'/ "${S}/discovery/pgpsearch.py"
	sed -i s/'import parser'/'import theHarvesterparser'/ "${S}/discovery/yandexsearch.py"
	sed -i s/'parser.parser'/'theHarvesterparser.theHarvesterparser'/ "${S}/discovery/yandexsearch.py"

	sed -i s/'class parser:'/'class theHarvesterparser:'/ "${S}/parser.py"
}

src_install() {
	installation() {
		insinto $(python_get_sitedir)
		mv parser.py theHarvesterparser.py
		doins theHarvesterparser.py
		doins hostchecker.py
		insinto $(python_get_sitedir)/discovery
		doins discovery/*.py
	}
python_execute_function installation
dobin theHarvester.py
}

pkg_postinst() {
	python_mod_optimize discovery hostchecker.py theHarvesterparser.py
}

pkg_postrm() {
	python_mod_cleanup discovery hostchecker.py theHarvesterparser.py
}
