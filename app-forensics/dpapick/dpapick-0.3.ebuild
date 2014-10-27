# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit   distutils-r1

MY_REV="39f11f730331"
DESCRIPTION="Open-source tool that allows decryption of DPAPI structures in an offline way"
HOMEPAGE="http://www.dpapick.com"
SRC_URI="https://bitbucket.org/jmichel/dpapick/get/v${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/m2crypto
	dev-python/pyasn1
	dev-python/python-registry"
#Optional:
#python-sqlite3 for Google Chrome password database
#CFPropertyList for Apple Safari keychain.plist
#MoonSols to convert hibernation file to usable memory dumps

S="${WORKDIR}/jmichel-dpapick-${MY_REV}"

src_install() {
	distutils-r1_src_install

	for bin_list in chrome dropbox getcredentialsha1 googletalk icloud lsasecrets; do
#		python_fix_shebang "${ED}/bin/${bin_list}"
		newbin examples/${bin_list} dpapick_${bin_list}
	done
}
