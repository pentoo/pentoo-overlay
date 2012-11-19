# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpid/acpid-2.0.17.ebuild,v 1.4 2012/11/19 09:31:34 pinkbyte Exp $

EAPI=4
inherit systemd

DESCRIPTION="Daemon for Advanced Configuration and Power Interface"
HOMEPAGE="http://tedfelix.com/linux/acpid-netlink.html"
SRC_URI="http://tedfelix.com/linux/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 -ppc x86"
IUSE="pentoo"

src_configure() {
	econf --docdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install

	newdoc kacpimon/README README.kacpimon
	dodoc -r samples
	rm -f "${D}"/usr/share/doc/${PF}/COPYING

	exeinto /etc/acpi
	if use pentoo; then
		newexe "${FILESDIR}"/${PN}-pentoo-1.0.6-default.sh default.sh
	else
		newexe "${FILESDIR}"/${PN}-1.0.6-default.sh default.sh
	fi
	insinto /etc/acpi/events
	newins "${FILESDIR}"/${PN}-1.0.4-default default

	newinitd "${FILESDIR}"/${PN}-2.0.16-init.d ${PN}
	newconfd "${FILESDIR}"/${PN}-2.0.16-conf.d ${PN}

	systemd_dounit "${FILESDIR}"/systemd/${PN}.{service,socket}
}

pkg_postinst() {
	if ! has_version 'sys-power/acpid'; then
		elog
		elog "You may wish to read the Gentoo Linux Power Management Guide,"
		elog "which can be found online at:"
		elog "http://www.gentoo.org/doc/en/power-management-guide.xml"
		elog
	fi

	# files/systemd/acpid.socket -> ListenStream=/run/acpid.socket
	mkdir -p "${ROOT}"/run

	if ! grep -qs "^tmpfs.*/run " "${ROOT}"/proc/mounts ; then
		echo
		ewarn "You should reboot the system now to get /run mounted with tmpfs!"
	fi
}
