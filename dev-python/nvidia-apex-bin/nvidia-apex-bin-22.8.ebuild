# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_10 )

#inherit distutils-r1
inherit python-any-r1

#22.08 -> 22.8
MY_P="apex-${PV}-py3.10-linux-x86_64.egg"

DESCRIPTION="NVIDIA-maintained utilities to streamline mixed precision and distributed training in Pytorch"
HOMEPAGE="https://github.com/NVIDIA/apex"
SRC_URI="https://dev.pentoo.ch/~blshkv/distfiles/nvidia-${MY_P} -> ${P}.zip"

LICENSE=""
SLOT="0"
#KEYWORDS="amd64 ~arm64 x86"
IUSE=""

#[${PYTHON_USEDEP}]
RDEPEND=">=dev-python/tqdm-4.28.1
	>=dev-python/numpy-1.15.3
	>=dev-python/pyyaml-5.1
"
DEPEND="${RDEPEND}"

RESTRICT="test"

S=${WORKDIR}

src_install() {
	insinto "$(python_get_sitedir)/${MY_P}"
	doins -r "./"
}
