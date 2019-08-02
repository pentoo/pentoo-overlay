# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Packages needed to power the client NUC for WCTF events"
HOMEPAGE="http://wctf.us"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="opencl visuals"
S="${WORKDIR}"

RDEPEND="!pentoo/pentoo-system"

PDEPEND="
		app-admin/sudo
		app-editors/nano
		app-editors/vim
		app-misc/screen
		app-misc/rtlamr
		app-pda/ifuse
		app-pda/usbmuxd
		app-portage/gentoolkit
		app-portage/smart-live-rebuild
		app-text/wgetpaste
		dev-ruby/pry
		dev-ruby/rb-inotify
		dev-vcs/git
		sys-kernel/pentoo-sources
		sys-apps/rng-tools
		>=sys-apps/util-linux-2.31_rc1
		sys-power/thermald
		sys-firmware/intel-microcode
		net-misc/dhcpcd
		net-wireless/rfcat
		net-wireless/rtl_433
		net-wireless/mousejack
		net-wireless/rtl8812au_aircrack-ng
		sys-boot/grub:2
		sys-fs/btrfs-progs
		sys-process/iotop
		sys-process/htop
		sys-process/usbtop
		sys-kernel/genkernel
		net-analyzer/tcpdump
		net-analyzer/termshark
		net-analyzer/nmap
		net-analyzer/netcat
		net-dns/bind-tools
		net-misc/autossh
		net-misc/ntpsec
		net-wireless/wpa_supplicant
		net-wireless/aircrack-ng
		net-wireless/kismet
		net-wireless/kismetdb
		sci-geosciences/gpsd
		net-ftp/tftp-hpa
		sys-apps/watchdog
		sys-devel/gdb
		virtual/cron
		|| ( net-misc/iputils[arping(+)] net-analyzer/arping )
		visuals? ( xfce-base/xfce4-meta
			x11-misc/slim
			x11-terms/xfce4-terminal
			media-fonts/noto-emoji
			www-client/google-chrome
		)
		opencl? ( net-wireless/gnuradio
				dev-libs/rocm-opencl-runtime
				net-analyzer/gr-fosphor
				net-wireless/fosphor_knob
				dev-libs/ocl-icd[khronos-headers(-)]
			)"

src_install() {
	#/usr/share/pentoo
	insinto /usr/share/pentoo
	doins "${FILESDIR}/pentoo-keyring.asc"

	#/etc/portage/repos.conf
	insinto /etc/portage/repos.conf
	doins "${FILESDIR}/pentoo.conf"

	exeinto /etc/local.d
	doexe "${FILESDIR}"/99-ldm.start

	use visuals && echo 'XSESSION="Xfce4"' > "${ED}"/etc/env.d/90xsession
}
