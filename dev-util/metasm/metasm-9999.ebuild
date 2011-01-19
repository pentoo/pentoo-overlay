# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

USE_RUBY="ruby18 ruby19"

inherit ruby-ng git

DESCRIPTION="Metasm is a cross-architecture assembler, disassembler, compiler, linker and debugger"
HOMEPAGE="http://metasm.cr0.org/"
SRC_URI=""
EGIT_REPO_URI="http://github.com/jjyg/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

RDEPEND="dev-ruby/rubygems
	 dev-ruby/ruby-gtk2"
DEPEND="${RDEPEND}"

each_ruby_install() {
	# Ugly WA to make git&ruby works together
	cd "${WORKDIR}/${P}"
	doruby -r metasm.rb metasm || die "install failed"
}

all_ruby_install() {
	cd "${WORKDIR}/${P}"
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
