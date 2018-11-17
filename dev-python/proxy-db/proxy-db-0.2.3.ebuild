# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_6 )
EGO_PN=github.com/Nekmo/${PN}

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Nekmo/proxy-db.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Manage free and private proxies on local db for Python Projects"
HOMEPAGE="https://github.com/Nekmo/proxy-db"
#S="${WORKDIR}/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND=">=dev-python/beautifulsoup-4.5.1
		dev-python/click
		dev-python/geoip2-python
		dev-python/requests
		dev-python/sqlalchemy"
DEPEND="${RDEPEND}"

python_prepare_all() {
	distutils-r1_python_prepare_all
	# remove package of tests to avoid installing it
	rm "${S}/tests/__init__.py"
}
