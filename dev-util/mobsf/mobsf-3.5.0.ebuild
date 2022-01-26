# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

MY_PN="Mobile-Security-Framework-MobSF"

DESCRIPTION="Automated, all-in-one mobile application (Android/iOS/Windows) pen-testing"
HOMEPAGE="https://github.com/MobSF/Mobile-Security-Framework-MobSF"
SRC_URI="https://github.com/MobSF/Mobile-Security-Framework-MobSF/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

#Dynamic Analysis or genymotion
IUSE="genymotion pdf"

QA_FLAGS_IGNORED="usr/lib/python.*/site-packages/mobsf/DynamicAnalyzer.*
		usr/lib/python.*/site-packages/mobsf/StaticAnalyzer.*"
QA_PRESTRIPPED="usr/lib/python.*/site-packages/mobsf/DynamicAnalyzer.*
		usr/lib/python.*/site-packages/mobsf/StaticAnalyzer.*"

RDEPEND="
	>=dev-python/django-3.1.5[${PYTHON_USEDEP}]
	>=dev-python/lxml-4.6.2[${PYTHON_USEDEP}]
	>=dev-python/rsa-4.7[${PYTHON_USEDEP}]
	>=dev-python/biplist-1.0.3[${PYTHON_USEDEP}]
	>=dev-python/requests-2.25.1[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup4-0.0.1[${PYTHON_USEDEP}]
	>=dev-python/colorlog-4.7.2[${PYTHON_USEDEP}]
	>=dev-python/macholib-1.14[${PYTHON_USEDEP}]
	>=dev-python/whitenoise-5.2.0[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.8.0[${PYTHON_USEDEP}]
	>=dev-python/shelljob-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/asn1crypto-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/oscrypto-1.2.1[${PYTHON_USEDEP}]
	>=dev-python/distro-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/IP2Location-8.6.4[${PYTHON_USEDEP}]
	>=dev-util/lief-0.11.0[${PYTHON_USEDEP}]
	>=dev-python/http-tools-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/libsast-1.4.2[${PYTHON_USEDEP}]
	>=dev-python/google-play-scraper-0.1.2[${PYTHON_USEDEP}]
	>=dev-util/androguard-3.4.0_alpha[${PYTHON_USEDEP}]
	>=dev-python/apkid-2.1.2[${PYTHON_USEDEP}]
	>=dev-python/quark-engine-22.1.1[${PYTHON_USEDEP}]
	>=dev-python/frida-python-15.1.14[${PYTHON_USEDEP}]
	>=dev-python/tldextract-3.1.2[${PYTHON_USEDEP}]
	>=dev-python/ruamel-yaml-0.16.13[${PYTHON_USEDEP}]
	>=dev-python/click-8.0.1[${PYTHON_USEDEP}]
	>=dev-python/decorator-4.4.2[${PYTHON_USEDEP}]

	dev-python/yara-python[${PYTHON_USEDEP}]

	pdf? ( $(python_gen_cond_dep 'dev-python/pdfkit[${PYTHON_USEDEP}]') )
	www-servers/gunicorn
	genymotion? ( app-emulation/genymotion-bin )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	#regular user support
	sed -e 's|USE_HOME = False|USE_HOME = True|' -i ./mobsf/MobSF/settings.py || die "sed settings failed"

	sed -e '/waitress/d' \
	-e '/pyOpenSSL/d' -e '/cryptography/d' \
	-e '/bs4/d'  -i requirements.txt || die "sed failed"
	sed -e 's|==|>=|' -i requirements.txt || die "sed failed"

	use pdf || sed -e '/pdfkit/d' -i requirements.txt || die "sed failed"

	./manage.py makemigrations
	./manage.py makemigrations StaticAnalyzer
	./manage.py migrate

	eapply_user
}
