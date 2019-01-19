# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGO_PN=github.com/google/${PN}

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~x86 ~arm ~arm64"
	EGIT_COMMIT="v${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi
inherit golang-build

DESCRIPTION="Provides packet processing capabilities for Go"
HOMEPAGE="https://github.com/google/gopacket"
LICENSE="BSD"
SLOT="0"
IUSE="pfring"

DEPEND="net-libs/libpcap
	pfring? ( dev-go/gopacket-pfring )"
RDEPEND="${DEPEND}"
