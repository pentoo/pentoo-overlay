# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
EGO_PN=github.com/droope/${PN}

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/droope/droopescan.git"
        KEYWORDS=""
else
        KEYWORDS="~amd64 ~x86"
        EGIT_COMMIT="${PV}"
        SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="A scanner that helps identifying issues in Drupal, SilverStripe, and Wordpress."
HOMEPAGE="https://github.com/droope/droopescan"

LICENSE="AGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/beautifulsoup-4.5.1
		>=dev-python/cement-2.6
		dev-python/coverage
		dev-python/lxml
		dev-python/mock
		dev-python/nose
		dev-python/responses
		dev-python/retrying
		dev-python/wheel"
DEPEND="${RDEPEND}"

#S="${WORKDIR}/python-${PN}-${EGIT_COMMIT}"

