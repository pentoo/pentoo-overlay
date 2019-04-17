# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1

DESCRIPTION="Credentials recovery project"
HOMEPAGE="https://github.com/AlessandroZ/LaZagne"
LICENSE="LGPL-3"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AlessandroZ/LaZagne"
else
	MY_PN="LaZagne"
	MY_P="${MY_PN}-${PV}"
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/AlessandroZ/LaZagne/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz"
	S="${WORKDIR}"/${MY_P}
fi

RESTRICT="mirror"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	dev-python/traceback2[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/memorpy[${PYTHON_USEDEP}]
	dev-python/configparser[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"

src_install() {
	dodoc README.md CHANGELOG

	python_foreach_impl python_domodule Linux/lazagne
	python_foreach_impl python_doscript Linux/laZagne.py

	make_wrapper \
		"${PN}" \
		"python2 /usr/bin/laZagne.py"
}

pkg_postinst() {
	elog
	elog "See documentation: https://github.com/AlessandroZ/LaZagne#usage"
	elog
}
