# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit eutils python-single-r1

DESCRIPTION="Tool to scan for sensitive information within public GitHub repositories"
HOMEPAGE="https://github.com/hisxo/gitGraber"

if [[ ${PV} = *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hisxo/gitGraber.git"
else
	HASH_COMMIT="4bef12f17077c3bc328a25d668326c8388e03e14"

	SRC_URI="https://github.com/hisxo/gitGraber/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		>=dev-python/argcomplete-1.10.0[${PYTHON_USEDEP}]
		>=dev-python/python-crontab-2.3.9[${PYTHON_USEDEP}]
		>=dev-python/requests-2.18.4[${PYTHON_USEDEP}]
		>=dev-python/termcolor-1.1.0[${PYTHON_USEDEP}]
	')"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}_change_defaults.patch" )

MY_PN="gitGraber"

S="${WORKDIR}/${MY_PN}-${HASH_COMMIT}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	python_fix_shebang "${S}"
}

src_install() {
	insinto /usr/share/${PN}
	doins -r *.py wordlists rawGitUrls.txt

	python_optimize "${D}/usr/share/${PN}"

	# s3scanner needs to be run from its installation directory.
	make_wrapper $PN \
		"${EPYTHON} /usr/share/${PN}/${MY_PN}.py"

	dodoc README.md
}
