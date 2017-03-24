# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

inherit distutils-r1

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
	SRC_URI="https://github.com/mottosso/Qt.py/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}"/Qt.py-"${PV}"
fi

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	|| (
		dev-python/PyQt5[${PYTHON_USEDEP}]
		dev-python/PyQt4[${PYTHON_USEDEP}]
		dev-python/pyside[${PYTHON_USEDEP}]
		)"
