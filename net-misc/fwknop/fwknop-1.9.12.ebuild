# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils perl-app

DESCRIPTION="Single Packet Authorization and Port Knocking"
HOMEPAGE="http://www.cipherdyne.org/fwknop"
SRC_URI="http://www.cipherdyne.org/fwknop/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="${DEPEND}
	dev-lang/perl"

RDEPEND="virtual/logger
	virtual/mailx
	dev-perl/Unix-Syslog
	dev-perl/crypt-cbc
	dev-perl/Crypt-Rijndael
	dev-perl/Net-Pcap
	dev-perl/TermReadKey
	perl-core/Digest-SHA
	net-firewall/iptables
	net-misc/whois"

src_compile() {
	cd "${S}"/deps/Net-IPv4Addr
	SRC_PREP="no" perl-module_src_compile
	emake test

	cd "${S}"/deps/IPTables-Parse
	SRC_PREP="no" perl-module_src_compile
	emake test

	cd "${S}"/deps/IPTables-ChainMgr
	SRC_PREP="no" perl-module_src_compile
	emake test

	cd "${S}"
	# We'll use the C binaries
	emake || die "Make failed: daemons"
}

src_install() {
	local myhostname=
	local mydomain=

	doman *.8

	keepdir /var/lib/fwknop /var/log/fwknop /var/run/fwknop /var/lock/subsys/${PN}
	dodir /etc/fwknop

	cd "${S}"/deps/Net-IPv4Addr
	perl-module_src_install

	cd "${S}"/deps/IPTables-ChainMgr
	perl-module_src_install

	cd "${S}"/deps/IPTables-Parse
	perl-module_src_install

	cd "${S}"
	insinto /usr
	dosbin fwknop fwknop_serv fwknopd knopmd knoptm knopwatchd

	cd "${S}"

	fix_conf

	insinto /etc/fwknop
	doins *.conf

	cd "${S}"/init-scripts
	newinitd fwknop-init.gentoo fwknop

	cd "${S}"
	dodoc CREDITS Change* README README.* VERSION
}

pkg_postinst() {
	echo
	elog "Please be sure to edit /etc/fwknop/fwknop.conf to reflect your system's"
	elog "configuration or it may not work correctly or start up. Specifically, check"
	elog "the validity of the HOSTNAME setting and EMAIL_ADDRESSES"
	echo
	elog "You must edit /etc/fwknop/access.conf for fwknop to work correctly."
}

fix_conf() {
	cp fwknop.conf fwknop.conf.orig

	# Ditch the _CHANGEME_ for hostname, substituting in our real hostname
	[ -e /etc/hostname ] && myhostname="$(< /etc/hostname)"
	[ "${myhostname}" == "" ] && myhostname="$HOSTNAME"
	mydomain=".$(grep ^domain /etc/resolv.conf | cut -d" " -f2)"
	sed -i "s:HOSTNAME\(.\+\)\_CHANGEME\_;:HOSTNAME\1${myhostname}${mydomain};:" fwknop.conf || die "fix_conf failed"

	# Fix up paths
	sed -i "s:/sbin/syslogd:/usr/sbin/syslogd:g" fwknop.conf || die "fix_conf failed"
	sed -i "s:/sbin/syslog-ng:/usr/sbin/syslog-ng:g" fwknop.conf || die "fix_conf failed"
	sed -i "s:/usr/bin/whois_psad:/usr/bin/whois:g" fwknop.conf || die "fix_conf failed"
}
