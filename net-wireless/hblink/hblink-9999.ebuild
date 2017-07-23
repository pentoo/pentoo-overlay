# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="HomeBrew Repeater protocol as used by DMR+, MMDVM and Brandmeister"
HOMEPAGE="https://github.com/n0mjs710/HBlink"
SRC_URI=""
EGIT_REPO_URI="https://github.com/n0mjs710/HBlink.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

pkg_setup() {
	die "This literally installs nothing right now"
}
