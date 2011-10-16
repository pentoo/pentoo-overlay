# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpid/acpid-2.0.12.ebuild,v 1.3 2011/10/04 21:40:15 phajdan.jr Exp $

EAPI=4
inherit eutils systemd toolchain-funcs

DESCRIPTION="Daemon for Advanced Configuration and Power Interface"
HOMEPAGE="http://tedfelix.com/linux/acpid-netlink.html"
SRC_URI="http://tedfelix.com/linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 -ppc x86"
IUSE="pentoo"

RDEPEND="!<sys-apps/openrc-0.6.0"
DEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.0.3.patch
}

src_compile() {
	tc-export CC CPP
	emake
	emake -C kacpimon
}

src_install() {
	emake DESTDIR="${D}" DOCDIR=/usr/share/doc/${PF} install

	dobin kacpimon/kacpimon
	newdoc kacpimon/README README.kacpimon

	exeinto /etc/acpi
	if use pentoo; then
		newexe "${FILESDIR}"/${PN}-pentoo-1.0.6-default.sh default.sh
	else
		newexe "${FILESDIR}"/${PN}-1.0.6-default.sh default.sh
	fi
	insinto /etc/acpi/events
	newins "${FILESDIR}"/${PN}-1.0.4-default default

	newinitd "${FILESDIR}"/${PN}-2.0.11-init.d acpid
	newconfd "${FILESDIR}"/${PN}-1.0.6-conf.d acpid

	systemd_dounit "${FILESDIR}"/${PN}.service
}

pkg_postinst() {
	elog
	elog "You may wish to read the Gentoo Linux Power Management Guide,"
	elog "which can be found online at:"
	elog "http://www.gentoo.org/doc/en/power-management-guide.xml"
	elog
}
