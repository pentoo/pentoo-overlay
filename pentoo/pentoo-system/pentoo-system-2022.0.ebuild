# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KEYWORDS="~amd64 ~arm ~x86"
DESCRIPTION="Pentoo meta ebuild to install system"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL-3"

IUSE_VIDEO_CARDS="video_cards_nvidia video_cards_virtualbox video_cards_vmware"
IUSE="+2fa livecd-stage1 pentoo-in-a-container pentoo-minimal pentoo pentoo-extra pentoo-full qemu windows-compat +X pcmcia +subversion ${IUSE_VIDEO_CARDS}"

S="${WORKDIR}"

DEPEND=""
RDEPEND=""
BDEPEND=""

#the core packages/requirements to make pentoo work
PDEPEND="pentoo? ( pentoo/pentoo-core )"

# Basic systems
PDEPEND="${PDEPEND}
	amd64? ( app-portage/unsymlink-lib )
	qemu? ( app-emulation/virt-manager
		!livecd-stage1? ( sys-apps/usermode-utilities ) )
	video_cards_vmware? ( !livecd-stage1? ( app-emulation/open-vm-tools ) )
	!livecd-stage1? (
		!pentoo-minimal? ( !pentoo-in-a-container? ( sys-apps/fwupd ) )
		video_cards_virtualbox? ( app-emulation/virtualbox-guest-additions )
	)
	2fa? ( X? ( app-crypt/yubikey-manager-qt
		sys-auth/yubikey-personalization-gui
			)
		app-crypt/yubikey-manager
		app-crypt/ccid
		app-crypt/libu2f-host
		app-crypt/libu2f-server
		sys-auth/pam_yubico )
	!arm? ( app-portage/cpuid2cpuflags )
	windows-compat? ( app-emulation/wine-vanilla )"

#Pentoo Full
PDEPEND="${PDEPEND}
	pentoo-full? (
		app-arch/unrar
		app-arch/unzip
		app-arch/sharutils
		app-misc/tmux
		dev-python/ipython
		dev-python/virtualenv
		net-fs/curlftpfs
		net-fs/sshfs
		sys-libs/gpm
		sys-power/hibernate-script
		|| ( sys-process/iotop-c sys-process/iotop )
		sys-apps/hdparm
		subversion? ( dev-vcs/subversion )
		media-fonts/dejavu
		media-fonts/font-misc-misc
		media-fonts/wqy-zenhei
		media-fonts/wqy-microhei
		sys-apps/rng-tools
		sys-apps/fbset
		net-dialup/lrzsz
		|| ( net-fs/cifs-utils net-fs/samba )
		amd64? ( sys-apps/fwts )
		x86? ( sys-devel/crossdev )
		|| ( sys-fs/exfatprogs sys-fs/exfat-utils  )
		sys-fs/f2fs-tools
		sys-fs/fuse-exfat
		sys-fs/btrfs-progs
		)"

#Pentoo Extra
PDEPEND="${PDEPEND}
	pentoo-extra? (
		pcmcia? ( sys-apps/pcmciautils )
		sys-fs/jfsutils
		sys-fs/reiser4progs
		sys-fs/reiserfsprogs
		sys-process/atop
		x11-libs/libdlo
	)"
