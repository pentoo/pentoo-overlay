# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib

DESCRIPTION="a collection of traffic analysis Wireshark plugins focused on security"
HOMEPAGE="https://github.com/pentesteracademy/patoolkit"
HASH_COMMIT="36e83b7200d1ee8e03e01ae5d827fa195449538c"
SRC_URI="https://github.com/pentesteracademy/patoolkit/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#https://github.com/pentesteracademy/patoolkit/issues/4
#KEYWORDS="~amd64 ~arm ~x86"

RDEPEND=">=net-analyzer/wireshark-2.6:="
DEPEND="${RDEPEND}"

S="${WORKDIR}/patoolkit-${HASH_COMMIT}"

get_PV() {
	local pv=$(best_version $1)
	pv=${pv#$1-}; pv=${pv%-r*}
	pv=${pv//_}; echo ${pv}
}

src_prepare() {
	mkdir plugins/patoolkit_libs
	mv plugins/util.lua plugins/patoolkit_libs
	mv plugins/wifi/security.lua plugins/patoolkit_libs
	eapply_user
}

src_install() {
	#local WS_PLUGIN_DIR="/usr/$(get_libdir)/wireshark/plugins/$(get_PV net-analyzer/wireshark)/patoolkit/"
	#lue scripts must be just in "plugin" folder
	local WS_PLUGIN_DIR="/usr/$(get_libdir)/wireshark/plugins/$(get_PV net-analyzer/wireshark)/patoolkit/"
	dodir $WS_PLUGIN_DIR
	cp -R "${S}"/plugins/* ${ED}/$WS_PLUGIN_DIR  || die "Copy files failed"
}
