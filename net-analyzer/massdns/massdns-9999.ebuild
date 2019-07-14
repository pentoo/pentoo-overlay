# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR="emake"
CMAKE_IN_SOURCE_BUILD="true"

inherit cmake-utils

DESCRIPTION="A high-performance DNS stub resolver for bulk lookups and reconnaissance"
HOMEPAGE="https://github.com/blechschmidt/massdns"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/blechschmidt/massdns"
else
	HASH_COMMIT="68482ebdaab59373d034196828953ec7f633b076"
	SRC_URI="https://github.com/blechschmidt/massdns/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
fi

LICENSE="GPL-3"
SLOT=0
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	dobin ${PN}
	dodoc README.md Dockerfile

	insinto "/usr/share/${PN}"
	doins -r lists
	insopts -m755
	doins -r scripts
}
