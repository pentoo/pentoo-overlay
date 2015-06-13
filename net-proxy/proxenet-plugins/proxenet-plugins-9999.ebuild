# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv Exp $

EAPI=5

inherit git-r3

DESCRIPTION="Repository for proxenet plugins"
HOMEPAGE="https://github.com/hugsy/proxenet"
EGIT_REPO_URI="https://github.com/hugsy/proxenet-plugins.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share/proxenet/proxenet-plugins
	doins -r *
}
