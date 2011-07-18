# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit subversion flag-o-matic

DESCRIPTION="An open source wireless development platform suitable for Bluetooth experimentation"
HOMEPAGE="http://ubertooth.sourceforge.net/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="+dfu firmware +python +specan"

DEPEND=""
RDEPEND=">=net-wireless/kismet-2011.03.2-r1 \
		>=net-libs/libbtbb-0.5 \
		specan? ( >=dev-libs/libusb-1.0.8 )
		dfu? ( >=dev-libs/libusb-1.0.8 )
		specan? ( >=x11-libs/qt-gui-4.7.2
		>=dev-python/pyside-1.0.2
		>=dev-python/numpy-1.3 )
		firmware? ( net-wireless/ubertooth-firmware )
		specan? ( >=dev-python/pyusb-1.0.0_alpha1 )
		python? ( >=dev-python/pyusb-1.0.0_alpha1 )
		dfu? ( >=dev-python/pyusb-1.0.0_alpha1 )"

ESVN_REPO_URI="https://ubertooth.svn.sourceforge.net/svnroot/ubertooth/trunk/host"

src_compile() {
	filter-ldflags -Wl,--as-needed
	cd "${WORKDIR}/${P}/bluetooth_rxtx"
	emake
	use python && cd "${WORKDIR}"/${P}/bluetooth_rxtx/python
	use python && python setup.py build
}

src_install() {
	dobin bluetooth_rxtx/ubertooth-dump bluetooth_rxtx/ubertooth-lap \
		  bluetooth_rxtx/ubertooth-specan bluetooth_rxtx/ubertooth-uap \
		  bluetooth_rxtx/ubertooth-util

	use specan && dobin specan_ui/specan.py specan_ui/ubertooth-specan-ui

	use dfu && dobin usb_dfu/ubertooth-dfu usb_dfu/dfu_suffix.py

	use python && cd "${WORKDIR}"/${P}/bluetooth_rxtx/python
	use python && python setup.py install --prefix="${ED}"

	insinto /etc/udev/rules.d/
	doins "${FILESDIR}"/40-ubertooth.rules

	ewarn "Everyone can read from the ubertooth, but to talk to it"
	ewarn "your user needs to be in the usb group."
	einfo "\n While not strictless nessesary for use, it is highly encouraged"
	einfo "to use the firmware use flag to build firmware for the ubertooth."
	einfo "Once you have done this you can use the dfu to flash it easy."
	einfo "This is not required, as you can also download the firmware,"
	einfo "however it is not as up to date."
}
