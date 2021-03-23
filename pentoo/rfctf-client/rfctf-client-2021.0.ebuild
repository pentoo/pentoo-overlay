# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Packages needed to power the client and SDR devices for RFCTF events"
HOMEPAGE="https://rfhackers.com"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="pentoo-in-a-container rfctf-minimal opencl rfctf-sdr rfctf-visuals rfctf-virtual rfctf-wifi"
S="${WORKDIR}"

RDEPEND="!pentoo/pentoo-system"

PDEPEND="
		app-misc/screen
		pentoo/pentoo-core
		!rfctf-minimal? (
			!pentoo-in-a-container? (
				app-admin/sudo
				app-pda/ifuse
				app-pda/usbmuxd
				sys-apps/fwupd
				sys-apps/rng-tools
				sys-apps/watchdog
				sys-power/intel-undervolt
				sys-power/thermald
				net-wireless/rtl8812au_aircrack-ng
				sys-fs/btrfs-progs
				sys-process/usbtop
			)
			app-misc/tmux
			net-analyzer/termshark
			app-text/wgetpaste
			dev-ruby/pry
			dev-ruby/rb-inotify
			dev-vcs/git
			>=sys-apps/util-linux-2.31_rc1
			sys-process/iotop
			net-wireless/hostapd
			net-analyzer/nmap
			net-analyzer/netcat
			net-analyzer/tcpdump
			net-dns/bind-tools
			net-misc/autossh
			net-misc/ntp
			net-wireless/aircrack-ng
			sys-devel/gdb
			net-ftp/tftp-hpa
		)
		rfctf-sdr? (
			media-radio/fldigi
			net-wireless/gr-mixalot
			!rfctf-virtual? ( net-wireless/gr-osmosdr )
			net-wireless/gnuradio
			dev-python/pyzmq
			net-wireless/gr-paint
			!rfctf-minimal? (
				net-wireless/gr-rds
				media-radio/wsjtx
			)
			!rfctf-virtual? ( net-wireless/rfcat )
		)
		rfctf-wifi? (
			|| ( net-misc/iputils[arping(+)] net-analyzer/arping )
			net-misc/telnet-bsd
		)
		rfctf-visuals? ( xfce-base/xfce4-meta
			x11-misc/slim
			x11-terms/xfce4-terminal
			media-fonts/noto-emoji
			www-client/google-chrome
			net-wireless/kismet
			net-wireless/kismetdb
			sci-geosciences/gpsd
			net-wireless/rtl_433
			net-wireless/mousejack
			opencl? ( pentoo/pentoo-opencl
					net-wireless/gnuradio
					net-wireless/fosphor_knob
			)
		)
		"

src_install() {
	if ! use rfctf-minimal; then
		exeinto /etc/local.d
		doexe "${FILESDIR}"/99-ldm.start
	fi

	use rfctf-visuals && echo 'XSESSION="Xfce4"' > "${ED}"/etc/env.d/90xsession
}
