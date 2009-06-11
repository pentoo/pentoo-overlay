# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs linux-info eutils subversion

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
IUSE="ncurses pcre speech"

DEPEND="${RDEPEND}"
RDEPEND="net-wireless/wireless-tools
	!net-wireless/kismet
	net-libs/libpcap
	>=dev-libs/libnl-1.1
	ncurses? ( sys-libs/ncurses )
	speech? ( app-accessibility/flite )"

src_compile() {
	cd "${S}"

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
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc CHANGELOG README*  docs/*
	dosym /etc/kismet.conf /usr/local/etc/kismet.conf
	dosym /etc/kismet_drone.conf /usr/local/etc/kismet_drone.conf
	dosym /etc/kismet_ui.conf /usr/local/etc/kismet_ui.conf
#	newinitd "${FILESDIR}"/${PN}.initd kismet
#	newconfd "${FILESDIR}"/${PN}.confd kismet
}
