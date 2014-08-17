# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI="5"

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils

DESCRIPTION="Action Message Format (AMF) support for Python including integration with mutliple frameworks"
HOMEPAGE="http://pyamf.org"
SRC_URI="https://github.com/hydralabs/pyamf/archive/release-${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="c-extension cython django elixir lxml sqlalchemy twisted"

DEPEND="dev-python/setuptools"

RDEPEND="cython? ( dev-python/cython )
	django? ( dev-python/django )
	elixir? ( dev-lang/elixir )
	lxml? ( dev-python/lxml )
	sqlalchemy? ( dev-python/sqlalchemy )
	twisted? ( dev-python/twisted-core )"

#optioanl extra deps
#        'wsgi': ['wsgiref'],

S="${WORKDIR}/${PN}-release-${PV}"

python_configure_all() {
	if use !c-extension; then
		mydistutilsargs=( --disable-ext )
	fi
}

#src_test() {
#	#trial pyamf || die "test failed"
#	PYTHONPATH=. "${python}" setup.py test || die "test failed"
#}
