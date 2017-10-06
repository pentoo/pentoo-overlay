# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 python-utils-r1

PYTHON_COMPAT=( python{2_7,3_6} )

DESCRIPTION="Targeted evil twin attacks against WPA2-Enterprise networks"
HOMEPAGE="https://github.com/s0lst1c3/eaphammer"
EGIT_REPO_URI="https://github.com/s0lst1c3/eaphammer.git"
EGIT_BRANCH="master"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
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

src_prepare() {
	if use systemd; then
		sed -i s/True/False/ ./config.py || die 'sed failed'
	fi
	sed -i s/network-manager/NetworkManager/ ./config.py || die 'sed failed'

	eapply_user
}
