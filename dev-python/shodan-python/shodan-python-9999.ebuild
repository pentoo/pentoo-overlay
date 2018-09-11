# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_6} )
inherit distutils-r1 git-r3
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE=""
DESCRIPTION="The official Python library CLI for accessing Shodan.io security search engine for posible vulnerable boxes"


HOMEPAGE="https://github.com/achillean/shodan-python"

if [[ ${PV} == "9999" ]] ; then
	MY_P=${P}
	EGIT_REPO_URI="https://github.com/achillean/shodan-python.git"
	inherit git-r3
else
	MY_P=${PN}-${PV/_/-}
	SRC_URI="https://github.com/achillean/shodan-python/archive/v${PV}.tar.gz -> ${P}.tar.gz""
	
fi

# dev-python/click-plugins used to have dev-python/click as dep now have to set it 
DEPEND="
	dev-python/click
	dev-python/click-plugins
	dev-python/colorama
	>=dev-python/requests-2.2.1
	dev-python/xlsxwriter
"
RDEPEND="${DEPEND}"



pkg_postinst() {
    elog "documentation at http://shodan.readthedocs.io/en/latest/"
	elog "https://developer.shodan.io/ to get your api key etc." 
}