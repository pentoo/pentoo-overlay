# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Library that generates audio and image CAPTCHAs"
HOMEPAGE="https://pypi.org/project/captcha/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/pillow[${PYTHON_USEDEP}]
	!dev-python/django-simple-captcha"
DEPEND="${RDEPEND}"
