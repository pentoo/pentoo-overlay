# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_DEPEND="2"

inherit subversion autotools python

DESCRIPTION="software-defined analyzer for APCO P25 signals"
HOMEPAGE="http://op25.osmocom.org/wiki"
ESVN_REPO_URI="http://op25.osmocom.org/svn/trunk"

LICENSE="GPL"
SLOT="0"
KEYWORDS="-*"
IUSE=""

DEPEND="<net-wireless/gnuradio-3.7:=
	sci-libs/itpp
	dev-libs/boost
	net-libs/libpcap"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	cd "${S}"/blocks
	#eautoreconf
	./bootstrap

	cd "${S}"/imbe_vocoder
	#eautoreconf
	./bootstrap

	cd "${S}"/repeater
	#eautoreconf
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
