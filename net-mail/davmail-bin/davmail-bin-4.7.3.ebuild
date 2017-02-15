# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils java-pkg-2 user

#https://sourceforge.net/projects/davmail/files/davmail/
MY_REV="2438"
MY_PN="davmail"

SRC_URI="x86? ( mirror://sourceforge/${MY_PN}/${MY_PN}-linux-x86-${PV}-${MY_REV}.tgz )
	amd64? ( mirror://sourceforge/${MY_PN}/${MY_PN}-linux-x86_64-${PV}-${MY_REV}.tgz )"
DESCRIPTION="POP/IMAP/SMTP/Caldav/Carddav/LDAP Exchange Gateway"
HOMEPAGE="http://davmail.sourceforge.net/"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 -*"
IUSE="server"

DEPEND="|| (
	>=virtual/jre-1.6:*
	>=virtual/jdk-1.6:*
	)
	!net-mail/davmail"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

pkg_setup() {
	if use server ; then
		enewuser davmail -1 -1 /dev/null
	fi
}

java-pkg-2_src_compile() {
	einfo ""
}

src_install() {
	use x86 && cd "${S}/${MY_PN}-linux-x86-${PV}-${MY_REV}"
	use amd64 && cd "${S}/${MY_PN}-linux-x86_64-${PV}-${MY_REV}"
	# libraries
	java-pkg_dojar lib/*.jar
	java-pkg_dojar ${MY_PN}.jar

	# icon
#	doicon "${FILESDIR}"/${MY_PN}.png

	# create wrapper script for the client
	java-pkg_dolauncher ${MY_PN} --main ${MY_PN}.DavGateway --java_args ""

	# desktop entry
	make_desktop_entry ${MY_PN} "DavMail" /usr/share/pixmaps/${MY_PN}.png "Network"

	if use server ; then
		# log file
		touch ${MY_PN}.log
		insinto /var/log
		doins ${MY_PN}.log
		fowners ${MY_PN} /var/log/${MY_PN}.log

		# config files
		insinto /etc
		doins "${FILESDIR}"/${MY_PN}.properties
		newinitd "${FILESDIR}"/${MY_PN}.init ${MY_PN}
		newconfd "${FILESDIR}"/${MY_PN}.conf ${MY_PN}
	fi
}

pkg_postinst() {
	if use server ; then
		elog
		elog "You have chosen to run ${MY_PN} as a system service. You will need to"
		elog "modify /etc/${MY_PN}.properties to serve your needs."
		elog
		elog "You may find it easier to run the ${MY_PN}, configure it via the GUI"
		elog "and copy the resulting ~/.${MY_PN}.properties to /etc. Make sure you"
		elog "set ${MY_PN}.server=true and ${MY_PN}.allowRemote=true."
		elog
	fi
}
