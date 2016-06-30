# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-2 autotools

DESCRIPTION="An advanced GPU-based password recovery utility"
HOMEPAGE="https://hashcat.net/oclhashcat/"
EGIT_REPO_URI="https://github.com/hashcat/oclhashcat.git"
EGIT_COMMIT="67a8d97675ce50f6692e17eeb826da604b18cd05"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
DEPEND="dev-util/intel-ocl-sdk"

src_prepare() {
	#do not strip
	sed -i "/CFLAGS_NATIVE            += -s/d" src/Makefile || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
}
