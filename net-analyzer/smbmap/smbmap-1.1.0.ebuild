# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit python-single-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ShawnDEvans/smbmap.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="b55fc051afa477943c017c5f0afe86e9e2f241ad"
	SRC_URI="https://github.com/ShawnDEvans/smbmap/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="SMBMap is a handy SMB enumeration tool"
HOMEPAGE="https://github.com/ShawnDEvans/smbmap"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-python/impacket-0.9.20[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

src_install() {
	newbin "${PN}.py" "${PN}"
}
