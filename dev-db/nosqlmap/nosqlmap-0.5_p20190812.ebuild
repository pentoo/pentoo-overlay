# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils

DESCRIPTION="A tool to automate injection attacks and exploit weaknesses in NoSQL"
HOMEPAGE="https://github.com/codingo/NoSQLMap"

HASH_COMMIT="2387f6bed1f6c010593f10abcaddf977893c1c61"
SRC_URI="https://github.com/codingo/NoSQLMap/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/couchdb-python-1.0[${PYTHON_USEDEP}]
	>=dev-python/httplib2-0.9[${PYTHON_USEDEP}]
	>=dev-python/ipcalc-1.1.3[${PYTHON_USEDEP}]
	>=dev-python/pbkdf2-1.3[${PYTHON_USEDEP}]
	>=dev-python/pymongo-2.7.2[${PYTHON_USEDEP}]
	>=dev-python/requests-2.20.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/NoSQLMap-${HASH_COMMIT}"

pkg_setup() {
	python_setup
}

src_prepare() {
	sed -i "s|\"NoSQLMap==0.7\", ||g" setup.py || die "sed filed!"

	#relax deps
	sed -i "s|==|>=|g" setup.py || die "sed filed!"

	python_fix_shebang "${S}"
	default
}
