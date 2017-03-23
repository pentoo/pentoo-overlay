# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1 python-utils-r1

DESCRIPTION="The Harvester is a tool designed to collect email accounts of the target domain"
HOMEPAGE="http://www.edge-security.com/theharvester.php"
SRC_URI="https://github.com/laramies/theHarvester/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	python_fix_shebang .

	#make it a module
	sed -e 's|from discovery|from theHarvester.discovery|' -i theHarvester.py || die "sed failed"
	sed -e 's|from lib|from theHarvester.lib|' -i theHarvester.py || die "sed failed"
	sed -e 's|from lib|from theHarvester.lib|' -i lib/htmlExport.py || die "sed failed"
	for i in discovery/*.py; do
		sed -e 's|import myparser|from theHarvester import myparser|' -i $i || die "sed for $i failed"
	done
	touch __init__.py

	default
}

src_install() {
	python_moduleinto ${PN}
	python_domodule __init__.py myparser.py discovery lib

#	old installation, just in case
#	insinto $(python_get_sitedir)
#	doins myparser.py
#	insinto $(python_get_sitedir)/discovery
#	doins -r discovery/*
#	insinto $(python_get_sitedir)/lib
#	doins lib/*.py

	newbin theHarvester.py theharvester
	dodoc README LICENSES
}
