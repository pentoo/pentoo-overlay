# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6}} )

inherit distutils-r1

DESCRIPTION="Software to identify the different types of hashes"
HOMEPAGE="http://psypanda.github.io/hashID"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/psypanda/hashID"
else
	MY_P="hashID-${PV}"
	SRC_URI="https://github.com/psypanda/hashID/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND=""

src_install() {
	doman doc/man/*
	dodoc doc/hashinfo.xlsx

	distutils-r1_src_install
}
