# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit python-single-r1

DESCRIPTION="A sniffer for Bluetooth 5 and 4.x LE"
HOMEPAGE="https://github.com/nccgroup/Sniffle"

SRC_URI="https://github.com/nccgroup/Sniffle/archive/v${PV}.tar.gz -> ${P}.tar.gz \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc1352p1_cc2652p1.hex -> sniffle-${PV}_cc1352p1_cc2652p1.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc1352p1_cc2652p1_1M.hex -> sniffle-${PV}_cc1352p1_cc2652p1_1M.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc1352p7.hex -> sniffle-${PV}_cc1352p7.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc1352r1.hex -> sniffle-${PV}_cc1352r1.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc1354p10.hex -> sniffle-${PV}_cc1354p10.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc2651p3.hex -> sniffle-${PV}_cc2651p3.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc2652r1.hex -> sniffle-${PV}_cc2652r1.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc2652r7.hex -> sniffle-${PV}_cc2652r7.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc2652rb.hex -> sniffle-${PV}_cc2652rb.hex \
	https://github.com/nccgroup/Sniffle/releases/download/v${PV}/sniffle_cc2652rb_1M.hex -> sniffle-${PV}_cc2652rb_1M.hex"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="$(python_gen_cond_dep 'dev-python/cc2538-bsl[${PYTHON_USEDEP}]')
	${PYTHON_DEPS}"

src_install() {
	insinto "/usr/share/${PN}"
	newins "${DISTDIR}/sniffle-${PV}_cc1352p1_cc2652p1.hex" "sniffle_cc1352p1_cc2652p1.hex"
	newins "${DISTDIR}/sniffle-${PV}_cc1352p1_cc2652p1_1M.hex" "sniffle_cc1352p1_cc2652p1_1M.hex"
	newins "${DISTDIR}/sniffle-${PV}_cc1352p7.hex" "sniffle_cc1352p7.hex"
	newins "${DISTDIR}/sniffle-${PV}_cc1352r1.hex" "sniffle_cc1352r1.hex"
	newins "${DISTDIR}/sniffle-${PV}_cc1354p10.hex" "sniffle_cc1354p10.hex"
	newins "${DISTDIR}/sniffle-${PV}_cc2651p3.hex" "sniffle_cc2651p3.hex"
	newins "${DISTDIR}/sniffle-${PV}_cc2652r1.hex" "sniffle_cc2652r1.hex"
	newins "${DISTDIR}/sniffle-${PV}_cc2652r7.hex" "sniffle_cc2652r7.hex"
	newins "${DISTDIR}/sniffle-${PV}_cc2652rb.hex" "sniffle_cc2652rb.hex"
	newins "${DISTDIR}/sniffle-${PV}_cc2652rb_1M.hex" "sniffle_cc2652rb_1M.hex"

	insinto "/usr/$(get_libdir)/wireshark/extcap"
	doins -r python_cli/*
	exeinto "/usr/$(get_libdir)/wireshark/extcap"
	doexe python_cli/sniffle_extcap.py
}

pkg_postinst() {
	einfo "Pre-compiled firmwares from upstream are installed in /usr/share/${PN}"
}
