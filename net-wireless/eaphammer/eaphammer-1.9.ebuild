# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit python-utils-r1

#MY_PV=${PV/_beta/-beta}
MY_PV=2a88872bdf082a15df63885d47ab15dc1426a9a8
PYTHON_COMPAT=( python{2_7,3_5,3_6} )

DESCRIPTION="Targeted evil twin attacks against WPA2-Enterprise networks"
HOMEPAGE="https://github.com/s0lst1c3/eaphammer"
#SRC_URI="https://github.com/s0lst1c3/eaphammer/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="https://github.com/s0lst1c3/eaphammer/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE="systemd"

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/tqdm
	net-dns/dnsmasq
	net-libs/libnfnetlink
	dev-libs/libnl:3
	net-wireless/hostapd[wpe]
	net-analyzer/dsniff
	virtual/httpd-basic
	"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	if use !systemd; then
		sed -i "s|use_systemd = True|use_systemd = False|" settings/core/eaphammer.ini || die 'sed failed'
	fi
	sed -i s/network-manager/NetworkManager/ settings/core/eaphammer.ini || die 'sed failed'
	eapply_user
}

#FIXME
#src_install
#https://github.com/s0lst1c3/eaphammer/issues/73
