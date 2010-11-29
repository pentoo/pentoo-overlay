# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs linux-info eutils subversion
EAPI=2
MY_P=${P/\./-}
MY_P=${MY_P/./-R}
S=${WORKDIR}/${MY_P}

DESCRIPTION="IEEE 802.11 wireless LAN sniffer"
HOMEPAGE="http://www.kismetwireless.net/"
SRC_URI=""
ESVN_REPO_URI="https://www.kismetwireless.net/code/svn/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE="+ncurses +pcre speech +plugin-autowep +plugin-btscan +plugin-dot15d4 +plugin-ptw +plugin-spectools"

DEPEND="${RDEPEND}"
RDEPEND="net-wireless/wireless-tools
	net-libs/libpcap
	>=dev-libs/libnl-1.1
	ncurses? ( sys-libs/ncurses )
	speech? ( app-accessibility/flite )
	plugin-btscan? ( net-wireless/bluez )
	plugin-dot15d4? ( <dev-libs/libusb-1 )
	plugin-spectools? ( net-wireless/spectools )"

src_compile() {
	cd "${S}"
	epatch "${FILESDIR}"/kismet-pentoo.patch

	sed -i -e "s:^\(logtemplate\)=\(.*\):\1=/tmp/\2:" \
		conf/kismet.conf.in

	# Don't strip and set correct mangrp
	sed -i -e 's| -s||g' \
		-e 's|@mangrp@|root|g' Makefile.in

	# the configure script only honors '--disable-foo'
#	local myconf="--disable-gpsmap"

	if ! use ncurses; then
		myconf="${myconf} --disable-curses --disable-panel"
	fi

	if ! use pcre; then
		myconf="${myconf} --disable-pcre"
	fi

	econf ${myconf} \
		--with-linuxheaders="${KV_DIR}" || die "econf failed"

	emake dep || die "emake dep failed"
	emake || die "emake failed"

	if use plugin-autowep; then
		cd "${S}"/plugin-autowep
		KIS_SRC_DIR="${S}" emake || die "emake failed"
	fi
	if use plugin-btscan; then
		cd "${S}"/plugin-btscan
		KIS_SRC_DIR="${S}" emake || die "emake failed"
	fi
	if use plugin-dot15d4; then
		cd "${S}"/plugin-dot15d4
		KIS_SRC_DIR="${S}" emake || die "emake failed"
	fi
	if use plugin-ptw; then
		cd "${S}"/plugin-ptw
		KIS_SRC_DIR="${S}" emake || die "emake failed"
	fi
	if use plugin-spectools; then
		cd "${S}"/plugin-spectools
		KIS_SRC_DIR="${S}" emake || die "emake failed"
	fi
}

src_install () {
	if use plugin-autowep; then
		cd "${S}"/plugin-autowep
		KIS_SRC_DIR="${S}" emake DESTDIR="${D}" install || die "emake install failed"
	fi
	if use plugin-btscan; then
		cd "${S}"/plugin-btscan
		KIS_SRC_DIR="${S}" emake DESTDIR="${D}" install || die "emake install failed"
	fi
	if use plugin-dot15d4; then
		cd "${S}"/plugin-dot15d4
		KIS_SRC_DIR="${S}" emake DESTDIR="${D}" install || die "emake install failed"
	fi
	if use plugin-ptw; then
		cd "${S}"/plugin-ptw
		KIS_SRC_DIR="${S}" emake DESTDIR="${D}" install || die "emake install failed"
	fi
	if use plugin-spectools; then
		cd "${S}"/plugin-spectools
		KIS_SRC_DIR="${S}" emake DESTDIR="${D}" install || die "emake install failed"
	fi

	cd "${S}"
	emake DESTDIR="${D}" install || die "emake install failed"

	##dragorn would prefer I set fire to my head than do this, but it works
        # install headers for external plugins
        insinto /usr/include/kismet
        doins *.h || die "Header installation failed"
	#write a plugin finder that tells you what needs to be rebuilt when kismet is updated, etc

	dodoc CHANGELOG README* docs/*
	newinitd "${FILESDIR}"/${PN}.initd kismet
	newconfd "${FILESDIR}"/${PN}.confd kismet
}
