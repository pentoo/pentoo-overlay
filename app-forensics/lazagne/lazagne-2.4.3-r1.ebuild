# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
PYTHON_REQ_USE="sqlite"

inherit python-r1

DESCRIPTION="Credentials recovery project"
HOMEPAGE="https://github.com/AlessandroZ/LaZagne"

# LGPL-3 — *
# GPL-3 — Linux/lazagne/config/lib/memorpy/*
# MIT — Linux/lazagne/config/crypto/*
LICENSE="LGPL-3 GPL-3 MIT"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/AlessandroZ/LaZagne"
else
	SRC_URI="https://github.com/AlessandroZ/LaZagne/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/LaZagne-${PV}"
fi

SLOT="0"

# using bundled memorypy instead dev-python/memorpy
RDEPEND="${PYTHON_DEPS}
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${P}_fix_attributeerror.patch )

src_install() {
	dodoc README.md CHANGELOG

	python_foreach_impl python_domodule Linux/lazagne
	python_foreach_impl python_newscript Linux/laZagne.py lazagne
}
