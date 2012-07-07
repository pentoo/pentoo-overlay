# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

#inherit flag-o-matic

DESCRIPTION="An open source wireless development platform suitable for Bluetooth experimentation"
HOMEPAGE="http://ubertooth.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE="+dfu +specan ubertooth0-firmware +ubertooth1-firmware"
REQUIRED_USE="ubertooth0-firmware? ( dfu )
		ubertooth1-firmware? ( dfu )"
DEPEND=""
RDEPEND="specan? ( >=dev-libs/libusb-1.0.8 )
	dfu? ( >=dev-libs/libusb-1.0.8 )
	specan? ( >=x11-libs/qt-gui-4.7.2
	>=dev-python/pyside-1.0.2
	>=dev-python/numpy-1.3 )
	specan? ( >=dev-python/pyusb-1.0.0_alpha1 )
	dfu? ( >=dev-python/pyusb-1.0.0_alpha1 )"

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="https://ubertooth.svn.sourceforge.net/svnroot/ubertooth/trunk/"
	SRC_URI=""
	inherit subversion
	KEYWORDS=""
	RDEPEND="${RDEPEND}
		>=net-libs/libbtbb-9999"
	DEPEND="ubertooth0-firmware? ( sys-devel/crossdev )
		ubertooth1-firmware? ( sys-devel/crossdev )"
else
        MY_PV="${PV/p/r}"
        MY_PV="${MY_PV/0.0_/}"
        SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"
        KEYWORDS="~amd64 ~arm ~x86"
        S="${WORKDIR}/${PN}-${MY_PV}/"
	RDEPEND="${RDEPEND}
		>=net-libs/libbtbb-0.8"
fi

pkg_setup() {
        ebegin "arm-none-eabi-gcc"
        if type -p arm-none-eabi-gcc > /dev/null ; then
                eend 0
        else
                eend 1

                eerror
                eerror "Failed to locate 'arm-none-eabi-gcc' in \$PATH. You can install the needed toolchain using:"
                eerror "  $ crossdev --genv 'USE=\"-openmp -fortran\"' -s4 -t arm-none-eabi"
                eerror
                die "arm-none-eabi toolchain not found"
        fi
}


src_compile() {
	#sometimes needed to build, remove when a release is made after r534 if not needed
	#filter-ldflags -Wl,--as-needed
	cd "${S}/host/bluetooth_rxtx" || die
	emake

	if [[ ${PV} == "9999" ]] ; then
		cd "${S}"/firmware/bluetooth_rxtx || die
		if use ubertooth0-firmware; then
			SVN_REV_NUM="-D'SVN_REV_NUM'=${ESVN_WC_REVISION}" DFU_TOOL=/usr/bin/ubertooth-dfu BOARD=UBERTOOTH_ZERO emake -j1
			mv bluetooth_rxtx.bin bluetooth_rxtx_U0.bin || die
			emake clean
		fi
		if use ubertooth1-firmware; then
			SVN_REV_NUM="-D'SVN_REV_NUM'=${ESVN_WC_REVISION}" DFU_TOOL=/usr/bin/ubertooth-dfu emake -j1
			mv bluetooth_rxtx.bin bluetooth_rxtx_U1.bin || die
		fi
	fi
}

src_install() {
	cd host || die
	dobin bluetooth_rxtx/ubertooth-dump bluetooth_rxtx/ubertooth-lap \
		bluetooth_rxtx/ubertooth-btle bluetooth_rxtx/ubertooth-uap \
		bluetooth_rxtx/ubertooth-hop bluetooth_rxtx/ubertooth-util

	use specan && dobin bluetooth_rxtx/ubertooth-specan specan_ui/specan.py specan_ui/ubertooth-specan-ui

	use dfu && dobin usb_dfu/ubertooth-dfu usb_dfu/dfu_suffix.py

	insinto /lib/firmware
	cd "${S}"
	if [[ ${PV} == "9999" ]] ; then
		use ubertooth0-firmware && doins firmware/bluetooth_rxtx/bluetooth_rxtx_U0.bin
	        use ubertooth1-firmware && doins firmware/bluetooth_rxtx/bluetooth_rxtx_U1.bin
	else
		use ubertooth0-firmware && newins ubertooth-zero-firmware-bin/bluetooth_rxtx.bin bluetooth_rxtx_U0.bin
	        use ubertooth1-firmware && newins ubertooth-one-firmware-bin/bluetooth_rxtx.bin bluetooth_rxtx_U1.bin
	fi

	insinto /lib/udev/rules.d/
	doins "${S}"/host/bluetooth_rxtx/40-ubertooth.rules

	elog "Everyone can read from the ubertooth, but to talk to it"
	elog "your user needs to be in the usb group."
}
