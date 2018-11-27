# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Python tools and patched firmware for the TYT-MD380"
HOMEPAGE="https://github.com/travisgoodspeed/md380tools"
EGIT_REPO_URI="https://github.com/travisgoodspeed/md380tools.git"

LICENSE="IPA BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""
PDEPEND="sys-devel/gcc-arm-none-eabi"

src_compile() {
	true
}

src_install() {
	rm 99-md380.rules
	dodir /usr/sbin
	cat <<-EOF > "${ED}"/usr/sbin/md380-make
	#!/bin/sh
	pushd "/usr/share/${PN}"
	make -f Makefile "\$@"
	EOF
	fperms +x /usr/sbin/md380-make

	insinto "/usr/share/${PN}"
	doins -r *
}
