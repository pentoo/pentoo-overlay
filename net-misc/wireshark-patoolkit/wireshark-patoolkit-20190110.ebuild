# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib

DESCRIPTION="a collection of traffic analysis Wireshark plugins focused on security"
HOMEPAGE="https://github.com/pentesteracademy/patoolkit"
HASH_COMMIT="7db1e070926aab40a93abe86da1c18bd46560e95"
SRC_URI="https://github.com/pentesteracademy/patoolkit/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
#branch: https://github.com/pentesteracademy/patoolkit/tree/global-plugins

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND=">=net-analyzer/wireshark-2.6:="
DEPEND="${RDEPEND}"

S="${WORKDIR}/patoolkit-${HASH_COMMIT}"

get_PV() {
	local pv=$(best_version $1)
	pv=${pv#$1-}; pv=${pv%-r*}
	pv=${pv//_}; echo ${pv}
}

src_install() {
	#local WS_PLUGIN_DIR="/usr/$(get_libdir)/wireshark/plugins/$(get_PV net-analyzer/wireshark)/patoolkit/"
	#lue scripts must be just in "plugin" folder
	local WS_PLUGIN_DIR="/usr/$(get_libdir)/wireshark/plugins/patoolkit/"
	dodir $WS_PLUGIN_DIR
	cp -R "${S}"/plugins/* "${ED}/$WS_PLUGIN_DIR"  || die "Copy files failed"
	doenvd "${FILESDIR}"/92patoolkit
}

pkg_postinst() {
	elog "Please run 'env-update' and '. /etc/profile' or re-login after the first install,"
	elog "otherwise you may be missing required environmental variables"
}
