# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/app-fuzz/protos/protos-1.0.ebuild,v 1.1.1.1 2006/03/08 18:55:18 grimmlin Exp $

HTTP_VER="r1"
LDAP_VER="r1"
SNMP_VER="r1"
SIP_VER="r2"
H2250_VER="r2"
ISAKMP_VER="r2"
DNS_VER="r1"

DESCRIPTION="The protos fuzzing collection, containing http-reply, ldapv3, snmpv1, sip, h2250v4 and isakmp"
HOMEPAGE="http://www.ee.oulu.fi/research/ouspg/protos/"
SRC_URI="http? ( https://www.ee.oulu.fi/roles/ouspg/PROTOS_Test-Suite_c05-http-reply?action=AttachFile&do=get&target=c05-http-reply-${HTTP_VER}.jar )
	 ldap? ( https://www.ee.oulu.fi/roles/ouspg/PROTOS_Test-Suite_c06-ldapv3?action=AttachFile&do=get&target=c06-ldapv3-enc-${LDAP_VER}.jar
	 	https://www.ee.oulu.fi/roles/ouspg/PROTOS_Test-Suite_c06-ldapv3?action=AttachFile&do=get&target=c06-ldapv3-app-${LDAP_VER}.jar )
	 snmp? ( https://www.ee.oulu.fi/roles/ouspg/PROTOS_Test-Suite_c06-snmpv1?action=AttachFile&do=get&target=c06-snmpv1-req-app-${SNMP_VER}.jar
	 	https://www.ee.oulu.fi/roles/ouspg/PROTOS_Test-Suite_c06-snmpv1?action=AttachFile&do=get&target=c06-snmpv1-req-enc-${SNMP_VER}.jar
	 	https://www.ee.oulu.fi/roles/ouspg/PROTOS_Test-Suite_c06-snmpv1?action=AttachFile&do=get&target=c06-snmpv1-trap-app-${SNMP_VER}.jar
	 	https://www.ee.oulu.fi/roles/ouspg/PROTOS_Test-Suite_c06-snmpv1?action=AttachFile&do=get&target=c06-snmpv1-trap-enc-${SNMP_VER}.jar )
	 sip? ( https://www.ee.oulu.fi/roles/ouspg/PROTOS_Test-Suite_c07-sip?action=AttachFile&do=get&target=c07-sip-${SIP_VER}.jar )
	 h2250? ( https://www.ee.oulu.fi/roles/ouspg/PROTOS_Test-Suite_c07-h2250v4?action=AttachFile&do=get&target=c07-h2250v4-${H2250_VER}.jar )
	 isakmp? ( https://www.ee.oulu.fi/roles/ouspg/PROTOS_Test-Suite_c09-isakmp?action=AttachFile&do=get&target=c09-isakmp-${ISAKMP_VER}.jar )
	 dns? ( https://www.ee.oulu.fi/roles/ouspg/PROTOS_Test-Suite_c09-dns?action=AttachFile&do=get&target=c09-dns-query-${DNS_VER}.jar
		https://www.ee.oulu.fi/roles/ouspg/PROTOS_Test-Suite_c09-dns?action=AttachFile&do=get&target=c09-dns-response-${DNS_VER}.jar
		https://www.ee.oulu.fi/roles/ouspg/PROTOS_Test-Suite_c09-dns?action=AttachFile&do=get&target=c09-dns-zonetransfer-${DNS_VER}.jar )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="http ldap snmp sip h2250 isakmp dns"

DEPEND="virtual/jre"

src_unpack () {
	einfo "Nothing to unpack"
	mkdir "${S}"
}

src_compile () {
	einfo "Nothing to compile"
	einfo "Copying binary files"
	for x in $A
	do
		cp "${DISTDIR}"/"${x}" "${S}"/
	done
}

src_install () {
	insinto /opt/protos/
	for x in $A
	do
		doins "${x}"
	done
	dosbin "${FILESDIR}"/protos
}
