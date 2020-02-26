# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{5,6,7} )

inherit eutils python-r1

DESCRIPTION="Scanning tool which discovers dirs found in javascript files hosted on a website"
HOMEPAGE="https://github.com/Cillian-Collins/dirscraper"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Cillian-Collins/dirscraper"
else
	# snapshot: 20190224
	HASH_COMMIT="e752450d996a22ccbb8a94ee576a7be51e59f95b"

	SRC_URI="https://github.com/Cillian-Collins/dirscraper/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]"

src_prepare() {
	sed -e "1i #!/usr/bin/env python3" \
		-i *.py || die

	default
}

src_install() {
	dodoc README.md
	python_foreach_impl python_doscript ${PN}.py

	make_wrapper "${PN}" \
		"python3 /usr/bin/${PN}.py"
}
