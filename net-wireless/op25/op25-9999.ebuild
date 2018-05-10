# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils python-single-r1 flag-o-matic

DESCRIPTION="software-defined analyzer for APCO P25 signals"
HOMEPAGE="http://osmocom.org/projects/op25/wiki"
inherit git-r3
#EGIT_REPO_URI="https://github.com/balint256/op25.git"
EGIT_REPO_URI="https://git.osmocom.org/op25"

LICENSE="GPL"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=net-wireless/gnuradio-3.7:=
	sci-libs/itpp
	dev-libs/boost
	net-libs/libpcap"
RDEPEND="${DEPEND}"

src_prepare() {
	#workaround: compile with gcc 6
#	append-cxxflags -Wno-narrowing
	append-flags -funsigned-char
	eapply_user
}
