# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="things needed by pentoo for livecd only"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="livecd"

DEPEND=""
RDEPEND="livecd? ( pentoo/pentoo-installer
        	app-misc/livecd-tools
                virtual/eject
                sys-apps/hwsetup
                sys-block/disktype
                x11-misc/mkxf86config
		net-dialup/mingetty
	)"

#should be pulled in via alternate means
#	x11-drivers/xf86-input-keyboard
#	x11-drivers/xf86-input-mouse
#	x11-drivers/xf86-video-apm
#	x11-drivers/xf86-video-ark
#	x11-drivers/xf86-video-ati
#	x11-drivers/xf86-video-chips
#	x11-drivers/xf86-video-cirrus
#	x11-drivers/xf86-video-fbdev
#	x11-drivers/xf86-video-glint
#	x11-drivers/xf86-video-i128
#	x11-drivers/xf86-video-intel
#	x11-drivers/xf86-video-mach64
#	x11-drivers/xf86-video-mga
#	x11-drivers/xf86-video-neomagic
#	x11-drivers/xf86-video-nv
#	x11-drivers/xf86-video-nouveau
#	x11-drivers/xf86-video-rendition
#	x11-drivers/xf86-video-s3
#	x11-drivers/xf86-video-s3virge
#	x11-drivers/xf86-video-savage
#	x11-drivers/xf86-video-siliconmotion
#	x11-drivers/xf86-video-sis
#	x11-drivers/xf86-video-tdfx
#	x11-drivers/xf86-video-trident
#	x11-drivers/xf86-video-vesa
#	x11-drivers/xf86-video-vmware
#	x11-drivers/xf86-video-voodoo
