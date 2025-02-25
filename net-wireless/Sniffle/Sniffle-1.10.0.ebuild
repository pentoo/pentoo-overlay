# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit python-single-r1

DESCRIPTION="A sniffer for Bluetooth 5 and 4.x LE"
HOMEPAGE="https://github.com/nccgroup/Sniffle"

SRC_URI="https://github.com/nccgroup/Sniffle/archive/v${PV}.tar.gz -> ${P}.tar.gz \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc1352p1_cc2652p1.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc1352p1_cc2652p1_1M.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc1352p7.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc1352r1.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc1354p10.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc2651p3.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc2652r1.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc2652r7.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc2652rb.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc2652rb_1M.hex"
LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="$(python_gen_cond_dep 'dev-python/cc2538-bsl[${PYTHON_USEDEP}]')
	${PYTHON_DEPS}"

src_install() {
	insinto "/usr/share/${PN}"
	doins "${DISTDIR}/sniffle_cc1352p1_cc2652p1.hex"
	doins "${DISTDIR}/sniffle_cc1352p1_cc2652p1_1M.hex"
	doins "${DISTDIR}/sniffle_cc1352p7.hex"
	doins "${DISTDIR}/sniffle_cc1352r1.hex"
	doins "${DISTDIR}/sniffle_cc1354p10.hex"
	doins "${DISTDIR}/sniffle_cc2651p3.hex"
	doins "${DISTDIR}/sniffle_cc2652r1.hex"
	doins "${DISTDIR}/sniffle_cc2652r7.hex"
	doins "${DISTDIR}/sniffle_cc2652rb.hex"
	doins "${DISTDIR}/sniffle_cc2652rb_1M.hex"

	insinto "/usr/$(get_libdir)/wireshark/extcap"
	doins python_cli/*.py
	exeinto "/usr/$(get_libdir)/wireshark/extcap"
	doexe python_cli/sniffle_extcap.py
}

pkg_postinst() {
	einfo "Pre-compiled firmwares from upstream are installed in /usr/share/${PN}"
}
