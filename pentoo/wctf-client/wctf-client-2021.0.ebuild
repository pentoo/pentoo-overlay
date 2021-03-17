# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Packages needed to power the client NUC for WCTF events"
HOMEPAGE="http://wctf.us"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"
IUSE="gui pentoo-in-a-container wctf-minimal opencl wctf-sdr wctf-visuals wctf-virtual wctf-wifi"
S="${WORKDIR}"

RDEPEND="!pentoo/pentoo-system"

PDEPEND="
		app-misc/screen
		pentoo/pentoo-core
		net-analyzer/tcpdump
		gui? ( www-apps/novnc )
		!wctf-minimal? (
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
			net-dns/bind-tools
			net-misc/autossh
			net-misc/ntp
			net-wireless/aircrack-ng
			sys-devel/gdb
			net-ftp/tftp-hpa
		)
		wctf-sdr? (
			media-radio/fldigi
			net-wireless/gr-mixalot
			!wctf-virtual? ( net-wireless/gr-osmosdr )
			net-wireless/gnuradio
			dev-python/pyzmq
			net-wireless/gr-paint
			net-wireless/gr-rds
			media-radio/wsjtx
			!wctf-virtual? ( net-wireless/rfcat )
		)
		wctf-wifi? (
			|| ( net-misc/iputils[arping(+)] net-analyzer/arping )
			net-dns/dnsmasq
			net-misc/telnet-bsd
		)
		wctf-visuals? ( xfce-base/xfce4-meta
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
	if ! use wctf-minimal; then
		exeinto /etc/local.d
		doexe "${FILESDIR}"/99-ldm.start
	fi

	use wctf-visuals && echo 'XSESSION="Xfce4"' > "${ED}"/etc/env.d/90xsession
}
