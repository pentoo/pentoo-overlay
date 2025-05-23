# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit python-r1

DESCRIPTION="A OSINT tool to obtain a target's phone number just by having his email address"
HOMEPAGE="https://github.com/martinvigo/email2phonenumber"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/martinvigo/email2phonenumber"
else
	HASH_COMMIT="28c277ebb8c1185d639ce21dab897b6300153042"
	SRC_URI="https://github.com/martinvigo/email2phonenumber/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
fi

LICENSE="MIT"
SLOT=0
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]"

src_install() {
	python_foreach_impl python_newscript email2phonenumber.py email2phonenumber
	dodoc README.md
}

pkg_postinst() {
	einfo "\nMore: https://www.martinvigo.com/email2phonenumber\n"
}
