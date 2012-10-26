# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
USE_RUBY="ruby18 ruby19"

inherit ruby-ng mercurial

DESCRIPTION="Metasm is a cross-architecture assembler, disassembler, compiler, linker and debugger"
HOMEPAGE="http://metasm.cr0.org/"
SRC_URI=""
#EGIT_REPO_URI="http://github.com/jjyg/${PN}.git"
EHG_REPO_URI="https://code.google.com/p/metasm/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

RDEPEND="dev-ruby/ruby-gtk2"
DEPEND="${RDEPEND}"

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
