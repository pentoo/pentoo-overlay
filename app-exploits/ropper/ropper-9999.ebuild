# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

DESCRIPTION="Use to display information about binary files in different file formats"
HOMEPAGE="https://scoding.de/ropper https://github.com/sashs/Ropper"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sashs/Ropper"
else
#	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	SRC_URI="https://github.com/sashs/Ropper/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/Ropper-${PV}"

	# wait until dev-libs/keystone is stable
	KEYWORDS="~amd64 ~arm64 ~mips ~x86"
fi

LICENSE="BSD"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	dev-libs/capstone[python,${PYTHON_USEDEP}]
	!dev-libs/capstone-bindings
	dev-libs/keystone[python,${PYTHON_USEDEP}]
	dev-python/filebytes[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
