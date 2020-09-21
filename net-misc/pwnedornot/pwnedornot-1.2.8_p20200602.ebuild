# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit python-r1

DESCRIPTION="OSINT Tool for Finding Passwords of Compromised Email Addresses Topics"
HOMEPAGE="https://github.com/thewhiteh4t/pwnedOrNot"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/thewhiteh4t/pwnedOrNot"
else
	# snapshot: 20200602
	COMMIT="4707b81716081f8be91bcaf3525a4210cafe7441"

	SRC_URI="https://github.com/thewhiteh4t/pwnedOrNot/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/pwnedOrNot-${COMMIT}"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/requests[${PYTHON_USEDEP}]"

src_install() {
	python_foreach_impl python_newscript pwnedornot.py ${PN}
	dodoc README.md Dockerfile
}
