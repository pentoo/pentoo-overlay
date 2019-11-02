# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
EGO_PN=github.com/ShawnDEvans/${PN}

inherit python-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/madengr/ham2mon.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="SMBMap is a handy SMB enumeration tool."
HOMEPAGE="https://github.com/ShawnDEvans/smbmap"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	newbin "${PN}.py" "${PN}"
}
