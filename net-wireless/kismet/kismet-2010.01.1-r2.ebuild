# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs linux-info eutils

MY_P=${P/\./-}
MY_P=${MY_P/./-R}
S=${WORKDIR}/${MY_P}

DESCRIPTION="IEEE 802.11 wireless LAN sniffer"
HOMEPAGE="http://www.kismetwireless.net/"
SRC_URI="http://www.kismetwireless.net/code/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="+ncurses +pcre speech +plugin-autowep +plugin-btscan +plugin-ptw +plugin-spectools +suid"

RDEPEND="net-wireless/wireless-tools
	kernel_linux? ( sys-libs/libcap
		>=dev-libs/libnl-1.1 )
	net-libs/libpcap
	pcre? ( dev-libs/libpcre )
	suid? ( sys-libs/libcap )
	ncurses? ( sys-libs/ncurses )
	speech? ( app-accessibility/flite )
	plugin-btscan? ( net-wireless/bluez )
	plugin-spectools? ( net-wireless/spectools )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	cd "${S}"
	epatch "${FILESDIR}"/kismet-pentoo.patch
	#stolen from svn for bugfix until release (remove on version increment)
	epatch "${FILESDIR}"/fix-menu-crash-2010.01.1.patch

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
	if use plugin-ptw; then
		cd "${S}"/plugin-ptw
		KIS_SRC_DIR="${S}" emake DESTDIR="${D}" install || die "emake install failed"
	fi
	if use plugin-spectools; then
		cd "${S}"/plugin-spectools
		KIS_SRC_DIR="${S}" emake DESTDIR="${D}" install || die "emake install failed"
	fi

	cd "${S}"
	emake DESTDIR="${D}" commoninstall || die "emake install failed"

	##dragorn would prefer I set fire to my head than do this, but it works
        # install headers for external plugins
        insinto /usr/include/kismet
        doins *.h || die "Header installation failed"
	#write a plugin finder that tells you what needs to be rebuilt when kismet is updated, etc

	dodoc CHANGELOG RELEASENOTES.txt README* docs/* || die
	newinitd "${FILESDIR}"/${PN}.initd kismet
	newconfd "${FILESDIR}"/${PN}.confd kismet

        insinto /etc
        doins conf/kismet{,_drone}.conf || die

        if use suid; then
                dobin kismet_capture || die
        fi
}

pkg_preinst() {
        if use suid; then
                enewgroup kismet
                fowners root:kismet /usr/bin/kismet_capture || die
                # Need to set the permissions after chowning.
                # See chown(2)
                fperms 4550 /usr/bin/kismet_capture || die
                elog "Kismet has been installed with a setuid-root helper binary"
                elog "to enable minimal-root operation.  Users need to be part of"
                elog "the 'kismet' group to perform captures from physical devices."
        fi
}

