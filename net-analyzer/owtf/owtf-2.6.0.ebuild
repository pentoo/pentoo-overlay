# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
#python3_6 )
inherit eutils distutils-r1

DESCRIPTION="The Offensive Web Testing Framework"
HOMEPAGE="https://github.com/owtf/owtf"
SRC_URI="https://github.com/owtf/owtf/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
#KEYWORDS="~amd64"
IUSE="doc"

#RESTRICT="test"

DEPEND=""
RDEPEND="
	>=dev-python/blinker-1.4[${PYTHON_USEDEP}]
	>=dev-python/cffi-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/cookies-2.2.1[${PYTHON_USEDEP}]
	>=dev-python/dnspython-1.15.0[${PYTHON_USEDEP}]
	>=dev-python/future-0.16.0[${PYTHON_USEDEP}]
	>=dev-python/hrt-0.1.0[${PYTHON_USEDEP}]
	dev-python/ipaddr[${PYTHON_USEDEP}]
	>=dev-python/markdown-2.6.9[${PYTHON_USEDEP}]
	>=dev-python/pexpect-4.2.1[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.3.1[${PYTHON_USEDEP}]
	>=dev-python/psycopg2-binary-2.7.4[${PYTHON_USEDEP}]
	>=dev-python/PTP-0.4.2[${PYTHON_USEDEP}]
	>=dev-python/pycurl-7.43.0[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-17.5.0[${PYTHON_USEDEP}]
	>=dev-python/PyVirtualDisplay-0.2.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.13[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18.4[${PYTHON_USEDEP}]
	>=dev-python/selenium-3.4.3[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-1.1.13[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy_mixins-1.1[${PYTHON_USEDEP}]
	>=dev-python/tornado-5.0.2[${PYTHON_USEDEP}]

	virtual/python-typing[${PYTHON_USEDEP}]
"

src_prepare() {
	rm -r tests/
	use doc || sed -e 's| + reqs("docs.txt")||' -i setup.py || die "sed failed"
	#do not run postinstall scripts
	sed -e 's|, "install": PostInstallCommand||' -i setup.py || die "sed failed"
	#relax deps
	sed -e 's|==.*||' -i requirements/base.txt || die "sed failed"
	eapply_user
}

pkg_config() {
	einfo "If the following fails, it is likely because you forgot to start/config postgresql first"
	su postgres -c "createuser owtf_db_user -D -S -R"
	su postgres -c "createdb --owner=owtf_db_user owtf_db"
}

pkg_postinst() {
	einfo "To complete the installation, run the following command:"
	einfo "emerge --config net-analyzer/owtf-${PV}"
	einfo
	einfo "You will also need to create a certificate for the current user using the following commands:"
	einfo "mkdir -p ~/.owtf/proxy/{build,certs}/"
	einfo "openssl genrsa -des3 -passout pass:owtf_ca_pass -out ~/.owtf/proxy/certs/ca.key 4096"
	einfo "openssl req -new -x509 -days 3650 -subj \"/C=US/ST=Pwnland/L=OWASP/O=OWTF/CN=MiTMProxy\" -passin pass:owtf_ca_pass -key ~/.owtf/proxy/certs/ca.key -out ~/.owtf/proxy/certs/ca.crt"
	einfo
	einfo "In addition, you might want to change owtf_db_user password in the database (currently empty)"
	einfo "and adjust ~/.owtf/db.cfg accordingly"
}
