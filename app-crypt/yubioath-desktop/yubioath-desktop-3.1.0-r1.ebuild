# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 )

DESCRIPTION="Library and tool for personalization of Yubico's YubiKey NEO"
HOMEPAGE="http://opensource.yubico.com/yubioath-desktop"
SRC_URI="http://opensource.yubico.com/yubioath-desktop/releases/${P}.tar.gz"

KEYWORDS="~amd64"
SLOT="0"
LICENSE="BSD-2"

inherit distutils-r1

RDEPEND=">=app-crypt/ccid-1.4.25
	dev-python/click
	dev-python/pyside
	|| ( dev-python/pycryptodome dev-python/pycrypto )
	dev-python/pyscard
	dev-python/pbkdf2
	dev-python/pyusb"

DEPEND="${RDEPEND}"

src_install()
{
	distutils-r1_src_install || die
	domenu resources/yubioath.desktop
	doicon resources/yubioath.xpm
}
