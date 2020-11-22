# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
EGO_PN=github.com/MarioVilas/googlesearch

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MarioVilas/googlesearch.git"
	KEYWORDS=""
else
	KEYWORDS="amd64 ~arm64 x86"
	EGIT_COMMIT="bce138ac60572bc624a477cdeb553f4b52cf3307"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Google search from Python"
HOMEPAGE="https://github.com/MarioVilas/googlesearch"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="BSD"
SLOT="0"
IUSE=""

RDEPEND=">=dev-python/beautifulsoup-4.5.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
