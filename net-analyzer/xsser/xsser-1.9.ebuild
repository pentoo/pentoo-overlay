# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

GITHUB_REPOSITORY="epsylon/xsser"
GITHUB_TAG="xsser-v${PV}"
inherit desktop distutils-r1 github-archive

DESCRIPTION="Cross Site Scripter (XSSer) - automatic framework to detect, exploit and report XSS vulnerabilities"
HOMEPAGE="https://xsser.03c8.net"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

IUSE="dom gtk"

RDEPEND="
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/pycurl[${PYTHON_USEDEP}]
	dom? ( dev-python/selenium[${PYTHON_USEDEP}] )
	gtk? (
		dev-python/pycairo[${PYTHON_USEDEP}]
		dev-python/pygeoip[${PYTHON_USEDEP}]
		dev-python/pygobject[cairo,${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		x11-libs/gtk+:3[introspection]
	)
"

distutils_enable_tests pytest

python_test() {
	# test_pdf needs dev-python/fpdf2 which is not packaged in ::gentoo
	epytest -k "not test_pdf"
}

src_prepare() {
	default
	# stop setup.py from (unconditionally) installing its absolute-path
	# data_files: under PEP517 wheel installs they are misplaced into
	# site-packages/usr/share. src_install below installs them instead.
	sed -i \
		-e "s|    data_files = \[('/usr/share/doc/xsser/', doc_files),|    data_files = [],|" \
		-e "\|^                  ('/usr/share|d" \
		setup.py || die

	# ship the runtime data files with the core.fuzzing package (upstream
	# only installs them via absolute-path data_files) ...
	sed -i "s|    packages = \['core', 'core.fuzzing', 'core.post', 'core.driver'\],|&\n    package_data = {\"core\": [\"fuzzing/*.txt\"]},|" setup.py || die
	grep -q 'package_data = ' setup.py || die "failed to add package_data to setup.py"
	# ... and read them relative to the module: xsser crashes when it is
	# launched outside its source tree otherwise
	sed -i \
		-e 's|open("core/fuzzing/user-agents.txt")|open(os.path.join(os.path.dirname(__file__), "fuzzing", "user-agents.txt"))|g' \
		-e "s|open('core/fuzzing/dorks.txt')|open(os.path.join(os.path.dirname(__file__), 'fuzzing', 'dorks.txt'))|g" \
		core/main.py core/curlcontrol.py core/dork.py || die
	sed -i 's|^import urllib.request, urllib.error, urllib.parse, traceback|import os, urllib.request, urllib.error, urllib.parse, traceback|' core/dork.py || die
	grep -q '^import os, urllib' core/dork.py || die "failed to add os import to core/dork.py"
}

src_install() {
	distutils-r1_src_install
	if use gtk; then
		insinto /usr/share/xsser/gtk
		doins -r gtk/images gtk/docs gtk/map gtk/xsser.ui
		domenu gtk/xsser.desktop
	fi
	dodoc doc/*
}
