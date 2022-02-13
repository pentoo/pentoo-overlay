# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit eutils python-single-r1

DESCRIPTION="Brute-Forcing from Nmap output using default creds"
HOMEPAGE="https://github.com/x90skysn3k/brutespray"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/x90skysn3k/brutespray"
else
	SRC_URI="https://github.com/x90skysn3k/brutespray/archive/${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 ~mips ~x86"
	S="${WORKDIR}/${PN}-${P}"
fi

LICENSE="MIT"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	$(python_gen_cond_dep 'dev-python/argcomplete[${PYTHON_USEDEP}]')"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	python_fix_shebang "${S}"
	default
}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r wordlist *.py

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper $PN \
		"${EPYTHON} /usr/share/${PN}/brutespray.py"

	dodoc *.md
}
