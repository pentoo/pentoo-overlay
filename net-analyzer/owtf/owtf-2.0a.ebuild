# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1

DESCRIPTION="OWASP ZAP Python API"
HOMEPAGE="https://github.com/zaproxy/zap-api-python"
SRC_URI="https://github.com/owtf/owtf/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-python/beautifulsoup:4
	>=dev-python/cookies-2.2.1
	>=dev-python/ipaddr-2.1.11
	>=dev-python/lxml-3.4.0
	>=dev-python/markdown-2.5.1
	>=dev-python/pexpect-3.3
	>=dev-python/psycopg-2.6.1:2
	>=dev-python/pycurl-7.19.5
	>=dev-python/six-1.8.0
	>=dev-python/pyopenssl-0.14
	>=dev-python/rdflib-4.1.2
	>=dev-python/selenium-2.43.0
	>=dev-python/sqlalchemy-1.0.11
	>=dev-python/PTP-0.3.0
	>=dev-python/python-owasp-zap-v2-0.0.9
	>=dev-python/PyVirtualDisplay-0.1.5
	>=www-servers/tornado-4.0.2"

src_prepare() {
	epatch "${FILESDIR}"/owtf-deps.patch

	sed -i 's|/usr/lib64/arachni/bin/arachni|/usr/bin/arachni|g' profiles/general/default.cfg
	sed -i 's|TOOL\(.*\)/usr/share/w3af/w3af_console|TOOL\1/usr/bin/w3af_console|g' profiles/general/default.cfg
	sed -i 's|TOOL\(.*\)metasploit-framework|TOOL\1metasploit|g' profiles/general/default.cfg
#	http://www.pathname.com/fhs/pub/fhs-2.3.html
	sed -i 's|TOOL\(.*\)/usr/share/|TOOL\1/usr/'$(get_libdir)/'|g' profiles/general/default.cfg

	#I gave up here, see https://github.com/owtf/owtf/issues/725
}

src_install() {

	insinto /usr/$(get_libdir)/${PN}
	doins -r *

#	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}

	fperms +x /usr/$(get_libdir)/${PN}/${PN}.py
	dosym /usr/$(get_libdir)/${PN}/${PN}.py /usr/bin/${PN}

#ERROR: monitor_page_manager.py", line 89
#	python_optimize "${D}"usr/$(get_libdir)/${PN}

}

pkg_config() {
	einfo "If the following fails, it is likely because you forgot to start/config postgresql first"
	su postgres -c "createuser owtf_db_user -D -S -R"
	su postgres -c "createdb --owner=owtf_db_user owtfdb"
}

pkg_postinst() {
	einfo "To complete the installation, run the following command:"
	einfo "emerge --config net-analyzer/owtf-2.0a"
	einfo
	einfo "You will also need to create a certificate for the current user using the following commands:"
	einfo "mdkir -p ~/.owtf/proxy/ca.key"
	einfo "openssl genrsa -des3 -passout pass:owtf_ca_pass -out ~/.owtf/proxy/ca.key 4096"
	einfo "openssl req -new -x509 -days 3650 -subj \"/C=US/ST=Pwnland/L=OWASP/O=OWTF/CN=MiTMProxy\" -passin pass:owtf_ca_pass -key ~/.owtf/proxy/ca.key -out ~/.owtf/proxy/ca.crt"
	einfo
	einfo "In addition, you might want to change owtf_db_user password in the database (currently empty)"
	einfo "and adjust ~/.owtf/db.cfg accordingly"
}
