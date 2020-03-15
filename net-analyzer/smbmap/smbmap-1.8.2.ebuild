# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# TODO: add py3.* support
PYTHON_COMPAT=( python3_6 )

inherit python-r1

DESCRIPTION="SMBMap is a handy SMB enumeration tool"
HOMEPAGE="https://github.com/ShawnDEvans/smbmap"

if [[ ${PV} = *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ShawnDEvans/smbmap"
else
	SRC_URI="https://github.com/ShawnDEvans/smbmap/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	dev-python/impacket[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pycryptodomex[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_setup
}

src_install() {
	python_foreach_impl python_newscript ${PN}.py ${PN}
}
