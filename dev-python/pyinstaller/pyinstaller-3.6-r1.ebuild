# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
PYTHON_REQ_USE='threads(+)'

inherit distutils-r1

DESCRIPTION="Program converting Python programs into stand-alone executables"
HOMEPAGE="https://www.pyinstaller.org"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pyinstaller/pyinstaller"
	EGIT_BRANCH="develop"
else
	MY_PN="PyInstaller"
	MY_P="${MY_PN}-${PV}"
	SRC_URI="https://github.com/pyinstaller/pyinstaller/releases/download/v${PV}/${MY_P}.tar.gz"
	KEYWORDS="amd64 ~arm64 x86"

	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="clang debug doc leak-detector"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

QA_PREBUILT="usr/lib/python*/site-packages/PyInstaller/bootloader/Linux-*"

RDEPEND="${PYTHON_DEPS}
		sys-libs/zlib
		>=dev-python/macholib-1.8[${PYTHON_USEDEP}]
		dev-python/altgraph[${PYTHON_USEDEP}]
		>=dev-python/pefile-2018.08.08[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	leak-detector? ( dev-libs/boehm-gc )
	clang? ( sys-devel/clang )
	!clang? ( sys-devel/gcc )"

src_install() {
	distutils-r1_src_install
	insinto /etc/revdep-rebuild
	doins "${FILESDIR}"/50${PN}
}
