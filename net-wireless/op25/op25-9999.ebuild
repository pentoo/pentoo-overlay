# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit subversion

DESCRIPTION="software-defined analyzer for APCO P25 signals"
HOMEPAGE="http://op25.osmocom.org/wiki"
ESVN_REPO_URI="http://op25.osmocom.org/svn/trunk"

LICENSE="GPL"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="net-wireless/gnuradio
	sci-libs/itpp
	dev-libs/boost"
RDEPEND="${DEPEND}"

src_prepare() {
	cd "${S}"/blocks
	./bootstrap

	cd "${S}"/imbe_vocoder
	./bootstrap

	cd "${S}"/repeater
	./bootstrap
}

src_configure() {
	cd "${S}"/blocks
	econf

	cd "${S}"/imbe_vocoder
	econf

	cd "${S}"/repeater
	econf
}
src_compile() {
	cd "${S}"/blocks
	sed -i 's#-I$(GNURADIO_CORE_INCLUDEDIR)/swig#-I$(GNURADIO_CORE_INCLUDEDIR)/swig -I$(includedir)/gruel/swig#' Makefile.common
	emake

	cd "${S}"/imbe_vocoder
	emake

	cd "${S}"/repeater
	sed -i 's#-I$(GNURADIO_CORE_INCLUDEDIR)/swig#-I$(GNURADIO_CORE_INCLUDEDIR)/swig -I$(includedir)/gruel/swig#' Makefile.common
	cp "${S}"/blocks/src/lib/op25_imbe_frame.h "${S}"/repeater/src/lib
	cp "${S}"/blocks/src/lib/op25_yank.h "${S}"/repeater/src/lib
	cp "${S}"/blocks/src/lib/op25_golay.h "${S}"/repeater/src/lib
	cp "${S}"/blocks/src/lib/op25_hamming.h "${S}"/repeater/src/lib
	cp "${S}"/blocks/src/lib/op25_p25_frame.h "${S}"/repeater/src/lib
	emake
}
src_install() {
	cd "${S}"/blocks
	emake DESTDIR="${ED}" install

	cd "${S}"/imbe_vocoder
	emake DESTDIR="${ED}" install

	cd "${S}"/repeater
	emake DESTDIR="${ED}" install
}
