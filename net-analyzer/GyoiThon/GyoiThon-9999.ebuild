# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit python-single-r1 git-r3

DESCRIPTION="The Harvester is a tool designed to collect email accounts of the target domain"
HOMEPAGE="http://www.edge-security.com/theharvester.php"
EGIT_REPO_URI="https://github.com/gyoisamurai/GyoiThon.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	>=dev-python/cchardet-2.1.4[${PYTHON_USEDEP}]
	>=dev-python/censys-0.0.8[${PYTHON_USEDEP}]
	>=dev-python/docopt-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.10.1[${PYTHON_USEDEP}]
	>=dev-python/msgpack-0.5.6[${PYTHON_USEDEP}]
	>=dev-python/pandas-0.22.0[${PYTHON_USEDEP}]
	>=dev-python/PySocks-1.6.7[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	>=dev-python/Scrapy-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/google-api-python-client-1.7.4[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	>=dev-python/networkx-2.2[${PYTHON_USEDEP}]

	dev-python/tldextract[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

src_prepare() {
	#relax deps
	sed -e 's|==.*||' -i requirements.txt || die "sed failed"
	sed '/metplotlib/d' -i requirements.txt || die "sed failed"
	eapply_user
}

#src_install() {
#	insinto $(python_get_sitedir)
#	doins myparser.py
#	insinto $(python_get_sitedir)/discovery
#	doins -r discovery/*
#	insinto $(python_get_sitedir)/lib
#	doins lib/*.py
#	newbin theHarvester.py theharvester
#	dodoc README.md LICENSES
#}
