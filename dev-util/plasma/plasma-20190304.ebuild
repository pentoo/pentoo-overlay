# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="An interactive disassembler for x86/ARM/MIPS"
HOMEPAGE="https://github.com/plasma-disassembler/plasma"

if [[ "${PV}" == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/plasma-disassembler/plasma"
	inherit git-r3
	#KEYWORDS=""
else
	HASH_COMMIT=ec7df9b2b9b356dd5d8caf01b7e68c0ab5a1ef42
	SRC_URI="https://github.com/plasma-disassembler/"${PN}"/archive/"${HASH_COMMIT}" -> "${P}".tar.gz"
	S=""${WORKDIR}"/plasma-disassembler-"${PN}"-"${HASH_COMMIT:0:7}""
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-libs/capstone[python,${PYTHON_USEDEP}]
	dev-libs/keystone
	dev-python/pyelftools[${PYTHON_USEDEP}]
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/msgpack[${PYTHON_USEDEP}]"
#	dev-python/nose[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}"

PATCHES=""${FILESDIR}"/${PN}-remove_pip.patch"
