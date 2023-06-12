# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Calculate the local oscillator frequency offset using GSM stations"
HOMEPAGE="https://github.com/scateu/kalibrate-hackrf"
HASH_COMMIT="5d907327a490cc6b8ede7862d73c5e7394a5a253"
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
