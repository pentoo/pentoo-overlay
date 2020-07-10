# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="Integrated Penetration-Test Environment is a multiuser Penetration test IDE"
HOMEPAGE="https://github.com/infobyte/faraday https://pypi.org/project/faradaysec/"

#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${PV}.tar.gz"
SRC_URI="https://github.com/infobyte/faraday/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEP_SERVER="
	>=dev-python/autobahn-17.10.1[${PYTHON_USEDEP}]
	>=dev-python/alembic-0.9.9[${PYTHON_USEDEP}]
	>=dev-python/bcrypt-3.1.4[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.3.9[${PYTHON_USEDEP}]
	>=dev-python/click-5.1[${PYTHON_USEDEP}]
	>=dev-python/flask-sqlalchemy-2.3.1[${PYTHON_USEDEP}]
	>=dev-python/flask-classful-0.14[${PYTHON_USEDEP}]
	>=dev-python/flask-security-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/flask-session-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/flask-1.1[${PYTHON_USEDEP}]
	>=dev-python/future-0.17.1[${PYTHON_USEDEP}]
	>=dev-python/ipy-0.83[${PYTHON_USEDEP}]
	<dev-python/marshmallow-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/pillow-4.2.1[${PYTHON_USEDEP}]
	>=dev-db/pgcli-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/psycopg-2.8.3[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-modules-0.0.11[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-17.2.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.6.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18.4[${PYTHON_USEDEP}]
	>=dev-python/service_identity-17.0.0[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy_schemadisplay-1.3[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.15.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-18.9.0[${PYTHON_USEDEP}]
	>=dev-python/webargs-5.1.0[${PYTHON_USEDEP}]
	>=dev-python/marshmallow-sqlalchemy-0.15.0[${PYTHON_USEDEP}]
	dev-python/filteralchemy-fork[${PYTHON_USEDEP}]
	>=dev-python/filedepot-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/nplusone-0.8.1[${PYTHON_USEDEP}]
	>=dev-python/deprecation-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/websocket-client-0.46.0[${PYTHON_USEDEP}]
	>=dev-python/attrs-17.4.0[${PYTHON_USEDEP}]
	>=dev-python/flask-restless-0.17.0[${PYTHON_USEDEP}]
	>=dev-python/simplejson-3.16.0[${PYTHON_USEDEP}]
	>=dev-python/syslog-rfc5424-formatter-1.1.1[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	>=dev-python/Flask-KVSession-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/simplekv-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/pypcapfile-0.12.0[${PYTHON_USEDEP}]
	>=dev-python/html2text-2019.8.11[${PYTHON_USEDEP}]
	>=dev-python/distro-1.3.0[${PYTHON_USEDEP}]
	dev-python/faraday-plugins[${PYTHON_USEDEP}]
"
RDEPEND="${PYTHON_DEPS}
	>=dev-python/websocket-client-0.54.0[${PYTHON_USEDEP}]
	>=dev-python/autobahn-17.10.1[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.3.9[${PYTHON_USEDEP}]
	>=dev-python/deprecation-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/flask-1.0[${PYTHON_USEDEP}]
	>=dev-python/ipy-0.83[${PYTHON_USEDEP}]
	>=dev-python/mockito-1.0.12[${PYTHON_USEDEP}]
	>=dev-db/pgcli-1.8.2[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18.4[${PYTHON_USEDEP}]
	>=www-servers/tornado-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.15.0[${PYTHON_USEDEP}]
	>=dev-python/whoosh-2.7.4[${PYTHON_USEDEP}]
	>=dev-python/cairocffi-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/pycairo-1.18.1[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.3.3[${PYTHON_USEDEP}]
	>=dev-python/html2text-2019.8.11[${PYTHON_USEDEP}]
	${DEP_SERVER}
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare(){
	sed -e 's|==|>=|' -i requirements.txt || die "sed failed"
	sed -e 's|==|>=|' \
	-e 's|psycopg2-binary>=2.8.4|psycopg2|' -i requirements_server.txt || die "sed failed"
	eapply_user
}

pkg_postinst(){
	einfo "To setup the database, run following commands:"
	einfo "/etc/init.d/postgresql start"
	einfo "faraday-manage initdb"
	einfo "Navigate to: http://localhost:5985/"

	einfo "For more details, see the following guideline:"
	einfo "https://github.com/infobyte/faraday/wiki/Install-Guide"
}
