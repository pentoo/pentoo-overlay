# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8

DESCRIPTION="The ZERO (Zoning & Emotional Range Omitted) System is a technology for interfacing the brain of the pilot with the mobile suit's computer."
HOMEPAGE="http://www.pentoo.ch/"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="dev nu printer theprophet"
S="${WORKDIR}"

RDEPEND="
		dev? ( app-portage/iwdevtools
				dev-util/libabigail
				sys-kernel/gentoo-sources
				app-doc/pms
				app-shells/dash
				app-shells/mksh
				dev-util/checkbashisms
				dev-util/pkgdev
				dev-util/shellcheck
				dev-python/pylama
				dev-vcs/mercurial
				dev-vcs/cvs
				dev-ruby/irb
				dev-ruby/blinkstick
				dev-ruby/pry
				app-doc/eclass-manpages
				dev-util/meld
				dev-ruby/bundler-audit
		)
		theprophet? (
					app-misc/jq
					app-misc/siglo
					dev-embedded/stlink
					kde-apps/filelight
					x11-plugins/enigmail
					www-client/firefox
					net-p2p/transmission
					media-plugins/swh-plugins
					media-libs/noise-suppression-for-voice
					dev-util/android-sdk-build-tools
					dev-util/android-sdk-update-manager
				)
		app-arch/p7zip
		app-arch/pixz
		app-containers/docker
		app-containers/docker-cli
		app-portage/genlop
		app-shells/zsh
		app-shells/gentoo-zsh-completions
		app-vim/syntastic
		net-analyzer/metasploit:9999
		net-dns/dnsmasq
		net-misc/axel
		net-misc/keychain
		sys-apps/earlyoom
		sys-devel/distcc
		sys-fs/libeatmydata
		sys-fs/squashfs-tools-ng
		sys-power/nut
		sys-process/htop
		sys-process/iotop-c
		sys-process/usbtop
		sys-process/glances
		nu? ( dev-util/catalyst[pentoo(-)]
			dev-util/jenkins-bin
			dev-util/pkgcheck
			mail-client/thunderbird
			mail-client/thunderbird-bin
			net-p2p/mktorrent
			net-vpn/strongswan
		)
		!nu? ( printer? ( net-print/foo2zjs )
			app-admin/supervisor
			net-wireless/dsd
			net-wireless/dsd-fme
			net-wireless/dsdcc
			net-wireless/nanovna-saver
			net-wireless/trunk-recorder
			media-fonts/noto-emoji
			x11-misc/barrier
			x11-misc/xtrlock
			app-doc/doxygen
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
			app-vim/nerdtree
			media-sound/asunder
			net-wireless/md380tools
			dev-embedded/arduino
			media-tv/v4l-utils
			media-video/openshot
			media-video/obs-v4l2sink
			media-video/vidcutter
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
	if use dev; then
		if [ ! -L /etc/portage/bashrc ]; then
			ln -s ../../usr/share/iwdevtools/bashrc /etc/portage/bashrc
		fi
	fi
}
