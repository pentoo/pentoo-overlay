# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{2_7,3_{5,6}} )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1 git-r3

DESCRIPTION="Command line utility for searching and downloading exploits"
HOMEPAGE="https://github.com/vulnersCom/getsploit"
SRC_URI=""

if [[ ${PV} != *9999 ]]; then
	EGIT_REPO_URI="https://github.com/vulnersCom/getsploit"
	EGIT_COMMIT="${PV}"
	EGIT_COMMIT="65258268d83e942d342cd75c6d6ddf39a2e9ec2b"
	KEYWORDS="~amd64 ~x86"
else
	EGIT_REPO_URI="https://github.com/vulnersCom/getsploit"
	KEYWORDS=""
fi

RESTRICT="mirror"
LICENSE="LGPL-3"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/clint[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/texttable[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/vulners[${PYTHON_USEDEP}]"

pkg_postinst() {
	elog
	elog "See documentation: https://github.com/vulnersCom/getsploit#how-to-use"
	elog
}
