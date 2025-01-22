# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Sam Stelfox's dotfiles"
HOMEPAGE="https://github.com/sstelfox/dotfiles"
EGIT_REPO_URI="https://github.com/sstelfox/dotfiles.git"

LICENSE="MIT"
SLOT="0"
IUSE="nvim"

RDEPEND="nvim? ( app-editors/neovim )"

src_install() {
	insinto "/usr/share/${PN}"
	doins -r *

	if use nvim; then
		dodir /etc/skel
		ln -s "/usr/share/${PN}/nvim" /etc/skel/nvim || die
	fi
}
