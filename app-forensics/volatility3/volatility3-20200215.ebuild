# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )
inherit distutils-r1

DESCRIPTION="Framework for analyzing volatile memory"
HOMEPAGE="https://www.volatilityfoundation.org/"
HASH_COMMIT="3a824b519e589075f7269a8e6869ec2fcd71fdf3"
SRC_URI="https://github.com/volatilityfoundation/volatility3/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}-${HASH_COMMIT}

DEPEND="app-arch/unzip"
RDEPEND=">=dev-libs/distorm64-3[${PYTHON_USEDEP}]
	dev-libs/libpcre
	dev-python/pycryptodome[${PYTHON_USEDEP}]"
