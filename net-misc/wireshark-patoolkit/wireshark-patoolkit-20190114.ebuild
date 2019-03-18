# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib

DESCRIPTION="a collection of traffic analysis Wireshark plugins focused on security"
HOMEPAGE="https://github.com/pentesteracademy/patoolkit"
HASH_COMMIT="e14245f2e09988f0c5db3dee18643b919aadcc59"
SRC_URI="https://github.com/pentesteracademy/patoolkit/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND=">=net-analyzer/wireshark-2.6:="
DEPEND="${RDEPEND}"

S="${WORKDIR}/patoolkit-${HASH_COMMIT}"

src_install() {
	#lue scripts must be in the "plugins" folder
	local WS_PLUGIN_DIR="/usr/$(get_libdir)/wireshark/plugins/patoolkit/"
	dodir $WS_PLUGIN_DIR
	cp -R "${S}"/plugins/* "${ED}/$WS_PLUGIN_DIR"  || die "Copy files failed"
	doenvd "${FILESDIR}"/92patoolkit
}

pkg_postinst() {
	elog "Please run 'env-update' and '. /etc/profile' or re-login after the first install,"
	elog "otherwise you may be missing required environmental variables"
}
