# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..9} )

inherit distutils-r1

DESCRIPTION="A script for checking the hardening options in the Linux kernel config"
HOMEPAGE="https://github.com/a13xp0p0v/kconfig-hardened-check"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/a13xp0p0v/kconfig-hardened-check"
else
	SRC_URI="https://github.com/a13xp0p0v/kconfig-hardened-check/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 arm64 x86"
fi

LICENSE="GPL-3"
SLOT="0"

#FIXME: should match kernel, [major_number].[kernel_version].[kernel_patchlevel]
RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

src_install() {
	distutils-r1_src_install
	dodoc -r "${PN//-/_}"/config_files/ README.md
}
