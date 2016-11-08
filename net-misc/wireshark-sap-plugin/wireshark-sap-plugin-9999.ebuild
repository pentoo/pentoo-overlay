# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils eutils multilib git-r3

DESCRIPTION="Wireshark plugin for SAP's protocols"
HOMEPAGE="https://github.com/CoreSecurity/SAP-Dissection-plug-in-for-Wireshark"
EGIT_REPO_URI="https://github.com/CoreSecurity/SAP-Dissection-plug-in-for-Wireshark.git"
EGIT_BRANCH="wireshark-2.2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="=net-analyzer/wireshark-2.2*:="
DEPEND="${RDEPEND}"

get_PV() { local pv=$(best_version $1); pv=${pv#$1-}; pv=${pv%-r*}; pv=${pv//_}; echo ${pv}; }

src_configure() {
	local mycmakeargs=(
	-DCMAKE_INSTALL_LIBDIR="/usr/$(get_libdir)/wireshark/plugins/$(get_PV net-analyzer/wireshark)"
	)
	cmake-utils_src_configure
}
