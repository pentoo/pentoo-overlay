# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{5,6,7} )

inherit eutils python-r1

DESCRIPTION="Incredibly fast crawler designed for OSINT"
HOMEPAGE="https://github.com/s0md3v/Photon"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/s0md3v/Photon"
else
	SRC_URI="https://github.com/s0md3v/Photon/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}"/Photon-${PV}
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/tld[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"

pkg_setup() {
	python_setup
}

src_install() {
	insinto "/usr/share/${PN}"
	for x in core plugins *.py; do
		doins -r "${x}"
	done

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper "${PN}" \
		"python3 /usr/share/${PN}/${PN}.py"
}

pkg_postinst() {
	elog "\nSee documentation: https://github.com/s0md3v/Photon/wiki#usage/\n"
}
