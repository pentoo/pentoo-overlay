# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )
inherit distutils-r1

DESCRIPTION="Extensions for Django"
HOMEPAGE="https://django-extensions.readthedocs.org/ https://github.com/django-extensions/django-extensions https://pypi.python.org/pypi/django-extensions"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc graphviz mysql postgres s3 sqlite test vcard"

RDEPEND="dev-python/django[sqlite?,${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/shortuuid[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
	graphviz? ( dev-python/pygraphviz[${PYTHON_USEDEP}] )
	s3? (  dev-python/boto[${PYTHON_USEDEP}] )
	vcard? ( dev-python/vobject[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
	test? ( dev-python/django[sqlite,${PYTHON_USEDEP}] )"

DOCS="README.rst docs/AUTHORS"
PYTHON_MODULES="${PN/-/_}"

src_compile() {
	distutils-r1_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		emake html
		popd > /dev/null
	fi
}

src_test() {
	testing() {
		# Disable warnings.
		# https://github.com/django-extensions/django-extensions/issues/570
		python_execute PYTHONPATH="build-${PYTHON_ABI}/lib" PYTHONWARNINGS="" "$(PYTHON)" run_tests.py
	}
	python_execute_function testing
}

src_install() {
	distutils-r1_src_install

	if use doc; then
		dohtml -r docs/_build/html/
	fi
}
