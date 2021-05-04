# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Fast GF(256) Cauchy MDS Block Erasure Codec in C++"
HOMEPAGE="https://github.com/f4exb/cm256cc"
SRC_URI="https://github.com/f4exb/cm256cc/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

