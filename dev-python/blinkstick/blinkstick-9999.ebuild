# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="BlinkStick Python interface to control devices connected to the computer"
HOMEPAGE="https://github.com/arvydas/blinkstick-python"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/arvydas/blinkstick-python"
else
	HASH_COMMIT="49506768795ac1b4c2389fbde3471a20bd799dbe" # 2020-02-11

	SRC_URI="https://github.com/arvydas/blinkstick-python/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~x86"
	S="${WORKDIR}/${PN}-python-${HASH_COMMIT}"
fi

LICENSE="BSD"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	dev-python/pyusb[${PYTHON_USEDEP}]"
