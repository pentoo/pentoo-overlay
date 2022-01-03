# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{9..10} )
inherit python-single-r1

MY_P="seafile-pro-server_${PV}_x86-64_CentOS.tar.gz"

DESCRIPTION="Meta package for Seafile Pro Edition, file sync share solution"
HOMEPAGE="https://github.com/haiwen/seafile-server/ http://www.seafile.com/"
SRC_URI="https://download.seafile.com/d/6e5297246c/files/?p=%2Fpro%2F${MY_P}&dl=1 -> ${MY_P}"

LICENSE="seafile"
SLOT="0"
KEYWORDS="amd64"
IUSE="fuse mysql psd sqlite"

#https://download.seafile.com/published/seafile-manual/upgrade/upgrade_notes_for_7.1.x.md
#https://manual.seafile.com/changelog/changelog-for-seafile-professional-server/
RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
	dev-python/pillow[${PYTHON_MULTI_USEDEP}]
	dev-python/pylibmc[${PYTHON_MULTI_USEDEP}]
	dev-python/django-simple-captcha[${PYTHON_MULTI_USEDEP}]

	dev-python/jinja[${PYTHON_MULTI_USEDEP}]
	dev-python/sqlalchemy[sqlite?,${PYTHON_MULTI_USEDEP}]
	psd? ( dev-python/psd-tools )
	dev-python/django-pylibmc[${PYTHON_MULTI_USEDEP}]
	dev-python/ldap3[${PYTHON_MULTI_USEDEP}]
	')

	fuse? ( sys-fs/fuse:0 )
	mysql? ( $(python_gen_cond_dep ' dev-python/mysqlclient[${PYTHON_MULTI_USEDEP}]') )
	sys-libs/libselinux
	dev-libs/nss
	virtual/jre:*"

DEPEND="${RDEPEND}"
