# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 toolchain-funcs

DESCRIPTION="BoNeSi - the DDoS Botnet Simulator"
HOMEPAGE="https://github.com/Markus-Go/bonesi"
SRC_URI=""

EGIT_REPO_URI="https://github.com/Markus-Go/bonesi.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/bonesi"
S="${WORKDIR}/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare(){
	# regenerate aclocal.m4 to support newer automake versions
	rm aclocal.m4 || die
	default
	eautoreconf
}
