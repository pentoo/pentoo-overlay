# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

HASH_COMMIT="0788b61205a52a5f1a65e4ed82e8fc65def38d98"

DESCRIPTION="The Harvester is a tool designed to collect email accounts of the target domain"
HOMEPAGE="http://www.edge-security.com/theharvester.php"
SRC_URI="https://github.com/laramies/theHarvester/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/censys[${PYTHON_USEDEP}]
	dev-python/plotly[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18.4[${PYTHON_USEDEP}]
	dev-python/shodan[${PYTHON_USEDEP}]
	dev-python/texttable[${PYTHON_USEDEP}]
	net-analyzer/wfuzz[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_prepare() {
#	python_fix_shebang .

	#make it a module
#	sed -e 's|from discovery|from theHarvester.discovery|' -i theHarvester.py || die "sed failed"
#	sed -e 's|from lib|from theHarvester.lib|' -i theHarvester.py || die "sed failed"
#	sed -e 's|import stash|import theHarvester.stash|' -i theHarvester.py || die "sed failed"
#	sed -e 's|from lib|from theHarvester.lib|' -i lib/htmlExport.py || die "sed failed"
#	for i in discovery/*.py; do
#		sed -e 's|import myparser|from theHarvester import myparser|' -i $i
#	done
#	touch __init__.py

	rm -r tests
	eapply_user
}


#src_install() {
#	python_moduleinto ${PN}
#	python_domodule __init__.py stash.py discovery lib parsers

#	newbin theHarvester.py theharvester
#	dodoc README.md LICENSES
#}
