# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Packages needed to power the client NUC for WCTF events"
HOMEPAGE="http://wctf.us"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="minimal opencl sdr visuals wifi"
S="${WORKDIR}"

RDEPEND="!pentoo/pentoo-system"

PDEPEND="
		!minimal? (
			app-misc/tmux
			net-analyzer/tcpdump
			net-analyzer/termshark
			app-editors/nano
			app-editors/vim
			app-misc/screen
			app-admin/sudo
			app-pda/ifuse
			app-portage/gentoolkit
			app-portage/smart-live-rebuild
			app-pda/usbmuxd
			app-text/wgetpaste
			dev-ruby/pry
			dev-ruby/rb-inotify
			dev-vcs/git
			sys-kernel/pentoo-sources
			sys-apps/fwupd
			sys-apps/rng-tools
			>=sys-apps/util-linux-2.31_rc1
			sys-apps/watchdog
			sys-power/intel-undervolt
			sys-power/thermald
			sys-firmware/intel-microcode
			net-wireless/rtl8812au_aircrack-ng
			sys-fs/btrfs-progs
			sys-process/iotop
			sys-process/htop
			sys-process/usbtop
			sys-kernel/genkernel
			net-wireless/hostapd
			sys-boot/grub:2
			net-analyzer/nmap
			net-analyzer/netcat
			net-dns/bind-tools
			net-misc/autossh
			net-misc/ntp
			net-wireless/aircrack-ng
			sys-devel/gdb
			virtual/cron
			net-ftp/tftp-hpa
		)
		sdr? (
			net-wireless/gr-osmosdr
			media-radio/wsjtx
			net-wireless/rfcat
			dev-python/bottle
		)
		wifi? (
			|| ( net-misc/iputils[arping(+)] net-analyzer/arping )
			net-dns/dnsmasq
			net-misc/dhcpcd
			net-misc/telnet-bsd
			net-wireless/wpa_supplicant
		)
		visuals? ( xfce-base/xfce4-meta
			x11-misc/slim
			x11-terms/xfce4-terminal
			media-fonts/noto-emoji
			www-client/google-chrome
			net-wireless/kismet
			net-wireless/kismetdb
			sci-geosciences/gpsd
			net-wireless/rtl_433
			net-wireless/mousejack
		)
		opencl? ( net-wireless/gnuradio
				dev-libs/rocm-opencl-runtime
				net-analyzer/gr-fosphor
				net-wireless/fosphor_knob
				dev-libs/opencl-icd-loader
				dev-libs/intel-neo
		)"

src_install() {
	#/usr/share/pentoo
	insinto /usr/share/pentoo
	doins "${FILESDIR}/pentoo-keyring.asc"

	#/etc/portage/repos.conf
	insinto /etc/portage/repos.conf
	doins "${FILESDIR}/pentoo.conf"

	if ! use minimal; then
		exeinto /etc/local.d
		doexe "${FILESDIR}"/99-ldm.start
	fi

	use visuals && echo 'XSESSION="Xfce4"' > "${ED}"/etc/env.d/90xsession
}
