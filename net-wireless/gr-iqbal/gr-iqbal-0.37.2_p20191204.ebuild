# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit cmake-utils python-single-r1

DESCRIPTION="gnuradio I/Q balancing"
HOMEPAGE="http://git.osmocom.org/gr-iqbal/"

if [[ ${PV} == 9999* ]]; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://git.osmocom.org/gr-iqbal"
	KEYWORDS=""
else
	HASH_COMMIT="6c9576670a96bc797fd7d203e0c91c8cddea7d28"
	SRC_URI="https://github.com/osmocom/gr-iqbal/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
	KEYWORDS=""
fi

LICENSE="GPL-3"
SLOT="0/${PV}"
IUSE=""

RDEPEND=">=net-wireless/gnuradio-3.8.0.0:=[${PYTHON_SINGLE_USEDEP}]
	net-libs/libosmo-dsp:=
	dev-libs/boost:=
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
