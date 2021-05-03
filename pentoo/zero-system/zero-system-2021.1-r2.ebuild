# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

DESCRIPTION="The ZERO (Zoning & Emotional Range Omitted) System is a technology for interfacing the brain of the pilot with the mobile suit's computer."
HOMEPAGE="http://www.pentoo.ch/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="cyrus nu printer theprophet"
S="${WORKDIR}"

PDEPEND="
		cyrus? (
			app-admin/ansible
			dev-util/packer
		)
		theprophet? (
					dev-embedded/stlink
					x11-plugins/enigmail
					sys-kernel/gentoo-sources
					www-client/firefox
					net-p2p/transmission
					media-plugins/swh-plugins
					media-libs/noise-suppression-for-voice
				)
		app-arch/p7zip
		app-arch/pixz
		app-doc/pms
		app-emulation/docker
		app-eselect/eselect-sh
		app-portage/genlop
		app-portage/repoman
		app-shells/zsh
		app-shells/gentoo-zsh-completions
		app-shells/dash
		app-shells/mksh
		app-vim/syntastic
		dev-python/pylama
		dev-util/checkbashisms
		dev-util/pkgcheck
		dev-util/shellcheck
		dev-vcs/mercurial
		dev-vcs/cvs
		net-analyzer/metasploit:9999
		net-analyzer/metasploit:6.0
		net-dns/dnsmasq
		net-misc/axel
		net-misc/keychain
		sys-apps/earlyoom
		sys-devel/distcc
		sys-fs/libeatmydata
		sys-fs/squashfs-tools-ng
		sys-process/htop
		sys-process/iotop
		sys-process/usbtop
		sys-process/glances
		nu? ( dev-util/catalyst[pentoo(-)]
			net-p2p/mktorrent
			net-vpn/strongswan
			dev-util/jenkins-bin
			mail-client/thunderbird
			mail-client/thunderbird-bin
		)
		!nu? ( printer? ( net-print/foo2zjs )
			net-wireless/nanovna-saver
			media-fonts/noto-emoji
			x11-misc/barrier
			x11-misc/xtrlock
			dev-ruby/blinkstick
			dev-ruby/pry
			app-doc/doxygen
			net-im/zoom
			arm? ( www-client/firefox )
			!arm? ( www-client/firefox-bin )
			net-ftp/filezilla
			!arm? ( www-plugins/chrome-binary-plugins:stable )
			amd64? ( theprophet? ( www-client/chromium ) )
			!arm? ( www-client/google-chrome )
			app-office/libreoffice
			!arm? ( app-emulation/virtualbox app-emulation/virtualbox-extpack-oracle app-emulation/virtualbox-additions )
			!arm? ( sys-apps/preload )
			x11-misc/slim
			!arm? ( app-emulation/wine-vanilla )
			media-gfx/gimp
			x11-apps/mesa-progs
			media-video/xine-ui
			media-video/mplayer
			net-wireless/hidclient
			!www-plugins/adobe-flash
			x11-misc/redshift
			!arm? ( media-sound/baudline )
			app-doc/eclass-manpages
			dev-util/meld
			dev-ruby/bundler-audit
			app-vim/nerdtree
			media-sound/asunder
			net-wireless/md380tools
			dev-embedded/arduino
			media-tv/v4l-utils
			media-video/openshot
			media-video/obs-v4l2sink
			media-video/vidcutter
			media-video/streamdeck-ui
			x11-misc/xdotool
			)
"

src_install() {
	if [ -d /home/zero ]; then
		insinto /home/zero
		newins "${FILESDIR}"/gitconfig .gitconfig
		newins "${FILESDIR}"/zshrc .zshrc
		newins "${FILESDIR}"/vimrc .vimrc
		keepdir /home/zero/.vim-scratch
	fi
	insinto /root
	newins "${FILESDIR}"/gitconfig .gitconfig
	newins "${FILESDIR}"/zshrc .zshrc
	newins "${FILESDIR}"/vimrc .vimrc
	keepdir /root/.vim-scratch

	#any users on my system get a free zshrc and vimrc
	insinto /etc/skel
	newins "${FILESDIR}"/zshrc .zshrc
	newins "${FILESDIR}"/vimrc .vimrc
	keepdir /etc/skel/.vim-scratch
}

pkg_postinst() {
	if grep -q '^root' /etc/passwd && [ "$(grep '^root' /etc/passwd | awk -F: '{print $7}')" != "/bin/zsh" ]; then
		chsh -s /bin/zsh
	fi
	if grep -q '^zero' /etc/passwd && [ "$(grep '^zero' /etc/passwd | awk -F: '{print $7}')" != "/bin/zsh" ]; then
		chsh -s /bin/zsh zero
	fi
}
