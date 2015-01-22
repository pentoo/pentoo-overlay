# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python interface to Apple Bonjour and compatible DNS-SD libraries (Avahi)"
HOMEPAGE="http://code.google.com/p/pybonjour/"
SRC_URI="http://pybonjour.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/setuptools
	net-dns/avahi[mdnsresponder-compat]"
DEPEND=""
