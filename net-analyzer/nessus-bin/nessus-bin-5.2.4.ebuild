# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-bin/nessus-bin-5.0.1.ebuild,v 1.1 2012/10/06 17:35:27 pinkbyte Exp $

EAPI=5
inherit multilib rpm

MY_P="Nessus-${PV}-es6"
# We are using the Red Hat/CentOS binary

DESCRIPTION="A remote security scanner for Linux"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="
	x86? ( ${MY_P}.i386.rpm )
	amd64? ( ${MY_P}.x86_64.rpm )"

RESTRICT="mirror fetch strip"

LICENSE="GPL-2 Nessus-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="X"

RDEPEND="dev-libs/openssl:0
	sys-libs/db"
DEPEND="${RDEPEND}
	app-arch/rpm2targz"

QA_PREBUILT="/opt/nessus/bin/nessus
	/opt/nessus/bin/nessuscmd
	/opt/nessus/bin/nessus-mkrand
	/opt/nessus/bin/nasl
	/opt/nessus/bin/nessus-fetch
	/opt/nessus/lib/nessus/libnessus-glibc-fix.so
	/opt/nessus/sbin/nessus-chpasswd
	/opt/nessus/sbin/nessus-adduser
	/opt/nessus/sbin/nessus-rmuser
	/opt/nessus/sbin/nessus-mkcert
	/opt/nessus/sbin/nessus-update-plugins
	/opt/nessus/sbin/nessus-admin
	/opt/nessus/sbin/nessusd
	/opt/nessus/sbin/nessus-check-signature
	/opt/nessus/sbin/nessus-mkcert-client
	/opt/nessus/sbin/nessus-service
	/opt/nessus/sbin/nessus-fix"

pkg_nofetch() {
		einfo "Please download ${A} from ${HOMEPAGE}/download"
		einfo "The archive should then be placed into ${DISTDIR}."
}

src_unpack() {
	#create a proper $S directory
	mkdir -p "${S}"
	cd "${S}"
	rpm_unpack
}

src_install() {
	cp -pPR "${S}"/opt "${D}"/

	# make sure these directories do not vanish
	# nessus will not run properly without them
	keepdir /opt/nessus/etc/nessus
	keepdir /opt/nessus/var/nessus/jobs
	keepdir /opt/nessus/var/nessus/logs
	keepdir /opt/nessus/var/nessus/tmp
	keepdir /opt/nessus/var/nessus/users

	# add PATH and MANPATH for convenience
	doenvd "${FILESDIR}"/90nessus-bin

	# we have /bin/gzip, not /usr/bin/gzip
	sed -i -e "s:/usr/bin/gzip:/bin/gzip:g" \
		"${D}"/opt/nessus/sbin/nessus-update-plugins

	# init script
	newinitd "${FILESDIR}"/nessusd-initd nessusd-bin
	dosym libssl.so /usr/$(get_libdir)/libssl.so.10
	dosym libcrypto.so /usr/$(get_libdir)/libcrypto.so.10

	# nmap plugins
	insinto  /opt/nessus/lib/nessus/plugins/
	doins "${FILESDIR}"/*.nasl
}

pkg_postinst() {
	elog "You can get started running the following commands:"
	elog "/opt/nessus/sbin/nessus-adduser"
	elog "/opt/nessus/sbin/nessus-mkcert"
	elog "/opt/nessus/bin/nessus-fetch --register <your registration code>"
	elog "/etc/init.d/nessusd-bin start"
	elog
	elog "If you had a previous version of Nessus installed, use"
	elog "the following command to update the plugin database:"
	elog "/opt/nessus/sbin/nessusd -R"
	elog
	elog "For more information about nessus, please visit"
	elog "${HOMEPAGE}/documentation/"
}
