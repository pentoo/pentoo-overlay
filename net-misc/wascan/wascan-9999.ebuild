# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1

DESCRIPTION="Web Application Scanner"
HOMEPAGE="https://github.com/m4ll0k/WAScan"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/m4ll0k/WAScan"
else
	SRC_URI="https://github.com/m4ll0k/WAScan/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/WAScan-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]"

src_install() {
	local assets=(
		"lib"
		"plugins"
	)

	insinto /usr/share/${PN}
	for x in ${assets[@]} ${PN}.py; do
		doins -r ${x}
	done

	dodoc README.md
	make_wrapper \
		"${PN}" \
		"python2 /usr/share/${PN}/${PN}.py" \
		"/usr/share/${PN}/"
}
