# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="*:2.7"
DISTUTILS_SRC_TEST=setup.py

MY_PN=Impacket
MY_P=${MY_PN}-${PV}

inherit distutils

DESCRIPTION="A collection of Python classes focused on providing access to network packets"
HOMEPAGE="http://code.google.com/p/impacket"
SRC_URI="http://impacket.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/impacket
