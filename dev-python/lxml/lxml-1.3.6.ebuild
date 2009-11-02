# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/lxml/lxml-1.3.6.ebuild,v 1.8 2008/05/26 15:30:14 armin76 Exp $

NEED_PYTHON=2.3

inherit distutils eutils multilib

DESCRIPTION="lxml is a Pythonic binding for the libxml2 and libxslt libraries"
HOMEPAGE="http://codespeak.net/lxml/"
SRC_URI="http://codespeak.net/lxml/${P}.tgz"

LICENSE="BSD GPL-2 as-is"
SLOT="0"
KEYWORDS="amd64 ~hppa ia64 ppc sparc x86"
IUSE="doc examples"

# Note: This version comes with it's own bundled svn version of pyrex
DEPEND=">=dev-libs/libxml2-2.6.16
		>=dev-libs/libxslt-1.1.12
		>=dev-python/setuptools-0.6_rc5"

src_install() {
	distutils_src_install

	if use doc; then
		dohtml doc/html/*
		dodoc *.txt
		docinto doc
		dodoc doc/*.txt
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r samples/*
	fi
}

src_test() {
	distutils_python_version
	python setup.py build_ext -i || die "building extensions for test use failed"
	einfo "Running test"
	python test.py || die "tests failed"
	export PYTHONPATH="${PYTHONPATH}:${S}/src"
	einfo "Running selftest"
	python selftest.py || die "selftest failed"
	einfo "Running selftest2"
	python selftest2.py || die "selftest2 failed"
}
