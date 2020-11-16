# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit python-single-r1

MY_PN="Mobile-Security-Framework-MobSF"

DESCRIPTION="Automated, all-in-one mobile application (Android/iOS/Windows) pen-testing"
HOMEPAGE="https://github.com/MobSF/Mobile-Security-Framework-MobSF"
SRC_URI="https://github.com/MobSF/Mobile-Security-Framework-MobSF/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"

#Dynamic Analysis or genymotion
IUSE="genymotion pdf"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/django[${PYTHON_MULTI_USEDEP}]
		dev-util/androguard[${PYTHON_MULTI_USEDEP}]
		dev-python/lxml[${PYTHON_MULTI_USEDEP}]
		dev-python/rsa[${PYTHON_MULTI_USEDEP}]
		dev-python/biplist[${PYTHON_MULTI_USEDEP}]
		dev-python/requests[${PYTHON_MULTI_USEDEP}]
		dev-python/beautifulsoup:4[${PYTHON_MULTI_USEDEP}]
		dev-python/colorlog[${PYTHON_MULTI_USEDEP}]
		dev-python/macholib[${PYTHON_MULTI_USEDEP}]
		dev-python/google-play-scraper[${PYTHON_MULTI_USEDEP}]
		dev-python/whitenoise[${PYTHON_MULTI_USEDEP}]
		dev-python/waitress[${PYTHON_MULTI_USEDEP}]
		dev-python/frida-python[${PYTHON_MULTI_USEDEP}]
		dev-python/psutil[${PYTHON_MULTI_USEDEP}]
		dev-python/shelljob[${PYTHON_MULTI_USEDEP}]
		dev-python/asn1crypto[${PYTHON_MULTI_USEDEP}]
		dev-python/oscrypto[${PYTHON_MULTI_USEDEP}]
		dev-python/distro[${PYTHON_MULTI_USEDEP}]
		dev-python/pyopenssl[${PYTHON_MULTI_USEDEP}]
		dev-python/apkid[${PYTHON_MULTI_USEDEP}]
		dev-python/pyparsing[${PYTHON_MULTI_USEDEP}]
		dev-python/http-tools[${PYTHON_MULTI_USEDEP}]
		dev-python/yara-python[${PYTHON_MULTI_USEDEP}]
	')
	pdf? ( $(python_gen_cond_dep 'dev-python/pdfkit[${PYTHON_MULTI_USEDEP}]') )
	www-servers/gunicorn
	genymotion? ( app-emulation/genymotion-bin )"

#next version:
#dev-python/libsast

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	python-single-r1_pkg_setup
}

#FIXME:
#src_prepare(){
#	sed USE_HOME=true settings.py
#}

pkg_postinst() {

#python manage.py makemigrations
#python manage.py makemigrations StaticAnalyzer
#python manage.py migrate
#run.sh`

	einfo "https://github.com/MobSF/Mobile-Security-Framework-MobSF/wiki/1.-Documentation"
	einfo " gunicorn -b 0.0.0.0:8000 MobSF.wsgi:application --workers=1"
}
