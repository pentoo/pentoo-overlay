# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6} )

inherit eutils python-single-r1

DESCRIPTION="File upload vulnerability scanner and exploitation tool"
HOMEPAGE="https://github.com/almandin/fuxploider"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/almandin/fuxploider"
else
	SRC_URI="https://github.com/almandin/fuxploider/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64"
fi

LICENSE="GPL-3"
SLOT=0
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/coloredlogs[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	python_fix_shebang "${S}"
	find "${S}" -name '__pycache__' -prune -exec rm -rf {} \; \
		|| die "cleaning __pycache__ failed"

	default
}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r *

	make_wrapper "fuxploider" \
		"python3 /usr/share/${PN}/fuxploider.py" \
		"/usr/share/${PN}"

	dodoc README.md

	python_optimize "${D}/usr/share/${PN}"
}
