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
	)"
