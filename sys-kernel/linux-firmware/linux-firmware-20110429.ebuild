# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-firmware/linux-firmware-20110311.ebuild,v 1.2 2011/04/09 09:51:20 armin76 Exp $

EAPI=3

if [[ ${PV} == 99999999* ]]; then
	inherit git
	SRC_URI=""
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/dwmw2/${PN}.git"
else
	SRC_URI="mirror://kernel/linux/kernel/people/dwmw2/firmware/${P}.tar.bz2"
fi

DESCRIPTION="Linux firmware files"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/dwmw2/firmware"

LICENSE="GPL-1 GPL-2 GPL-3 BSD freedist"
KEYWORDS="~amd64 ~arm ~x86"
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
}
