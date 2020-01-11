# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )
inherit autotools python-single-r1

DESCRIPTION="Meta package for Seafile Pro Edition, file sync share solution"
HOMEPAGE="https://github.com/haiwen/seafile-server/ http://www.seafile.com/"

LICENSE="GPL-2+-with-openssl-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fuse"

#list of deps ./ci/requirements.txt
RDEPEND="${PYTHON_DEPS}
	fuse? ( sys-fs/fuse )
	sys-libs/libselinux
	dev-libs/nss

	dev-python/ldap3[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/mysql-python[${PYTHON_USEDEP}]
	dev-python/python-memcached[${PYTHON_USEDEP}]
	>=dev-python/requests-2.8.0[${PYTHON_USEDEP}]
	=dev-python/pillow-5*[${PYTHON_USEDEP}]

	virtual/jre:*"

DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
