# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The ZERO (Zoning & Emotional Range Omitted) System is a technology for interfacing the brain of the pilot with the mobile suit's computer."
HOMEPAGE="https://www.pentoo.org/"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="dev lto minimal nu printer naga"

RDEPEND="
	app-shells/zsh
	net-misc/keychain
	sys-auth/ykpers
	!minimal? (
		dev? (
			app-crypt/glep63-check
			app-doc/eclass-manpages
			app-doc/pms
			app-portage/iwdevtools
			app-shells/dash
			app-shells/mksh
			dev-python/mock
			dev-python/pytest
			dev-ruby/blinkstick
			dev-ruby/bundler-audit
			dev-ruby/irb
			dev-ruby/pry
			dev-util/checkbashisms
			dev-util/libabigail
			dev-util/meld
			dev-util/pkgdev
			dev-util/shellcheck
			dev-vcs/mercurial
			dev-vcs/cvs
			sys-kernel/gentoo-sources
		)
		naga? (
			app-misc/jq
			app-misc/siglo
			dev-embedded/platformio
			dev-embedded/stlink
			dev-util/android-sdk-build-tools
			dev-util/android-sdk-cmdline-tools
			gnome-base/gnome-keyring
			kde-apps/filelight
			media-plugins/swh-plugins
			media-libs/noise-suppression-for-voice
			net-p2p/transmission
			www-client/firefox
		)
		app-arch/p7zip
		app-arch/pixz
		app-containers/docker
		app-containers/docker-cli
		app-containers/docker-buildx
		app-crypt/nitrocli
		app-crypt/nitrokey-app
		app-portage/genlop
		app-shells/gentoo-zsh-completions
		app-vim/syntastic
		net-dns/dnsmasq
		net-misc/axel
		sys-apps/earlyoom
		sys-fs/libeatmydata
		sys-fs/squashfs-tools-ng
		sys-power/nut
		sys-process/htop
		sys-process/iotop-c
		sys-process/usbtop
		sys-process/glances
		nu? (
			app-crypt/glep63-check
			dev-util/catalyst
			dev-util/jenkins-bin
			dev-util/pkgcheck
			mail-client/thunderbird
			mail-client/thunderbird-bin
			net-p2p/mktorrent
		)
		!nu? (
			printer? ( net-print/foo2zjs )
			app-admin/supervisor
			net-analyzer/metasploit:9999
			net-wireless/dsd
			net-wireless/dsd-fme
			net-wireless/dsdcc
			net-wireless/nanovna-saver
			net-wireless/sdrtrunk-bin
			net-wireless/trunk-recorder
			x11-misc/barrier
			x11-misc/xtrlock
			app-text/doxygen
			arm? ( www-client/firefox )
			!arm? ( www-client/firefox-bin )
			net-ftp/filezilla
			!arm? ( www-plugins/chrome-binary-plugins:stable )
			amd64? ( naga? ( www-client/chromium ) )
			!arm? ( www-client/google-chrome )
			|| ( app-office/libreoffice app-office/libreoffice-bin )
			!arm? ( sys-apps/preload )
			x11-misc/slim
			media-gfx/gimp
			x11-apps/mesa-progs
			media-video/xine-ui
			net-wireless/hidclient
			x11-misc/redshift
			app-vim/nerdtree
			media-sound/asunder
			net-wireless/md380tools
			!lto? ( dev-embedded/arduino )
			x11-misc/xdotool
		)
	)
"
			# I just can't build this lately
			#!arm? ( app-emulation/virtualbox app-emulation/virtualbox-extpack-oracle app-emulation/virtualbox-additions )

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
		chsh -s /bin/zsh || die
	fi
	if grep -q '^zero' /etc/passwd && [ "$(grep '^zero' /etc/passwd | awk -F: '{print $7}')" != "/bin/zsh" ]; then
		chsh -s /bin/zsh zero || die
	fi
	if use dev; then
		if [ ! -L /etc/portage/bashrc ]; then
			ln -s ../../usr/share/iwdevtools/bashrc /etc/portage/bashrc || die
		fi
	fi
	if [ -d /home/zero ]; then
		chown zero.users /home/zero/.vim-scratch || die
	fi
}
