# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit python-any-r1

DESCRIPTION="Targeted evil twin attacks against WPA2-Enterprise networks"
HOMEPAGE="https://github.com/s0lst1c3/eaphammer"
SRC_URI="https://github.com/s0lst1c3/eaphammer/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE="systemd"

RDEPEND="$( python_gen_any_dep '
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	net-analyzer/scapy[${PYTHON_USEDEP}] ')
	net-dns/dnsmasq
	net-libs/libnfnetlink
	dev-libs/libnl:3
	net-wireless/hostapd[wpe]
	net-analyzer/dsniff
	virtual/httpd-basic"
DEPEND="${RDEPEND}"

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
