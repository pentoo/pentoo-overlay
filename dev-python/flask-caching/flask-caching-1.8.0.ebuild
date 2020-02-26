# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Continuation of the Flask-Cache Extension"
HOMEPAGE="https://github.com/sh4nks/flask-caching"
SRC_URI="https://github.com/sh4nks/flask-caching/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86 ~amd64-linux ~x86-linux"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/flask[${PYTHON_USEDEP}]"
