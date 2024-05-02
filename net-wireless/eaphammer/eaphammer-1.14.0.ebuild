# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit python-r1

DESCRIPTION="Targeted evil twin attacks against WPA2-Enterprise networks"
HOMEPAGE="https://github.com/s0lst1c3/eaphammer"
SRC_URI="https://github.com/s0lst1c3/eaphammer/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

# see pip.req
RDEPEND="$( python_gen_any_dep '
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	net-analyzer/scapy[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/pyquery[${PYTHON_USEDEP}]
	dev-python/requests-html[${PYTHON_USEDEP}]
	dev-python/flask-cors[${PYTHON_USEDEP}]
	dev-python/flask-socketio[${PYTHON_USEDEP}]
	')

	net-dns/dnsmasq
	net-libs/libnfnetlink
	dev-libs/libnl:3
	net-wireless/hostapd[wpe]

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
