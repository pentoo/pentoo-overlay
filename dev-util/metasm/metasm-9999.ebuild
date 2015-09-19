# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
USE_RUBY="ruby19 ruby20 ruby21"

inherit ruby-ng mercurial

DESCRIPTION="Metasm is a cross-architecture assembler, disassembler, compiler, linker and debugger"
HOMEPAGE="http://metasm.cr0.org/"
SRC_URI=""
EHG_REPO_URI="https://www.cr0.org/progs/metasm/hg/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

ruby_add_rdepend "dev-ruby/ruby-gtk2"

ruby-ng_src_prepare(){
	einfo "running prepare"
}

each_ruby_install() {
	doruby -r metasm.rb metasm || die "install failed"
}

all_ruby_install() {
	dodoc BUGS CREDITS README TODO doc/*.txt doc/*/*
	insopts -m 0655
	insinto /usr/lib/"${PN}"
	cd samples
	doins -r * || die "failed to install scripts"
	cd ../misc
	doins -r * || die "failed to install scripts"
	cd ../tests
	doins -r * || die "failed to install scripts"
	dodir /usr/bin
	dosym ../lib/"${PN}"/disassemble.rb /usr/bin/disassemble
	dosym ../lib/"${PN}"/disassemble-gui.rb /usr/bin/disassemble-gui
	dobin "${FILESDIR}"/metasm
}
