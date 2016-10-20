# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools git-r3

DESCRIPTION="A tool to scan GSM base stations and calculate the local oscillator frequency offset"
HOMEPAGE="https://github.com/scateu/kalibrate-hackrf"
EGIT_REPO_URI="https://github.com/scateu/kalibrate-hackrf.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare(){
#	eautoreconf
	./bootstrap
}
