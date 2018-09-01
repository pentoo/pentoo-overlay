# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_6 )
inherit eutils distutils-r1

DESCRIPTION="The Offensive Web Testing Framework"
HOMEPAGE="https://github.com/owtf/owtf"
SRC_URI="https://github.com/owtf/owtf/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
#KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	>=dev-python/blinker-1.4
	>=dev-python/cffi-1.10.0
	>=dev-python/cookies-2.2.1
	>=dev-python/dnspython-1.15.0
	>=dev-python/future-0.16.0
	>=dev-python/hrt-0.1.0
	>=dev-python/ipaddr-2.2.0
	>=dev-python/markdown-2.6.9
	>=dev-python/pexpect-4.2.1
	>=dev-python/psutil-5.3.1
	>=dev-python/psycopg2-binary-2.7.4
	>=dev-python/PTP-0.4.2
	>=dev-python/pycurl-7.43.0
	>=dev-python/pyopenssl-17.5.0
	>=dev-python/PyVirtualDisplay-0.2.1
	>=dev-python/pyyaml-3.12.0
	>=dev-python/requests-2.18.4
	>=dev-python/selenium-3.4.3
	>=dev-python/six-1.10.0
	>=dev-python/sqlalchemy-1.1.13
	>=dev-python/tornado-5.0.2
"

src_prepare() {
	rm -r tests/
	epatch "${FILESDIR}"/owtf-setup.patch
	eapply_user
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
