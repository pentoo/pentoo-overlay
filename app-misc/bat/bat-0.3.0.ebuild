# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cargo

DESCRIPTION="cat which is bat"
HOMEPAGE="https://github.com/sharkdp/bat"
SRC_URI="https://github.com/sharkdp/bat/archive/v${PV}.tar.gz"
RESTRICT="mirror"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+fetch-crates"
DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	default
}
