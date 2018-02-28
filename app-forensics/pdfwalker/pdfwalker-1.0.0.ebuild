# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23"

RUBY_FAKEGEM_NAME="origami"
RUBY_FAKEGEM_TASK_TEST="test"

inherit ruby-fakegem

DESCRIPTION="PDFWalker is a GTK frontend to explore the internals of a PDF document with Origami"
HOMEPAGE="https://github.com/gdelugre/pdfwalker"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="test"

ruby_add_bdepend "test? ( dev-ruby/minitest:5 )"

ruby_add_rdepend ">=app-forensics/origami-pdf-2.1.0
					=dev-ruby/ruby-gtk2-3.1*"
#					dev-ruby/ruby-gtkhex"


all_ruby_install() {
	all_fakegem_install

	#Gentoo bug, remove links to directories
	rm "${ED}usr/bin"/shell
	rm "${ED}usr/bin"/gui
	rm "${ED}usr/bin"/config

}
