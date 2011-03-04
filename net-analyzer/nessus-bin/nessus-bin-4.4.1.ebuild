# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-bin/nessus-bin-3.2.0.ebuild,v 1.3 2009/07/07 23:03:49 flameeyes Exp $

inherit rpm

# We are using the Red Hat/CentOS binary
MY_P="Nessus-${PV}-es5"

DESCRIPTION="A remote security scanner for Linux"
HOMEPAGE="http://www.nessus.org"
SRC_URI="x86? ( ${MY_P}.i386.rpm )
	amd64? ( ${MY_P}.x86_64.rpm )"
RESTRICT="mirror fetch strip"

LICENSE="Nessus-EULA"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="=sys-libs/db-4.3*
	>=dev-libs/openssl-0.9.8
	>=app-arch/rpm2targz-9.0-r7"

pkg_nofetch() {
	if use x86; then
		elog "Please download ${MY_P}.i386.rpm from ${HOMEPAGE}/download"
		elog "The archive should then be placed into ${DISTDIR}."
	fi

	if use amd64; then
		elog "Please download ${MY_P}.x86_64.rpm from ${HOMEPAGE}/download"
		elog "The archive should then be placed into ${DISTDIR}."
	fi
}

pkg_setup() {
	case ${CHOST} in
		i586-pc-linux-gnu*)	einfo "Found compatible architecture." ;;
		i686-pc-linux-gnu*)	einfo "Found compatible architecture." ;;
		x86_64-pc-linux-gnu*)	einfo "Found compatible architecture." ;;
		*)			die "No compatible architecture found." ;;
	esac
}

src_install() {
	# copy files
	cp -pPR "${WORKDIR}"/opt "${D}"

	# make sure these directories do not vanish
	# nessus will not run properly without them
	keepdir /opt/nessus/etc/nessus
	keepdir /opt/nessus/var/nessus/jobs
	keepdir /opt/nessus/var/nessus/logs
	keepdir /opt/nessus/var/nessus/tmp
	keepdir /opt/nessus/var/nessus/users

	# add /opt/nessus/lib to LD_PATH
	# nessus will not run properly without it
	doenvd "${FILESDIR}"/90nessus-bin

	# we have /bin/gzip, not /usr/bin/gzip
	sed -i -e "s:/usr/bin/gzip:/bin/gzip:g" \
		"${D}"/opt/nessus/sbin/nessus-update-plugins

	# init script
	newinitd "${FILESDIR}"/nessusd-initd-42 nessusd-bin

	# nessusd is linked against these
	dosym libssl.so /usr/lib/libssl.so.6
	dosym libcrypto.so /usr/lib/libcrypto.so.6
}

pkg_postinst() {
	elog "You can get started running the following commands:"
	elog "/opt/nessus/sbin/nessus-adduser"
	elog "/opt/nessus/sbin/nessus-mkcert"
	elog "/etc/init.d/nessusd-bin start"
	elog
	elog "If you had a previous version of Nessus installed, use"
	elog "the following command to update the plugin database:"
	elog "/opt/nessus/sbin/nessusd -R"
	elog
	elog "For more information about nessus, please visit"
	elog "${HOMEPAGE}/documentation/"
}
