# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-firmware/linux-firmware-99999999.ebuild,v 1.5 2011/02/19 20:30:46 chithanh Exp $

EAPI=3

DESCRIPTION="Linux firmware files"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/dwmw2/firmware"

#this is only being added to add in carl9170 firmware
#http://linuxwireless.org/en/users/Drivers/carl9170

#however, while we are at it we can add support for the deprecated ar9170 in
# case anyone is stupid enough to use it
#remove ar9170 crap when kernel 2.6.40 is stable


if [[ ${PV} == 99999999* ]]; then
	inherit git-2
#	SRC_URI="http://www.kernel.org/pub/linux/kernel/people/chr/carl9170/fw/1.9.2/carl9170-1.fw \
	SRC_URI="http://linuxwireless.org/en/users/Drivers/carl9170/fw1.9.4?action=AttachFile&do=get&target=carl9170-1.fw -> carl9170-1.fw \
	http://www.kernel.org/pub/linux/kernel/people/mcgrof/firmware/ar9170/ar9170.fw"
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/dwmw2/${PN}.git"
else
	SRC_URI="mirror://kernel/linux/kernel/people/dwmw2/firmware/${P}.tar.bz2 \
			http://www.kernel.org/pub/linux/kernel/people/chr/carl9170/fw/1.9.2/carl9170-1.fw \
			http://www.kernel.org/pub/linux/kernel/people/mcgrof/firmware/ar9170/ar9170.fw"
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
	!media-tv/ivtv-firmware
	!media-tv/linuxtv-dvb-firmware[dvb_cards_cx231xx]
	!media-tv/linuxtv-dvb-firmware[dvb_cards_cx23885]
	!media-tv/linuxtv-dvb-firmware[dvb_cards_usb-dib0700]
	!net-wireless/libertas-firmware
	!net-wireless/i2400m-fw
	!net-wireless/iwl1000-ucode
	!net-wireless/iwl3945-ucode
	!net-wireless/iwl4965-ucode
	!net-wireless/iwl5000-ucode
	!net-wireless/iwl5150-ucode
	!net-wireless/iwl6000-ucode
	!net-wireless/iwl6050-ucode
	!net-wireless/rt61-firmware
	!net-wireless/rt73-firmware
	!sys-block/qla-fc-firmware
	!x11-drivers/radeon-ucode"
#add anything else that collides to this

src_install() {
	insinto /lib/firmware/
	doins -r * || die "Install failed!"
	doins ${DISTDIR}/* || die
}
