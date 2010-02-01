# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs linux-info linux-mod eutils subversion

DESCRIPTION="DECT Sniffer"
HOMEPAGE="https://dedected.org"
SRC_URI=""
ESVN_REPO_URI="https://dedected.org/svn/trunk/com-on-air_cs-linux/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

BUILD_TARGETS="default"
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="com_on_air_cs(misc:${S})"

pkg_config() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KDIR=${KV_DIR}"
}

pkg_preinst() {
	enewgroup dect
}
src_compile() {
#	KDIR="${KV_DIR}" emake || die "emake failed"
	linux-mod_src_compile
	KDIR="${KV_DIR}" emake -C tools || die "emake tools failed"
	KDIR="${KV_DIR}" emake -C tools/dectshark || die "emake dectshark failed"

}

src_install () {
#	emake DESTDIR="${D}" install || die "emake install failed"
	linux-mod_src_install
	#we could add a group and when we add udev rules we may drop this stuff in bin instead
	dosbin tools/coa_syncsniff tools/dect_cli tools/dump_dip tools/dump_eeprom
	dosbin tools/pcap2cchan tools/pcapstein tools/dectshark/dectshark
	insinto /etc/udev/rules.d/
	doins "${FILESDIR}"/99-dect.rules
	exeinto /lib/udev/
	doexe "${FILESDIR}"/load-dect.sh
}

pkg_postinst() {
	linux-mod_pkg_postinst
	elog "If you want to sniff dect as a user add yourself to the dect group"
}
