# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit eutils python-single-r1

DESCRIPTION="Advanced XSS detection suite"
HOMEPAGE="https://github.com/s0md3v/XSStrike"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/s0md3v/XSStrike"
else
	SRC_URI="https://github.com/s0md3v/XSStrike/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/XSStrike-${PV}"

	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	$(python_gen_cond_dep '
		dev-python/tld[${PYTHON_MULTI_USEDEP}]
		dev-python/fuzzywuzzy[${PYTHON_MULTI_USEDEP}]
		dev-python/requests[${PYTHON_MULTI_USEDEP}]
		dev-python/selenium[${PYTHON_MULTI_USEDEP}]
	')"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	eapply "${FILESDIR}/disable_update_opt.patch"
	python_fix_shebang "${S}"
	default
}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r core/ db/ modes/ plugins/ "${PN}.py"

	python_optimize "${ED}/usr/share/${PN}"

	make_wrapper $PN \
		"${EPYTHON} /usr/share/${PN}/${PN}.py" \
		"/usr/share/${PN}"

	dodoc CHANGELOG.md README.md
}
