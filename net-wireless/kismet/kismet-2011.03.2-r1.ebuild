# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit toolchain-funcs linux-info eutils

MY_P=${P/\./-}
MY_P=${MY_P/./-R}
S=${WORKDIR}/${MY_P}

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="https://www.kismetwireless.net/code/svn/trunk"
	inherit subversion
	KEYWORDS="~amd64 ~arm ~ppc ~x86"
else
	SRC_URI="http://www.kismetwireless.net/code/${MY_P}.tar.gz"
#Few dependencies are still not stable. Comment out keywords during repoman testing
	KEYWORDS="amd64 arm ppc x86"
fi

DESCRIPTION="IEEE 802.11 wireless LAN sniffer"
HOMEPAGE="http://www.kismetwireless.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE="+ncurses +pcre speech +plugin-autowep +plugin-btscan +plugin-dot15d4 +plugin-ptw +plugin-spectools +ruby +suid"

RDEPEND="net-wireless/wireless-tools
	kernel_linux? ( sys-libs/libcap
		>=dev-libs/libnl-1.1 )
	net-libs/libpcap
	pcre? ( dev-libs/libpcre )
	suid? ( sys-libs/libcap )
	ncurses? ( sys-libs/ncurses )
	speech? ( app-accessibility/flite )
	ruby? ( dev-lang/ruby )
	plugin-btscan? ( net-wireless/bluez )
	plugin-dot15d4? ( <dev-libs/libusb-1 )
	plugin-spectools? ( net-wireless/spectools )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/kismet-pentoo.patch

	sed -i -e "s:^\(logtemplate\)=\(.*\):\1=/tmp/\2:" \
		conf/kismet.conf.in

	# Don't strip and set correct mangrp
	sed -i -e 's| -s||g' \
		-e 's|@mangrp@|root|g' Makefile.in
}

src_configure() {
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
}

src_compile() {
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

src_install() {
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
	if use ruby; then
		cd "${S}"/ruby
		dobin *.rb
	fi

	cd "${S}"
	emake DESTDIR="${D}" commoninstall || die "emake install failed"

	##dragorn would prefer I set fire to my head than do this, but it works
	# install headers for external plugins
	insinto /usr/include/kismet
	doins *.h || die "Header installation failed"
	doins Makefile.inc
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
