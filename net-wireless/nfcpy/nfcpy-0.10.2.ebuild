# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )

inherit python-r1 python-utils-r1

DESCRIPTION="A tool to read/write NFC tags or communicate with another NFC device"
HOMEPAGE="https://launchpad.net/nfcpy"
SRC_URI="https://launchpad.net/nfcpy/0.10/${PV}/+download/${P}.tar.gz"

LICENSE="EUPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#python_test() {
#	"${PYTHON}" tests/test-example-programs.py || die
#}

src_install() {
	python_moduleinto nfcpy
	python_foreach_impl python_domodule nfc/.

	insinto /usr/share/"${PN}"/examples
	doins examples/*.py
}
