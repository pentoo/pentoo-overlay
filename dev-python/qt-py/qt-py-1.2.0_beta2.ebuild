# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

MY_PV="${PV/_beta/.b}"
DESCRIPTION="Minimal Python 2 & 3 shim around all Qt bindings"
HOMEPAGE="https://github.com/mottosso/Qt.py"

LICENSE="MIT"
SLOT="0"

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mottosso/Qt.py.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	SRC_URI="https://github.com/mottosso/Qt.py/archive/${PN}-${MY_PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/Qt.py-"${MY_PV}"
fi

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/PyQt5[${PYTHON_USEDEP}]"

python_prepare_all() {
	#do not install LICENSE into /usr
	sed -e '/data_files/d' -i setup.py || die
	distutils-r1_python_prepare_all
}
