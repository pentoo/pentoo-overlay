# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.*"

if [[ ${PV} == "9999" ]] ; then
	SCM=mercurial
	EHG_REPO_URI="http://d-rats.com/hg/chirp.hg"
fi

inherit distutils ${SCM}

DESCRIPTION="Free open-source tool for programming your amateur radio"
HOMEPAGE="http://chirp.danplanet.com"

if [[ ${PV} == "9999" ]] ; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-python/pyserial
	dev-libs/libxml2[python]"
RDEPEND="${DEPEND}
	dev-python/pygtk"

src_prepare() {
	sed -i -e "/share\/doc\/chirp/d" setup.py || die
	distutils_src_prepare
}

src_test() {
	testing() {
		pushd tests &> /dev/null
		PYTHONPATH="../build-${PYTHON_ABI}/lib" "$(PYTHON)" run_tests
		popd &> /dev/null
	}
	python_execute_function testing
}
