# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Socket.IO integration for Flask applications"
HOMEPAGE="https://github.com/miguelgrinberg/Flask-SocketIO/"
SRC_URI="https://github.com/miguelgrinberg/Flask-SocketIO/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/Flask-SocketIO-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/flask-0.9[${PYTHON_USEDEP}]
	>=dev-python/python-socketio-5.12.0[${PYTHON_USEDEP}]
"
BDEPEND="
	${RDEPEND}
	test? (
		dev-python/redis[${PYTHON_USEDEP}]
	)
"

distutils_enable_sphinx docs
distutils_enable_tests pytest

python_install_all() {
	if use examples; then
		docinto examples
		dodoc -r example/*
		docompress -x /usr/share/doc/${PF}/examples
	fi
	distutils-r1_python_install_all
}
