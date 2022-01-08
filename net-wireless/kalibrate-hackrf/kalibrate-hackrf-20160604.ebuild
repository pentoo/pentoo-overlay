# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Calculate the local oscillator frequency offset using GSM stations"
HOMEPAGE="https://github.com/scateu/kalibrate-hackrf"
HASH_COMMIT="2492c20822ca6a49dce97967caf394b1d4b2c43e"
SRC_URI="https://github.com/scateu/kalibrate-hackrf/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sci-libs/fftw
	net-libs/libhackrf"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_prepare(){
#	eautoreconf
	./bootstrap
	eapply_user
}
