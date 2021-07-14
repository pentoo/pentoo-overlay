# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit python-single-r1 git-r3

DESCRIPTION="GyoiThon is a growing penetration test tool using Machine Learning"
HOMEPAGE="https://github.com/gyoisamurai/GyoiThon"
EGIT_REPO_URI="https://github.com/gyoisamurai/GyoiThon.git"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/beautifulsoup:4[${PYTHON_MULTI_USEDEP}]
		dev-python/cchardet[${PYTHON_MULTI_USEDEP}]
		dev-python/censys[${PYTHON_MULTI_USEDEP}]
		dev-python/docopt[${PYTHON_MULTI_USEDEP}]
		dev-python/jinja[${PYTHON_MULTI_USEDEP}]
		dev-python/msgpack[${PYTHON_MULTI_USEDEP}]
		dev-python/pandas[${PYTHON_MULTI_USEDEP}]
		dev-python/PySocks[${PYTHON_MULTI_USEDEP}]
		dev-python/urllib3[${PYTHON_MULTI_USEDEP}]
		dev-python/Scrapy[${PYTHON_MULTI_USEDEP}]
		>=dev-python/google-api-python-client-1.7.4[${PYTHON_MULTI_USEDEP}]
		dev-python/matplotlib[${PYTHON_MULTI_USEDEP}]
		dev-python/networkx[${PYTHON_MULTI_USEDEP}]
		dev-python/tldextract[${PYTHON_MULTI_USEDEP}]
	')
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
