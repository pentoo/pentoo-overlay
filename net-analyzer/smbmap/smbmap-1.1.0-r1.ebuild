# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit python-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ShawnDEvans/smbmap.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="${PV}"
	SRC_URI="https://github.com/ShawnDEvans/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="SMBMap is a handy SMB enumeration tool"
HOMEPAGE="https://github.com/ShawnDEvans/smbmap"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=">=dev-python/impacket-0.9.20
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pycryptodomex[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

src_install() {
	newbin "${PN}.py" "${PN}"
}
