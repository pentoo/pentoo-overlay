# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

MY_PN="Mobile-Security-Framework-MobSF"

DESCRIPTION="Automated, all-in-one mobile application (Android/iOS/Windows) pen-testing"
HOMEPAGE="https://github.com/MobSF/Mobile-Security-Framework-MobSF"
SRC_URI="https://github.com/MobSF/Mobile-Security-Framework-MobSF/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

#Dynamic Analysis or genymotion
IUSE="genymotion"

QA_FLAGS_IGNORED="usr/lib/python.*/site-packages/mobsf/DynamicAnalyzer.*
		usr/lib/python.*/site-packages/mobsf/StaticAnalyzer.*"
QA_PRESTRIPPED="usr/lib/python.*/site-packages/mobsf/DynamicAnalyzer.*
		usr/lib/python.*/site-packages/mobsf/StaticAnalyzer.*"

RDEPEND="
	>=dev-python/django-3.1.5[${PYTHON_USEDEP}]
	>=dev-python/rsa-4.7[${PYTHON_USEDEP}]
	>=dev-python/requests-2.25.1[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup4-0.0.1[${PYTHON_USEDEP}]
	>=dev-python/colorlog-4.7.2[${PYTHON_USEDEP}]
	>=dev-python/macholib-1.14[${PYTHON_USEDEP}]
	>=dev-python/whitenoise-6.8.2[${PYTHON_USEDEP}]
	>=dev-python/psutil-5.8.0[${PYTHON_USEDEP}]
	>=dev-python/shelljob-0.6.2[${PYTHON_USEDEP}]
	>=dev-python/asn1crypto-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/distro-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/IP2Location-8.10.4[${PYTHON_USEDEP}]
	>=dev-python/google-play-scraper-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/apkid-3.0.0[${PYTHON_USEDEP}]
	>=virtual/frida-17.0.0[${PYTHON_USEDEP}]
	>=dev-python/tldextract-5.1.3[${PYTHON_USEDEP}]
	>=dev-python/openstep-parser-2.0.1[${PYTHON_USEDEP}]
	>=dev-python/svgutils-0.3.4[${PYTHON_USEDEP}]
	>=dev-python/arpy-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/apksigtool-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/tzdata-2023.3[${PYTHON_USEDEP}]
	>=dev-python/http_tools-6.0.0[${PYTHON_USEDEP}]
	>=dev-python/libsast-3.1.8[${PYTHON_USEDEP}]
	>=dev-python/paramiko-3.3.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.16.0[${PYTHON_USEDEP}]
	>=dev-python/python3-saml-1.16.0[${PYTHON_USEDEP}]
	>=dev-python/bcrypt-4.0.1[${PYTHON_USEDEP}]
	>=dev-python/psycopg-2.9.10[${PYTHON_USEDEP}]
	>=dev-util/lief-0.16.6[${PYTHON_USEDEP}]
	>=dev-python/packaging-24.2[${PYTHON_USEDEP}]
	>=dev-python/django-ratelimit-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/django-q2-1.7.4[${PYTHON_USEDEP}]
	>=dev-python/defusedxml-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/bleach-6.2.0[${PYTHON_USEDEP}]
	www-servers/gunicorn
	genymotion? ( app-emulation/genymotion-bin )"
DEPEND="${RDEPEND}"

src_prepare() {
	#regular user support
	sed -e 's|USE_HOME = False|USE_HOME = True|' -i ./mobsf/MobSF/settings.py || die "sed settings failed"

	./manage.py makemigrations
	./manage.py makemigrations StaticAnalyzer
	./manage.py migrate

	eapply_user
}
