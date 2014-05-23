# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Mifare Classic Offline Cracker"
HOMEPAGE="https://code.google.com/p/mfoc/"
SRC_URI="https://code.google.com/p/mfoc/downloads/detail?name=mfoc-0.10.7.tar.bz2&can=2&q= -> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libnfc-1.7.0"
RDEPEND="${DEPEND}"
