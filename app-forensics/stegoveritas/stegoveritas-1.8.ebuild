# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="Automatic image steganography analysis tool"
HOMEPAGE="https://github.com/bannsec/stegoVeritas"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/bannsec/stegoVeritas"
else
	SRC_URI="https://github.com/bannsec/stegoVeritas/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="jpeg test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	app-arch/p7zip
	app-crypt/steghide
	app-forensics/foremost
	dev-python/apng[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/exifread[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pillow[jpeg?,${PYTHON_USEDEP}]
	dev-python/prettytable[${PYTHON_USEDEP}]
	dev-python/pypng[${PYTHON_USEDEP}]
	dev-python/python-magic[${PYTHON_USEDEP}]
	dev-python/python-xmp-toolkit[${PYTHON_USEDEP}]
	dev-python/stegoveritas-binwalk[${PYTHON_USEDEP}]
	dev-python/stegoveritas-pfp[${PYTHON_USEDEP}]
	media-libs/exempi:=
	media-libs/exiftool"

S="${WORKDIR}/stegoVeritas-${PV}"

distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all
	rm "${ED}"/usr/bin/stegoveritas_install_deps || die
}
