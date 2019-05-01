# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} pypy )

inherit distutils-r1

DESCRIPTION="JWT (JSON Web Tokens) for Flask applications"
HOMEPAGE="https://github.com/mattupstate/flask-jwt"
SRC_URI="https://github.com/mattupstate/flask-jwt/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/flask[${PYTHON_USEDEP}]
	dev-python/pyjwt[${PYTHON_USEDEP}]"
