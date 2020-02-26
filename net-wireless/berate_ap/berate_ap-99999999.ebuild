# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 systemd

DESCRIPTION="Script for orchestrating mana rogue WiFi Access Points (fork create_ap)"
HOMEPAGE="https://github.com/sensepost/berate_ap"

if [[ $PV == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sensepost/berate_ap"
else
	HASH_COMMIT="8419908b79bae16ecb3567808e05639d4ab8dd6e"
	SRC_URI="https://github.com/sensepost/berate_ap/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="
	sys-apps/util-linux
	sys-process/procps
	net-wireless/hostapd-mana
	sys-apps/iproute2
	net-wireless/iw
	net-misc/bridge-utils
	net-dns/dnsmasq
	net-firewall/iptables"

src_compile() {
	:
}

src_install() {
	insinto "/etc"
	doins berate_ap.conf

	dobin berate_ap
	systemd_dounit berate_ap.service
	newbashcomp "${FILESDIR}"/bash_completion berate_ap

	dodoc -r howto README.md
}
