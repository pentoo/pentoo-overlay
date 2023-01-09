# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..11} )
inherit python-single-r1

MY_P="seafile-pro-server_${PV}_x86-64_CentOS.tar.gz"

DESCRIPTION="Meta package for Seafile Pro Edition, file sync share solution"
HOMEPAGE="https://github.com/haiwen/seafile-server/ http://www.seafile.com/"
SRC_URI="https://download.seafile.com/d/6e5297246c/files/?p=%2Fpro%2F${MY_P}&dl=1 -> ${MY_P}"

LICENSE="seafile"
SLOT="0"
KEYWORDS="amd64"
IUSE="fuse mysql psd sqlite"

# https://manual.seafile.com/upgrade/upgrade_notes_for_9.0.x/
# https://manual.seafile.com/changelog/changelog-for-seafile-professional-server/

RDEPEND="${PYTHON_DEPS}
	>=app-misc/elasticsearch-7.16.2
	$(python_gen_cond_dep '
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pylibmc[${PYTHON_USEDEP}]
	dev-python/django-simple-captcha[${PYTHON_USEDEP}]

	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[sqlite?,${PYTHON_USEDEP}]
	psd? ( dev-python/psd-tools )
	dev-python/django-pylibmc[${PYTHON_USEDEP}]
	dev-python/ldap3[${PYTHON_USEDEP}]

	dev-python/lxml[${PYTHON_USEDEP}]

	dev-python/cffi
	dev-python/requests

	')
	fuse? ( sys-fs/fuse:0 )
	mysql? ( $(python_gen_cond_dep ' dev-python/mysqlclient[${PYTHON_USEDEP}]') )
	sys-libs/libselinux
	dev-libs/nss
	virtual/jre:*"

DEPEND="${RDEPEND}"

src_prepare() {
	#match with cffi in RDEPEND section
#	sed -e "s|1.14.0|${CFFI_PV}|" -i seahub/thirdpart/cffi/__init__.py || die "sed failed"
	rm -r seahub/thirdpart/{cffi*,requests*}
	eapply_user
}

pkg_postinst() {
	einfo "follow the official documentation:"
	einfo "https://manual.seafile.com/deploy_pro/download_and_setup_seafile_professional_server/"
}
