# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

USE_RUBY="ruby20 ruby21"
inherit ruby-ng git-r3

DESCRIPTION="Cross-architecture assembler, disassembler, compiler, linker and debugger"
HOMEPAGE="http://metasm.cr0.org/"
EGIT_REPO_URI="https://github.com/jjyg/metasm.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

ruby_add_rdepend "dev-ruby/ruby-gtk2"

EGIT_CHECKOUT_DIR="${WORKDIR}/all"

each_ruby_install() {
	doruby -r metasm.rb metasm
}

all_ruby_install() {
	insinto /usr/$(get_libdir)/"${PN}"
	doins -r {samples,misc,tests}

	fperms +x /usr/$(get_libdir)/"${PN}"/samples/disassemble*

	dodir /usr/bin
	dosym /usr/$(get_libdir)/"${PN}"/samples/disassemble.rb /usr/bin/disassemble
	dosym /usr/$(get_libdir)/"${PN}"/samples/disassemble-gui.rb /usr/bin/disassemble-gui
	dobin "${FILESDIR}"/metasm

	dodoc BUGS CREDITS README TODO doc/*.txt doc/*/*
}
