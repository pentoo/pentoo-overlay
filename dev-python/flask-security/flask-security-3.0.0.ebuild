# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{6,7} )

inherit distutils-r1

MY_PN="Flask-Security"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple security for Flask apps"
HOMEPAGE="https://github.com/mattupstate/flask-security"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/flask[${PYTHON_USEDEP}]
	>=dev-python/flask-login-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/flask-mail-0.7.3[${PYTHON_USEDEP}]
	>=dev-python/flask-principal-0.3.3[${PYTHON_USEDEP}]
	>=dev-python/flask-wtf-0.13.1[${PYTHON_USEDEP}]
	>=dev-python/flask-babelex-0.9.3[${PYTHON_USEDEP}]
	>=dev-python/itsdangerous-0.21[${PYTHON_USEDEP}]
	>=dev-python/passlib-1.7[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
