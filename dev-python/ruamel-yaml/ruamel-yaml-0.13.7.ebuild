# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{4,5} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="YAML parser/emitter that supports roundtrip comment preservation"
HOMEPAGE="https://pypi.python.org/pypi/ruamel.yaml"
SRC_URI="https://bitbucket.org/ruamel/yaml/get/${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libyaml test"
REQUIRED_USE="${PYTHON_REQUIRED_USE} test? ( libyaml )"
# ^ tests can't be properly unbundled from the libyaml c-extension

#	dev-python/ruamel-base[${PYTHON_USEDEP}]
RDEPEND="${PYTHON_DEPS}
	dev-python/typing[${PYTHON_USEDEP}]
	libyaml? ( dev-libs/libyaml )
	$(python_gen_cond_dep 'dev-python/ruamel-ordereddict[${PYTHON_USEDEP}]' python2_7)"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	libyaml? ( $(python_gen_cond_dep 'dev-python/cython[${PYTHON_USEDEP}]' python2_7 'python3*') )
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_configure_all() {
	if ! use libyaml ; then
		sed -i -e 's|\(ext_modules\)|no_\1|' __init__.py || die
	fi
}

python_install() {
	distutils-r1_python_install --single-version-externally-managed
}

python_test() {
	py.test -v _test/test_*.py || die
}
