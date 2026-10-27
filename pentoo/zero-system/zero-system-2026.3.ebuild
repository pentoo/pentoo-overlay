# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The ZERO (Zoning & Emotional Range Omitted) System is a technology for interfacing the brain of the pilot with the mobile suit's computer"
HOMEPAGE="https://www.pentoo.org/"

S="${WORKDIR}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="abi_x86_x32 cpu_flags_x86_avx cpu_flags_x86_avx2 dev desktop minimal nu printer"

RDEPEND="
	app-admin/keepass
	app-shells/zsh
	net-misc/keychain
	sys-auth/ykpers
	!minimal? (
		app-arch/7zip
		app-arch/pixz
		app-containers/docker
		app-containers/docker-cli
		app-containers/docker-buildx
		app-laptop/framework_tool
		app-laptop/framework-tool-tui
		app-misc/usbeehive
		app-portage/genlop
		app-shells/gentoo-zsh-completions
		app-vim/syntastic
		!abi_x86_x32? ( cpu_flags_x86_avx? ( cpu_flags_x86_avx2? ( dev-util/claude-code ) ) )
		net-dns/dnsmasq
		net-misc/axel
		net-misc/yt-dlp
		sys-apps/earlyoom
		sys-fs/libeatmydata
		sys-fs/squashfs-tools-ng
		sys-power/nut
		sys-process/htop
		sys-process/iotop-c
		sys-process/usbtop
		sys-process/glances
		sys-power/powercap-utils
		desktop? (
			|| ( app-office/libreoffice app-office/libreoffice-bin )
			gnome-base/gnome-keyring
			media-gfx/gimp
			media-gfx/inkscape
			media-video/xine-ui
			net-ftp/filezilla
			!abi_x86_x32? ( www-client/firefox )
			x11-apps/mesa-progs
			x11-misc/xtrlock
			x11-misc/slim
			x11-misc/xdotool
			xfce-extra/xfce4-genmon-plugin
			!elibc_musl? (
				www-client/firefox-bin
				www-client/google-chrome
				www-plugins/chrome-binary-plugins:stable
			)
		)
		dev? (
			app-crypt/glep63-check
			app-doc/eclass-manpages
			app-doc/pms
			app-misc/jq
			app-portage/iwdevtools
			app-portage/pycargoebuild
			app-shells/dash
			app-shells/mksh
			app-vim/nerdtree
			dev-python/mock
			dev-python/pytest
			dev-ruby/bundler-audit
			dev-ruby/irb
			dev-ruby/pry
			dev-util/checkbashisms
			dev-util/debugedit
			dev-util/github-cli
			dev-util/libabigail
			dev-util/meld
			dev-util/pkgcheck
			dev-util/pkgdev
			dev-util/shellcheck
			dev-vcs/cvs
			dev-vcs/git-lfs
			dev-vcs/mercurial
			sys-kernel/gentoo-sources
		)
		nu? (
			dev-util/catalyst
			dev-util/jenkins-bin
			!abi_x86_x32? ( mail-client/thunderbird )
			!elibc_musl? ( mail-client/thunderbird-bin )
			net-p2p/mktorrent
		)
		!nu? (
			app-admin/supervisor
			app-text/doxygen
			dev-embedded/arduino
			media-sound/alsa-tools
			media-sound/asunder
			net-analyzer/metasploit:9999
			printer? ( net-print/foo2zjs )
			net-wireless/dsd
			net-wireless/dsd-fme
			net-wireless/dsdcc
			net-wireless/fosphor_knob
			net-wireless/hidclient
			net-wireless/md380tools
			net-wireless/nanovna-saver
			net-wireless/sdrtrunk-bin
			net-wireless/trunk-recorder
			sys-auth/fprintd
			sys-apps/preload
			sci-ml/ollama
			x11-misc/redshift
		)
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

	insinto /etc/ssh/sshd_config.d
	doins "${FILESDIR}"/zero-system-sshd.conf
	fperms 600 '/etc/ssh/sshd_config.d/zero-system-sshd.conf'

	insinto /etc/ssh/ssh_config.d
	doins "${FILESDIR}"/zero-system-ssh.conf
	fperms 644 '/etc/ssh/ssh_config.d/zero-system-ssh.conf'

	# Zero Fan Control
	dobin "${FILESDIR}/zero_fan_control"
	newinitd "${FILESDIR}/zero_fan_control.initd" zero_fan_control

	# Sync my time
	dosbin "${FILESDIR}/ntpsync"
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
		chown zero:users /home/zero/.vim-scratch || die
	fi
	if ! grep -q '^#tmpfs /var/tmp/portage tmpfs defaults,size=48G 0 0$' /etc/fstab; then
		printf '#tmpfs /var/tmp/portage tmpfs defaults,size=48G 0 0\n' >> /etc/fstab
	fi
	if ! grep -q '^tmpfs /var/tmp/portage tmpfs' /etc/fstab; then
		printf 'tmpfs /var/tmp/portage tmpfs defaults 0 0\n' >> /etc/fstab
	fi
}
