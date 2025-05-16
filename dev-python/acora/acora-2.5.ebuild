# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

MY_PV="acora-${P}-2"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/scoder/acora.git"
else
	HASH_COMMIT="${MY_PV}"
	#SRC_URI="https://github.com/scoder/acora/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	SRC_URI="https://github.com/scoder/acora/archive/refs/tags/${P}-2.tar.gz -> ${P}.gh.tar.gz"
fi

DESCRIPTION="Fast multi-keyword search engine for text strings"
HOMEPAGE="https://github.com/scoder/acora"

S="${WORKDIR}/${MY_PV}"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
"
