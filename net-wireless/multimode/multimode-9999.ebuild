# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_DEPEND="2"
inherit subversion python

DESCRIPTION=""
HOMEPAGE=""
SRC_URI=""
ESVN_REPO_URI="https://www.cgran.org/svn/projects/multimode"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	=net-wireless/gr-osmosdr-9999
	=net-wireless/gnuradio-9999
	=net-wireless/rtl-sdr-9999"

src_install() {
	cd "${S}"/trunk
        python_convert_shebangs 2 multimode.py
        newbin multimode.py multimode
        dosym /usr/bin/multimode /usr/bin/multimode.py
        insinto /usr/share/${PN}
        doins multimode.grc
}

