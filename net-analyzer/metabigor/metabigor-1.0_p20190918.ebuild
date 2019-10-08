# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit eutils python-single-r1

DESCRIPTION="Command line Search Engines Framework but without API key"
HOMEPAGE="https://github.com/j3ssie/Metabigor"

HASH_COMMIT="53648c9f464ea999bed0e5aea70ea94b4821f794"
SRC_URI="https://github.com/j3ssie/Metabigor/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT=0
#KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/PyGithub[${PYTHON_USEDEP}]
	dev-python/tldextract[${PYTHON_USEDEP}]
	www-apps/chromedriver-bin"

S="${WORKDIR}/Metabigor-${HASH_COMMIT}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	eapply "${FILESDIR}"/${P}_minor_changes.patch

	sed -e "s/^__version__ = '\(.*\)'/__version__ = '${PV}'/" \
		-i metabigor.py || die

	python_fix_shebang -q "${S}"
	default
}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r core/ modules/ metabigor.py sample-config.conf

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper $PN \
		"python3 /usr/share/${PN}/metabigor.py"

	dodoc README.md
}
