# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake eutils multilib

DESCRIPTION="Wireshark plugin for SAP's protocols"
HOMEPAGE="https://github.com/CoreSecurity/SAP-Dissection-plug-in-for-Wireshark"
SRC_URI="https://github.com/CoreSecurity/SAP-Dissection-plug-in-for-Wireshark/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="net-analyzer/wireshark:="
DEPEND="${RDEPEND}"

S="${WORKDIR}/SAP-Dissection-plug-in-for-Wireshark-${PV}"

get_PV() { local pv=$(best_version $1); pv=${pv#$1-}; pv=${pv%-r*}; pv=${pv//_}; echo ${pv}; }

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_LIBDIR="/usr/$(get_libdir)/wireshark/plugins/$(get_PV net-analyzer/wireshark)"
	)

	cmake_src_configure
}
