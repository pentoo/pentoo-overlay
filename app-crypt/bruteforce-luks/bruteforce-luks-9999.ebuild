# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils autotools

DESCRIPTION="A bruteforce cracker for LUKS encrypted volumes"
HOMEPAGE="https://github.com/glv2/bruteforce-luks"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/glv2/bruteforce-luks"
else
	SRC_URI="https://github.com/glv2/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"

DEPEND="sys-fs/cryptsetup"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README )

src_prepare() {
	eautoreconf
	eapply_user
}
