# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_6 )
EGO_PN=github.com/Nekmo/${PN}

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Nekmo/dirhunt.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Dirhunt is a web crawler optimized for searching and analyzing web directories."
HOMEPAGE="https://github.com/Nekmo/dirhunt"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/beautifulsoup-4.5.1
	dev-python/click
	dev-python/colorama
	dev-python/humanize
	dev-python/requests
	dev-python/requests-mock"
DEPEND="${RDEPEND}"
