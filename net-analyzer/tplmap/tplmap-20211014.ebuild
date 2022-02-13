# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit python-single-r1

DESCRIPTION="Server-Side Template Injection and code injection tool"
HOMEPAGE="https://github.com/epinna/tplmap"

if [[ ${PV} = *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/epinna/tplmap.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="6f2150134dc637ff80478f623f28bb548ea2ca15"
	SRC_URI="https://github.com/epinna/tplmap/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/certifi[${PYTHON_USEDEP}]
		dev-python/chardet[${PYTHON_USEDEP}]
		dev-python/idna[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-5.1.2[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/urllib3[${PYTHON_USEDEP}]
	')"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	python_fix_shebang "${S}"
	default
}

src_install(){
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins -r *

	fperms +x /usr/share/${PN}/${PN}.py

	# tplmap needs to be run from its installation directory.
	insinto /usr/bin
	doins "${FILESDIR}/${PN}"
	fperms +x /usr/bin/${PN}
}
