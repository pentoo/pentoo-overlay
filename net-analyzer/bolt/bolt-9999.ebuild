# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )

inherit eutils python-single-r1

DESCRIPTION="CSRF Scanner"
HOMEPAGE="https://github.com/s0md3v/Bolt"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/s0md3v/Bolt"
else
	SRC_URI="https://github.com/s0md3v/Bolt/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/Bolt-${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	$(python_gen_cond_dep '
		dev-python/numpy[${PYTHON_MULTI_USEDEP}]
		dev-python/fuzzywuzzy[${PYTHON_MULTI_USEDEP}]
		dev-python/tld[${PYTHON_MULTI_USEDEP}]
		dev-python/requests[${PYTHON_MULTI_USEDEP}]
		dev-python/python-levenshtein[${PYTHON_MULTI_USEDEP}]
		sci-libs/scipy[${PYTHON_MULTI_USEDEP}]
	')"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	python_fix_shebang "${S}"
	default
}

src_install() {
	dodoc README.md

	insinto "/usr/share/${PN}"
	doins -r core/ db/ *.py

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper "${PN}-analyzer" \
		"${EPYTHON} /usr/share/${PN}/${PN}.py" \
		"/usr/share/${PN}"
}

pkg_postinst() {
	einfo "\nSee documentation: https://github.com/s0md3v/Photon/wiki#usage/\n"
}
