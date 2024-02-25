# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Library that generates audio and image CAPTCHAs"
HOMEPAGE="https://pypi.org/project/captcha/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

RESTRICT="test"

RDEPEND="dev-python/pillow[${PYTHON_USEDEP}]
	!dev-python/django-simple-captcha"
DEPEND="${RDEPEND}"
