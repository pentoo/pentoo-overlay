# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6,7} )

DESCRIPTION="An interactive disassembler for x86/ARM/MIPS"
HOMEPAGE="https://github.com/plasma-disassembler/plasma"

if [[ "${PV}" == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/plasma-disassembler/plasma"
	inherit git-r3
	KEYWORDS=""
else
	MY_COMMIT=432cac6544d5c23b938174da5659a91e7b6c73fb
	SRC_URI="https://github.com/plasma-disassembler/"${PN}"/tarball/"${MY_COMMIT}" -> "${P}".tar.gz"
	S=""${WORKDIR}"/plasma-disassembler-"${PN}"-"${MY_COMMIT:0:7}""
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-libs/capstone
	dev-python/pyelftools
	dev-python/future
	dev-python/msgpack
	dev-libs/keystone
	dev-python/nose"
RDEPEND="${DEPEND}"
