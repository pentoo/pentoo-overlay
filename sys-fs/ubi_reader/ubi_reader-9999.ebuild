# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Reading information and extracting data from UBIFS images"
HOMEPAGE="https://github.com/jrspruitt/ubi_reader"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jrspruitt/ubi_reader"
	KEYWORDS=""
else
	MY_PV="${PV}-master"
	SRC_URI="https://github.com/jrspruitt/ubi_reader/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/${PN}-${MY_PV}
fi

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	dev-python/python-lzo[${PYTHON_USEDEP}]"
