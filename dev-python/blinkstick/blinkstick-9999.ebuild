# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_6 )
inherit distutils-r1 git-r3

EGIT_REPO_URI="https://github.com/arvydas/blinkstick-python.git"

DESCRIPTION="BlinkStick Python interface to control devices connected to the computer"
HOMEPAGE="https://github.com/arvydas/blinkstick-python"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
