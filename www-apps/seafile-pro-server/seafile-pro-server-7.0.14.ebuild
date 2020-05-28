# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="Meta package for Seafile Pro Edition, file sync share solution"
HOMEPAGE="https://github.com/haiwen/seafile-server/ http://www.seafile.com/"

LICENSE="GPL-2+-with-openssl-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fuse mysql"

RDEPEND="${PYTHON_DEPS}
	fuse? ( sys-fs/fuse:0 )
	mysql? ( $(python_gen_cond_dep '
		|| ( dev-python/mysqlclient[${PYTHON_MULTI_USEDEP}]
			dev-python/mysql-python[${PYTHON_SINGLE_USEDEP}] ) )
		')
	sys-libs/libselinux
	dev-libs/nss
	virtual/jre:*"
#	system-python? (
#		$(python_gen_cond_dep '
#		dev-python/ldap3[${PYTHON_MULTI_USEDEP}]
#		dev-python/urllib3[${PYTHON_MULTI_USEDEP}]
#		dev-python/mysql-python[${PYTHON_MULTI_USEDEP}]
#		dev-python/python-memcached[${PYTHON_MULTI_USEDEP}]
#		>=dev-python/requests-2.8.0[${PYTHON_MULTI_USEDEP}]
#		=dev-python/pillow-6*[${PYTHON_MULTI_USEDEP}]
#		')
#	)

DEPEND="${RDEPEND}"
