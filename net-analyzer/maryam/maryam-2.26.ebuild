# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9,10} )

inherit distutils-r1

DESCRIPTION="OWASP Maryam is a modular/optional open source OSINT and data gathering framework"
HOMEPAGE="https://owasp.org/www-project-maryam/"
SRC_URI="https://github.com/saeeddhqan/Maryam/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
# https://files.pythonhosted.org/packages/e5/43/7f4f96bfb7cba4dfa3d5313bb1604a0e1a9340f878bd7b1ea03602678624/maryam-2.2.6.post1.tar.gz
# https://github.com/saeeddhqan/Maryam/archive/refs/tags/v.2.2.6.tar.gz
LICENSE="GPL-2"
SLOT="0"



RDEPEND="dev-python/requests
	dev-python/cloudscraper  
	dev-python/beautifulsoup:4
	dev-python/flask 
	dev-python/lxml
	"

#### more deps as project grows. 
#Test_DEPEND # test? (dev-python/flake8 #   dev-python/black

#### gentoo-guru eselect repository enable guru ....
