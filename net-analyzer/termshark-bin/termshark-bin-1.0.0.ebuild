# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A terminal UI for tshark, inspired by Wireshark"
HOMEPAGE="https://termshark.io/ https://github.com/gcla/termshark"

SRC_URI="
	amd64? ( https://github.com/gcla/termshark/releases/download/v${PV}/termshark_${PV}_linux_x64.tar.gz -> ${P}-amd64.tar.gz )
	arm? ( https://github.com/gcla/termshark/releases/download/v${PV}/termshark_${PV}_linux_armv6.tar.gz -> ${P}-arm.tar.gz )"

KEYWORDS="-* ~amd64 ~arm"
LICENSE="MIT"
SLOT="0"

RDEPEND="!net-analyzer/termshark
	net-analyzer/wireshark[dumpcap,pcap,tshark]"

S="${WORKDIR}"/termshark_${PV}_linux_x64

src_install() {
	dobin ${PN%%-bin}
}

pkg_postinst() {
	elog "\nSee documentation: https://github.com/gcla/termshark/blob/master/docs/UserGuide.md\n"
}
