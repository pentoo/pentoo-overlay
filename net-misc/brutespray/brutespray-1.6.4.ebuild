# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit eutils python-single-r1

DESCRIPTION="Brute-Forcing from Nmap output - Automatically attempts default creds on found services"
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
SLOT=0

IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="${PYTHON_DEPS}
	dev-python/argcomplete[${PYTHON_USEDEP}]"

src_install() {
	insinto "/usr/share/${PN}"
	doins -r wordlist *.py

	python_optimize "${D}/usr/share/${PN}"

	make_wrapper $PN \
		"python2 /usr/share/${PN}/brutespray.py"

	dodoc *.md
}
