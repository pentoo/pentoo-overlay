# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

MY_PN="Flask-SocketIO"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Socket.IO integration for Flask applications"
HOMEPAGE="https://github.com/miguelgrinberg/Flask-SocketIO/"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND=">=dev-python/flask-0.9[${PYTHON_USEDEP}]
	dev-python/socketio-client[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
