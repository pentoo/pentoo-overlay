#Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#Thank You to Zero_Chaos for the encouragement & Arfrever for unfucking my
#fuckery

EAPI=6
#PYTHON_DEPEND="2"
#SUPPORT_PYTHON_ABIS="1"
#RESTRICT_PYTHON_ABIS="3.*"

inherit git-r3
#FIXME: migrate to new python eclass
#inherit python git-2

DESCRIPTION="Wordpress finger printing tool, retrieve information about the plugins and versions installed"
HOMEPAGE="http://www.iniqua.com/labs/plecost/"

EGIT_REPO_URI="https://github.com/iniqua/plecost.git"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/beautifulsoup:python-2"
RDEPEND="${DEPEND}"

src_prepare() {
	# Delete internal copy of dev-python/beautifulsoup.
	rm -f xgoogle/BeautifulSoup.py
}

src_install() {
	installation() {
	mkdir -p "${T}/images/${PYTHON_ABI}${EPREFIX}/usr/bin"
	cp plecost.py "${T}/images/${PYTHON_ABI}${EPREFIX}/usr/bin/plecost"

	insinto $(python_get_sitedir)
	doins -r xgoogle
	}

	python_execute_function installation
	python_merge_intermediate_installation_images "${T}/images"

	# wordpress plugin list
	insinto /usr/share/plecost
	doins wp_plugin_list.txt

	dodoc README CVE.dat
}

pkg_postinst(){
	python_mod_optimize xgoogle
}

pkg_postrm(){
	python_mod_cleanup xgoogle
}
