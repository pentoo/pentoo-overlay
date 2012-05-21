# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-firmware/linux-firmware-99999999.ebuild,v 1.5 2011/02/19 20:30:46 chithanh Exp $

EAPI=3

DESCRIPTION="Linux firmware files"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/dwmw2/firmware"

#this is only being added to add in carl9170 firmware
#http://linuxwireless.org/en/users/Drivers/carl9170

if [[ ${PV} == 99999999* ]]; then
	inherit git-2
	SRC_URI="http://linuxwireless.org/en/users/Drivers/carl9170/fw1.9.4?action=AttachFile&do=get&target=carl9170-1.fw -> carl9170-1.fw"
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/dwmw2/${PN}.git"
else
	SRC_URI="mirror://kernel/linux/kernel/people/dwmw2/firmware/${P}.tar.bz2 \
		http://linuxwireless.org/en/users/Drivers/carl9170/fw1.9.4?action=AttachFile&do=get&target=carl9170-1.fw -> carl9170-1.fw"
fi

LICENSE="GPL-1 GPL-2 GPL-3 BSD freedist"
KEYWORDS=""
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="!media-sound/alsa-firmware[alsa_cards_korg1212]
	!media-sound/alsa-firmware[alsa_cards_maestro3]
	!media-sound/alsa-firmware[alsa_cards_sb16]
	!media-sound/alsa-firmware[alsa_cards_ymfpci]
	!media-tv/cx18-firmware
	!media-tv/ivtv-firmware
	!media-tv/linuxtv-dvb-firmware[dvb_cards_cx231xx]
	!media-tv/linuxtv-dvb-firmware[dvb_cards_cx23885]
	!media-tv/linuxtv-dvb-firmware[dvb_cards_usb-dib0700]
	!net-dialup/ueagle-atm
	!net-dialup/ueagle4-atm
	!net-wireless/ar9271-firmware
	!net-wireless/i2400m-fw
	!net-wireless/iwl1000-ucode
	!net-wireless/iwl3945-ucode
	!net-wireless/iwl4965-ucode
	!net-wireless/iwl5000-ucode
	!net-wireless/iwl5150-ucode
	!net-wireless/iwl6000-ucode
	!net-wireless/iwl6005-ucode
	!net-wireless/iwl6030-ucode
	!net-wireless/iwl6050-ucode
	!net-wireless/libertas-firmware
	!net-wireless/rt61-firmware
	!net-wireless/rt73-firmware
	!sys-block/qla-fc-firmware
	!x11-drivers/radeon-ucode
	net-wireless/zd1211-firmware
	net-wireless/ipw2100-firmware
	net-wireless/ipw2200-firmware
	net-wireless/zd1201-firmware
	net-wireless/atmel-firmware
"


#add anything else that collides to this

src_install() {
	insinto /$(get_libdir)/firmware/
	doins -r * || die "Install failed!"
	doins ${DISTDIR}/* || die
}
