# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="BoNeSi - the DDoS botnet simulator"
HOMEPAGE="https://github.com/Markus-Go/bonesi"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Markus-Go/bonesi"
else
	SRC_URI="https://github.com/Markus-Go/bonesi/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RDEPEND="
	net-libs/libpcap
	net-libs/libnet:*"
DEPEND="${RDEPEND}"

src_prepare(){
	eautoreconf
	eapply_user
}
