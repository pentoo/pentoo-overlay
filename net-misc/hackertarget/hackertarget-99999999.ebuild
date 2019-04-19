# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1

DESCRIPTION="A security toolkit for organizations with attack surface discovery"
HOMEPAGE="https://github.com/ismailtasdelen/hackertarget"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ismailtasdelen/hackertarget"
else
	#snapshot
	HASH_COMMIT="4ecf1b245c7dc1a9bf15ce1a26cce1cbe537d0dd"
	SRC_URI="https://github.com/ismailtasdelen/hackertarget/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
fi

LICENSE="MIT"
RESTRICT="mirror"
SLOT="0"
DEPEND="${PYTHON_DEPS}
	dev-python/requests[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_install() {
	dodoc README.md

	python_foreach_impl python_doscript ${PN}.py
	make_wrapper \
		"hackertarget" \
		"python2 /usr/bin/${PN}.py"
}
