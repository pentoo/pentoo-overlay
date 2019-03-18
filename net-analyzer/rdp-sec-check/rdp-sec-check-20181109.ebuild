# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN=github.com/portcullislabs/${PN}

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/portcullislabs/rdp-sec-check.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="595685769eea1c4e1dc4cb2a034d6ba7bddc8cb6"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Remote Desktop Protocol security settings checker"
HOMEPAGE="https://github.com/portcullislabs/rdp-sec-check"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-perl/Encoding-BER"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

src_install() {
	newbin ${PN}.pl ${PN}
}
