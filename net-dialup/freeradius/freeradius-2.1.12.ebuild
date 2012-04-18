# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/freeradius/freeradius-2.1.12.ebuild,v 1.1 2011/11/20 18:54:06 mrness Exp $

EAPI="4"

inherit eutils multilib pam autotools libtool

DESCRIPTION="Highly configurable free RADIUS server"
SRC_URI="ftp://ftp.freeradius.org/pub/radius/${PN}-server-${PV}.tar.gz"
HOMEPAGE="http://www.freeradius.org/"

KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="bindist debug edirectory firebird frascend frxp kerberos ldap mysql pam postgres snmp ssl threads +udpfromto +wpe"

RDEPEND="!net-dialup/cistronradius
	!net-dialup/gnuradius
	>=sys-libs/db-3.2
	sys-libs/gdbm
	sys-libs/readline
	net-libs/libpcap
	dev-lang/perl
	snmp? ( net-analyzer/net-snmp )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-server )
	!bindist? ( firebird? ( dev-db/firebird ) )
	pam? ( sys-libs/pam )
	ssl? ( dev-libs/openssl )
	ldap? ( net-nds/openldap )
	kerberos? ( virtual/krb5 )
	frxp? ( dev-lang/python )"
DEPEND="${RDEPEND}"

REQUIRED_USE="frxp? ( threads )"

S="${WORKDIR}/${PN}-server-${PV}"

pkg_setup() {
	if use edirectory && ! use ldap ; then
		eerror "Cannot add integration with Novell's eDirectory without having LDAP support!"
		eerror "Either you select ldap USE flag or remove edirectory"
		die "edirectory needs ldap"
	fi
	if has_version '<net-dialup/freeradius-2.1.12'; then
		elog "Please rename radiusd group/user as radius"
		elog "and update /etc/raddb/radius.conf accordingly!"
	else
		enewgroup radius
		enewuser radius -1 -1 /var/log/radius radius
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-versionless-la-files.patch"
	epatch "${FILESDIR}/${P}-ssl.patch"
	epatch "${FILESDIR}/${P}-qafixes.patch"
	epatch "${FILESDIR}/${P}-pkglibdir.patch"
	use wpe && epatch "${FILESDIR}/${PN}-2.1.11-wpe.patch"

	append-flags -lpthread
	# kill modules we don't use
	if ! use ssl; then
		einfo "removing rlm_eap_{tls,ttls,ikev2,peap} modules  (no use ssl)"
		rm -rf src/modules/rlm_eap/types/rlm_eap_{tls,ttls,ikev2,peap}
	fi
	if ! use ldap; then
		einfo "removing rlm_ldap (no use ldap)"
		rm -rf src/modules/rlm_ldap
	fi
	if ! use kerberos; then
		einfo "removing rlm_krb5 (no use kerberos)"
		rm -rf src/modules/rlm_krb5
	fi
	if ! use pam; then
		einfo "removing rlm_pam (no use pam)"
		rm -rf src/modules/rlm_pam
	fi
	if ! use mysql; then
		einfo "removing rlm_sql_mysql (no use mysql)"
		rm -rf src/modules/rlm_sql/drivers/rlm_sql_mysql
		sed -i -e '/rlm_sql_mysql/d' src/modules/rlm_sql/stable
	fi
	if ! use postgres; then
		einfo "removing rlm_sql_postgresql (no use postgres)"
		rm -rf src/modules/rlm_sql/drivers/rlm_sql_postgresql
		sed -i -e '/rlm_sql_postgresql/d' src/modules/rlm_sql/stable
	fi
	if use bindist || ! use firebird; then
		einfo "removing rlm_sql_firebird (use bindist or no use firebird)"
		rm -rf src/modules/rlm_sql/drivers/rlm_sql_firebird
		sed -i -e '/rlm_sql_firebird/d' src/modules/rlm_sql/stable
	fi
	if use wpe; then
#		einfo "fixing wpe settings for windows"
#		sed -i 's/^#	with_ntdomain_hack = no/	with_ntdomain_hack = yes/g' raddb/modules/mschap
#		sed -i 's/with_ntdomain_hack = no/with_ntdomain_hack = yes/g' raddb/modules/preprocess
		cp "${FILESDIR}"/clients_wpe.conf raddb/clients.conf || die "failed to copy config files"
		cp "${FILESDIR}"/eap_wpe.conf raddb/eap.conf || die "failed to copy config files"
		cp "${FILESDIR}"/users_wpe raddb/users || die "failed to copy config files"
	fi

	# These are needed for fixing libtool-2 related issues (#261189)
	# Keep these lines even if you don't patch *.{in,am} files!
	eautoreconf
	elibtoolize
}

src_configure() {
	local myconf="\
		$(use_enable debug developer) \
		$(use_with snmp) \
		$(use_with frascend ascend-binary) \
		$(use_with frxp experimental-modules) \
		$(use_with udpfromto) \
		$(use_with edirectory edir) \
		$(use_with threads)"

	# fix bug #77613
	if has_version app-crypt/heimdal; then
		myconf="${myconf} --enable-heimdal-krb5"
	fi

	econf --disable-static --disable-ltdl-install --with-system-libtool \
		 --localstatedir=/var ${myconf}
}

src_compile() {
	emake -j1
	#cd raddb
	#emake

}

src_install() {
	dodir /etc
	dodir /var/log
	dodir /var/run
	diropts -m0750 -o root -g radiusd
	dodir /etc/raddb
	diropts -m0750 -o radiusd -g radiusd
	dodir /var/log/radius
	keepdir /var/log/radius/radacct
	dodir /var/run/radiusd
	diropts

	emake R="${ED}" install
	sed -i -e 's:^#user *= *nobody:user = radiusd:;s:^#group *= *nobody:group = radiusd:' \
	    "${ED}"/etc/raddb/radiusd.conf
	chown -R root:radiusd "${ED}"/etc/raddb/*

	pamd_mimic_system radiusd auth account password session

	mv "${ED}/usr/share/doc/${PN}" "${ED}/usr/share/doc/${PF}"
	dodoc CREDITS

	rm "${ED}/usr/sbin/rc.radiusd"

	newinitd "${FILESDIR}/radius.init-r2" radiusd
	newconfd "${FILESDIR}/radius.conf" radiusd
	cd "${ED}"/etc/raddb/certs
	emake all
	#cd raddb
	#emake R=${ED} install
}
