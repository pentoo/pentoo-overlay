# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit python-single-r1 python-utils-r1

HASH_COMMIT="90846b0f151eaa90966193d0636b60d5143ecaba"

DESCRIPTION="The Harvester is a tool designed to collect email accounts of the target domain"
HOMEPAGE="http://www.edge-security.com/theharvester.php"
SRC_URI="https://github.com/laramies/theHarvester/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="net-analyzer/wfuzz[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18.4[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

src_prepare() {
	python_fix_shebang .

	#make it a module
	sed -e 's|from discovery|from theHarvester.discovery|' -i theHarvester.py || die "sed failed"
	sed -e 's|from lib|from theHarvester.lib|' -i theHarvester.py || die "sed failed"
	sed -e 's|import stash|import theHarvester.stash|' -i theHarvester.py || die "sed failed"
	sed -e 's|from lib|from theHarvester.lib|' -i lib/htmlExport.py || die "sed failed"
#	for i in discovery/*.py; do
#		sed -e 's|import myparser|from theHarvester import myparser|' -i $i
#	done
	touch __init__.py

	default
}

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_install() {
	python_moduleinto ${PN}
	python_domodule __init__.py stash.py discovery lib parsers

#	old installation, just in case
#	insinto $(python_get_sitedir)
#	doins myparser.py
#	insinto $(python_get_sitedir)/discovery
#	doins -r discovery/*
#	insinto $(python_get_sitedir)/lib
#	doins lib/*.py

	newbin theHarvester.py theharvester
	dodoc README.md LICENSES
}
