# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-2 cmake-utils eutils multilib

DESCRIPTION="Wireshark plugin for SAP's protocols"
HOMEPAGE="https://github.com/CoreSecurity/SAP-Dissection-plug-in-for-Wireshark"
#SRC_URI="https://github.com/CoreSecurity/SAP-Dissection-plug-in-for-Wireshark/archive/v${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/CoreSecurity/SAP-Dissection-plug-in-for-Wireshark.git"
EGIT_BRANCH="wireshark-2.0"
EGIT_COMMIT="0ab6944f4c60a1e8a9ba360601464d5214b335b0"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND=">=net-analyzer/wireshark-2.0.0:="
DEPEND="${RDEPEND}"

S="${WORKDIR}/SAP-Dissection-plug-in-for-Wireshark-${PV}"

get_PV() { local pv=$(best_version $1); pv=${pv#$1-}; pv=${pv%-r*}; pv=${pv//_}; echo ${pv}; }

src_configure() {
	local mycmakeargs=(
	-DCMAKE_INSTALL_LIBDIR="/usr/$(get_libdir)/wireshark/plugins/$(get_PV net-analyzer/wireshark)"
	)
	cmake-utils_src_configure
}
