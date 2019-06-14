# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="The web end of seafile server"
HOMEPAGE="https://github.com/haiwen/seahub/"
SRC_URI="https://github.com/haiwen/seahub/archive/v${PV}-server.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

#see with requirements.txt
RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/python-memcached[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	=dev-python/django-1.11*[${PYTHON_USEDEP}]
	dev-python/django_compressor[${PYTHON_USEDEP}]
	dev-python/django-post_office-haiwen[${PYTHON_USEDEP}]
	dev-python/django-statici18n[${PYTHON_USEDEP}]
	dev-python/djangorestframework[${PYTHON_USEDEP}]
	dev-python/django-constance-haiwen[${PYTHON_USEDEP},database]
	dev-python/openpyxl[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/django-formtools[${PYTHON_USEDEP}]
	dev-python/qrcode[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]
	dev-python/django-simple-captcha[${PYTHON_USEDEP}]
	www-servers/gunicorn
	dev-python/django-webpack-loader[${PYTHON_USEDEP}]
	dev-python/python-cas-haiwen[${PYTHON_USEDEP}]
	virtual/python-futures[${PYTHON_USEDEP}]
	dev-python/social-auth-core[${PYTHON_USEDEP}]
	dev-python/flup[${PYTHON_USEDEP}]"

#TODO:
#ccnet-server[sqlite] ?

S="${WORKDIR}/${P}-server"

src_compile() {
	emake  locale
}

src_install() {
#	dodir /opt/Tiredful-API
#	cp -R "${S}"/Tiredful-API "${D}"/opt/
	einfo "Please follow postisnt instruction"
}

pkg_postinst() {
	einfo "The GUI server is not ready to be started yet"
	einfo "Please follow the following steps to complete configuration:"
	einfo "   https://manual.seafile.com/deploy/using_sqlite.html"
	einfo "   https://manual.seafile.com/build_seafile/server.html"
	einfo "also see ${FILESDIR} for modified scripts"
}
