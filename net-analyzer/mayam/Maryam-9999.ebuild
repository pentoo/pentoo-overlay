# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} ) 

inherit distutils-r1

DESCRIPTION="OWASP Maryam is a modular/optional open source OSINT and data gathering framework"
HOMEPAGE="https://owasp.org/www-project-maryam/"
#SRC_URI="https://github.com/saeeddhqan/Maryam/archive/${PV}.tar.gz -> ${P}.tar.gz"

if [ "${PV#9999}" != "${PV}" ] ; then
	SCM="git-r3"
	EGIT_REPO_URI="https://github.com/saeeddhqan/Maryam.git"
else
	SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
	#untested and broken. Do not use
	#KEYWORDS="amd64 ~arm64 ~x86 ~arm ~*"
fi

LICENSE="GPL-2"
SLOT="0"
#dev-python/plotly not stable
KEYWORDS="~amd64 ~x86"
# IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

# RESTRICT="!test? ( test )"

RDEPEND="${PYTHON_DEPS}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/cloudscraper[${PYTHON_USEDEP}]  
	#### gentoo-guru eselect repository enable guru / emerge -sync guru ,emerge -bavgk dev-python/cloudscraper
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}] 
	dev-python/lxml[${PYTHON_USEDEP}]
	"
#### more deps as project grows. 
DEPEND="${RDEPEND}"
	# test? (
	# 	dev-python/flake8[${PYTHON_USEDEP}]
	#   dev-python/black[${PYTHON_USEDEP}]
	# )"
	# 	dev-python/twine[${PYTHON_USEDEP}] publishing to pypi

# distutils_enable_tests pytest
src_prepare() {
	# network required for tests
	rm -r tests || die

	default
}